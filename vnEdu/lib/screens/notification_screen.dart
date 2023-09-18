


import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vnedu/controller/appbar_provider.dart';
import 'package:vnedu/controller/notification_provider.dart';
import 'package:vnedu/modal/notification.dart';
import 'package:vnedu/new_and_event_component/custom_check_box.dart';
import 'package:vnedu/notification_component/button_indicate_group_notification.dart';
import 'package:vnedu/notification_component/dialog_confirm_deletion.dart';
import 'package:vnedu/notification_component/notification_dialog.dart';
import 'package:vnedu/notification_component/notification_element_for_screen.dart';
import 'package:vnedu/notification_component/notifications_empty.dart';
import 'package:vnedu/notification_component/notifications_type_options.dart';
import 'package:vnedu/notification_component/order_dialog.dart';
import 'package:vnedu/screens/login_screen.dart';
import 'package:vnedu/screens/school_yard_screen.dart';
import 'package:vnedu/shared/custom_button.dart';
import 'package:vnedu/shared/information.dart';
import 'package:vnedu/shared/profile_menu.dart';
import 'package:vnedu/shared/study_corner_details.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key, required this.isLogged});
  final bool isLogged;
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();

}

class _NotificationScreenState extends State<NotificationScreen> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.animateTo(
        0.0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    });
  }

  List<Widget> getListNotificationWidget(NotificationNotifier notificationNotifier) {
    List<Widget> res = [];
    for(int i = 0; i < notificationNotifier.notifications.length; i++) {
      res.add(
        NotificationElement(
          notification: notificationNotifier.notifications[i],
          isSelected: notificationNotifier.selectElementController[i],
          onChanged: () {
            notificationNotifier.updateOnlySelectElement(i);
          }
        )
      );
      res.add(const SizedBox(height: 20,));
    }
    return res;
  }


  List<Widget> getListIndicateGroupNotification(NotificationNotifier notificationNotifier) {
    List<Widget> res = [];
    for(int i = 0; i < min(notificationNotifier.listGroup.length, notificationNotifier.totalNotifications / 6); i++) {
      String start = ((notificationNotifier.listGroup[i] - 1) * 6).toString();
      res.add(
          ButtonIndicate(
            onPress: () {
              print('press $i');
              notificationNotifier.updateCurrentGroup(notificationNotifier.listGroup[i]);
              notificationNotifier.getNotifications(start);
            },
            order: notificationNotifier.listGroup[i].toString(),
          )
      );
    }
    return res;
  }



  @override
  Widget build(BuildContext context) {
    final appbarNotifier = Provider.of<AppBarNotifier>(context, listen: true);
    return SafeArea(
      child: !appbarNotifier.isLoading ? Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: ClipOval(
              child: Image.network(
                parse(parse(appbarNotifier.introInformation?.logoImage).body?.text).documentElement!.text,
                width: 30,
                height: 30,
              ),
            ),
            title: SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Text(
                  parse(parse(appbarNotifier.introInformation?.logoText).body?.text).documentElement!.text,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                )
            ),
            actions: [
              widget.isLogged ?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () => appbarNotifier.changedOption(0),
                      child: Icon(Icons.notifications, size: 25, color: appbarNotifier.choices[0] ? Colors.blue[900] : Colors.blue[300])
                  ),
                  const SizedBox(width: 15,),
                  InkWell(
                      onTap: () => appbarNotifier.changedOption(1),
                      child: Icon(Icons.shopping_basket, size: 25, color: appbarNotifier.choices[1] ? Colors.blue[900] : Colors.blue[300])
                  ),
                  const SizedBox(width: 15,),
                  InkWell(
                      onTap: () => appbarNotifier.changedOption(2),
                      child: ClipOval(
                        child: appbarNotifier.userProfile?.avt != null ? Image.network(
                          parse(parse(appbarNotifier.userProfile?.avt).body?.text).documentElement!.text,
                          width: 35,
                          height: 35,
                        ): Image.asset('appbarNotifier.userProfile?.avt', width: 35, height: 35,),
                      )
                  )
                ],
              )
                  : GestureDetector(
                  onTap: () => appbarNotifier.changedOption(3),
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 7),
                      child: Image.asset('assets/images/quoc_ki.png', width: 30, height: 25,))
              ),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 7),
                child: IconButton(
                    icon: appbarNotifier.choices[4] ? const Icon(Icons.close, size: 25, color: Colors.black54,) :
                    const Icon(Icons.menu_outlined, size: 25, color: Colors.black54,),
                    onPressed: () => appbarNotifier.changedOption(4)
                ),
              )
            ],
            backgroundColor: Colors.white,
            toolbarHeight: 60,
          ),
          body:  Consumer<NotificationNotifier>(
            builder: (context, notificationNotifier, child) {
              return Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      appbarNotifier.refresh();
                      notificationNotifier.updateIsOpenOrderDialog(false);
                    },
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      controller: _controller,
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.grey.withOpacity(0.2),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                height: 35,
                                padding: const EdgeInsets.symmetric(horizontal: 7),
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    const Icon(Icons.home_outlined, color: Colors
                                        .blue, size: 20,),
                                    const SizedBox(width: 7,),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                                            SchoolYardScreen(isLogged: widget.isLogged)));
                                      },
                                      child: const Text(
                                        'Trang chủ >',
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 15),
                                      ),
                                    ),
                                    const SizedBox(width: 7,),
                                    const Text(
                                      'Danh sách thông báo',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    )
                                  ],
                                ),
                              ),

                              const SizedBox(height: 25,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: NotificationTypeOptions(
                                  type: notificationNotifier.selectNotificationType,
                                  totalNotifications: notificationNotifier.totalNotifications,
                                  notificationNotifier: notificationNotifier,
                                ),
                              ),

                              const SizedBox(height: 15,),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(8))
                                    ),
                                    color: Colors.white,
                                    child: notificationNotifier.notifications.isEmpty ? const NotificationsEmpty() :
                                    Column(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          margin:  EdgeInsets.only(top: 20, left: 10),
                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                          child: Row(
                                            mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomCheckBox(
                                                  isChecked: notificationNotifier.isSelectedAllNotify,
                                                  onChange: () => notificationNotifier.onClickSelectAll()
                                              ),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Visibility(
                                                      visible: notificationNotifier.selectElementController
                                                          .where((element) => element == true).isNotEmpty,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Map<String, String> notificationIds = {};
                                                          for(int i = 0; i < notificationNotifier.notifications.length; i++) {
                                                            if(notificationNotifier.selectElementController[i]) {
                                                              notificationIds['ids[]'] = notificationNotifier.notifications[i].id;
                                                            }
                                                          }
                                                          showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                content: ConstrainedBox(
                                                                  constraints: const BoxConstraints(maxHeight: 300.0), // Giới hạn chiều dài tối đa là 300
                                                                  child: DialogConfirmDeletion(
                                                                      notificationIds: notificationIds,
                                                                      notificationNotifier: notificationNotifier
                                                                  ), // Nội dung của bạn
                                                                ),
                                                              );
                                                            }
                                                          );
                                                        },
                                                        child: SvgPicture.network(
                                                          "http://lms-school-node1.vnpt.edu.vn/app/assets/img/delete.svg?v=20230913153300",
                                                          width: 25,
                                                          height: 25,
                                                        ),
                                                      )
                                                  ),

                                                  SizedBox(width: MediaQuery.of(context).size.width * 0.1,),

                                                  Visibility(
                                                      visible: notificationNotifier.selectElementController
                                                          .where((element) => element == true).isNotEmpty,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          List<String> notificationIds = [];
                                                          Map<String, String> body = {};
                                                          for(int i = 0; i < notificationNotifier.notifications.length; i++) {
                                                            if(notificationNotifier.selectElementController[i]) {
                                                              notificationIds.add('"${notificationNotifier.notifications[i].id}"');
                                                            }
                                                          }
                                                          body['ids'] = [notificationIds].toString();
                                                          print([notificationIds].toString());
                                                          notificationNotifier.handleMarkRead(body);
                                                        },
                                                        child: SvgPicture.network(
                                                          "http://lms-school-node1.vnpt.edu.vn/app/assets/img/email_read.svg?v=20230913153300",
                                                          width: 25,
                                                          height: 25,
                                                        ),
                                                      )
                                                  ),

                                                  SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
                                                  GestureDetector(
                                                    onTap: () => notificationNotifier.updateIsOpenOrderDialog(!notificationNotifier.isOpenOderDialog),
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width * 0.35,
                                                      height: 40,
                                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                                      decoration: BoxDecoration(
                                                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                                                          border: Border.all(width: 1, color: Colors.grey)
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(
                                                            notificationNotifier.order[notificationNotifier.selectedOrder],
                                                            style: const TextStyle(color: Colors.black87, fontSize: 16),
                                                          ),
                                                          const Icon(Icons.keyboard_arrow_down_outlined, size: 20, color: Colors.grey,)
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20,),

                                        Column(
                                            children: getListNotificationWidget(notificationNotifier)
                                        ),

                                        const SizedBox(height: 50,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            if(notificationNotifier.currentGroup > 1)
                                              GestureDetector(
                                                  onTap: () {
                                                    notificationNotifier.decreaseCurrentGroup();
                                                    String start = ((notificationNotifier.currentGroup - 1) * 6).toString();
                                                    notificationNotifier.getNotifications(start);
                                                  },
                                                  child: Container(
                                                      alignment: Alignment.centerLeft,
                                                      padding: const EdgeInsets.only(right: 8),
                                                      child: const Icon(Icons.chevron_left, size: 20, color: Colors.blue,))
                                              ),
                                            Row(
                                              //mainAxisAlignment: MainAxisAlignment.center,
                                                children: getListIndicateGroupNotification(notificationNotifier)
                                            ),
                                            if(notificationNotifier.currentGroup < (notificationNotifier.totalNotifications/6).ceil())
                                              GestureDetector(
                                                  onTap: () {
                                                    notificationNotifier.increaseCurrentGroup();
                                                    String start = ((notificationNotifier.currentGroup - 1) * 6).toString();
                                                    notificationNotifier.getNotifications(start);
                                                  },
                                                  child: Container(
                                                      alignment: Alignment.centerRight,
                                                      padding: const EdgeInsets.only(left: 8),
                                                      child: const Icon(Icons.chevron_right, size: 20, color: Colors.blue,))
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 15,)
                                      ],
                                    )
                                ),
                              ),

                              const SizedBox(height: 30,),
                              Information(introInformation: appbarNotifier.introInformation)
                            ],
                          ),
                          if(notificationNotifier.isOpenOderDialog) Positioned(
                            top: 295,
                            right: MediaQuery.of(context).size.width * 0.1149,
                            child: OrderDialog(
                              notificationNotifier: notificationNotifier,
                              width: MediaQuery.of(context).size.width * 0.35,
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                  if(appbarNotifier.choices[4] && widget.isLogged)
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ButtonMenu(context, 'Sân trường ', () {}),
                            const Divider(color: Colors.grey,height: 1,),
                            ButtonMenu(context, 'Kho học liệu ', () { }),
                            const Divider(color: Colors.grey,height: 1,),
                            InkWell(
                              onTap: () => appbarNotifier.changedShowStudyCornerDetails(),
                              child: Container(
                                  padding: const EdgeInsets.only(left: 5, right: 30),
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  color: Colors.white,
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Góc học tập',  style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                                      ),
                                      appbarNotifier.isShowStudyCornerDetails ?
                                      const Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 25,):
                                      const Icon(Icons.keyboard_arrow_up, color: Colors.grey, size: 25,)
                                    ],
                                  )
                              ),
                            ),
                            const Divider(color: Colors.grey,height: 1,),
                            if(appbarNotifier.isShowStudyCornerDetails) const StudyCornerDetails(),
                            ButtonMenu(context, 'Đấu trường', () { }),
                          ],
                        ),
                      ),
                    ),
                  if(appbarNotifier.choices[4] && !widget.isLogged) Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: 270,
                    child: Column(
                      children: [
                        ButtonMenu(context, 'Kho học liệu', () {

                        }),
                        const Divider(color: Colors.grey, height: 1,),
                        const SizedBox(height: 100,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ButtonLogOrRegis(logType: false, title: 'Đăng ký', onPress: () {

                            }),
                            ButtonLogOrRegis(logType: true, title: 'Đăng nhập', onPress: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              const LoginScreen(rootScreenId: 1)
                              ));
                            })
                          ],
                        )
                      ],
                    ),
                  ),
                  if(appbarNotifier.choices[0]) Card(
                    color: Colors.white,
                    child: NotificationDialog(notifications: appbarNotifier.notifications, existParent: true),
                  ),
                  if(appbarNotifier.choices[2]) const ProfileMenu(currentPage: null,)
                ],
              );
            }
          )
      ): const Scaffold(
        body: Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}
