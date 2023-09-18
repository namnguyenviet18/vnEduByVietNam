
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vnedu/controller/appbar_provider.dart';
import 'package:vnedu/modal/intro_infor.dart';
import 'package:vnedu/new_and_event_component/news_and_events_item.dart';
import 'package:vnedu/notification_component/notification_dialog.dart';
import 'package:vnedu/screens/introduce_screen.dart';
import 'package:vnedu/screens/login_screen.dart';
import 'package:vnedu/screens/news_screen.dart';
import 'package:vnedu/shared/card_notify.dart';
import 'package:vnedu/shared/custom_button.dart';
import 'package:vnedu/shared/indicator.dart';
import 'package:vnedu/shared/information.dart';
import 'package:vnedu/shared/mo_ta_nen_tang_day_truc_tuyen.dart';
import 'package:vnedu/shared/overall_for_home_page.dart';
import 'package:vnedu/shared/page_view_album.dart';
import 'package:vnedu/shared/profile_menu.dart';
import 'package:vnedu/shared/study_corner_details.dart';
import 'package:vnedu/shared/welcome.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';

class SchoolYardScreen extends StatefulWidget {
  const SchoolYardScreen({super.key, required this.isLogged});
  final bool isLogged;


  @override
  State<SchoolYardScreen> createState() => _SchoolYardScreenState();

}

class _SchoolYardScreenState extends State<SchoolYardScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  final PageController pageAlbumController = PageController(initialPage: 0);
  final PageController pageNewController = PageController(initialPage: 0);


  List<PageViewAlbum> getListAlbumImage(AppBarNotifier appBarNotifier) {
    List<PageViewAlbum> listImage = [];
    int i = 1;
    while(i < appBarNotifier.albums.length) {
      if(i + 1 == appBarNotifier.albums.length) {
        listImage.add(
            PageViewAlbum(
                imageUrl1: appBarNotifier.albums[i].imageUrl,
                imageUrl2: null
            )
        );
      }else if(i + 1 < appBarNotifier.albums.length){
        listImage.add(
            PageViewAlbum(
                imageUrl1: appBarNotifier.albums[i].imageUrl,
                imageUrl2: appBarNotifier.albums[i+1].imageUrl,
            )
        );
      }
      i += 2;
    }
    return listImage;
  }

  List<NewAndEventItem> getListNew(AppBarNotifier appBarNotifier) {
    List<NewAndEventItem> listNew = [];
    for(int i = 0; i < min(5, appBarNotifier.listNewsAndEvents.length); i++) {
      listNew.add(NewAndEventItem(newsAndEvents: appBarNotifier.listNewsAndEvents[i], isLogged: widget.isLogged,));
    }
    return listNew;
  }


  @override
  Widget build(BuildContext context) {

    return Consumer<AppBarNotifier>(
      builder: (context, appbarNotifier, child) {
        return SafeArea(
          child: !appbarNotifier.isLoading ? Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                leading: ClipOval(
                  child: Image.network(
                    parse(parse(appbarNotifier.introInformation?.logoImage).body?.text).documentElement!.text,
                    width: 25,
                    height: 25,
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
                          onTap: () {
                            appbarNotifier.changedOption(0);
                            appbarNotifier.getListNotification();
                          },
                          child: Icon(
                              Icons.notifications,
                              size: 25, color: appbarNotifier.choices[0] ? Colors.blue[900] : Colors.blue[300])
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
                            ): Image.asset('assets/images/img.png', width: 35, height: 35,),
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
              body:  Stack(
                children: [
                  GestureDetector(
                    onTap: () => appbarNotifier.refresh(),
                    child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const WelCome(),
                              const SizedBox(height: 15,),
                              CardNotify(
                                  newBoards: appbarNotifier.newBoards,
                                  onTapShowAll: () {
                                    appbarNotifier.getDataForNewBoardPage().then((value) {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                          NewsScreen(
                                            isLogged: widget.isLogged,
                                          )));
                                    });
                                  },
                              ),
                              const SizedBox(height: 20,),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: const Text(
                                  'VÀI NÉT GIỚI THIỆU VỀ TRƯỜNG MẦM NON AN PHÚ',
                                  style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(height: 10,),

                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  appbarNotifier.introInformation != null ? parse(parse(appbarNotifier.introInformation?.aboutUs).body?.text).documentElement!.text : '',
                                  style: const TextStyle(
                                      color: Colors.black54, fontSize: 14, fontWeight: FontWeight.normal
                                  ),
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              const SizedBox(height: 10,),

                              Padding(
                                padding: const EdgeInsets.only(left: 15, right: 15),
                                child: ElevatedButton(
                                    onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                            IntroduceScreen(
                                              isLogged: widget.isLogged,
                                            )));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: Size(MediaQuery.of(context).size.width * 0.4, 40),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.elliptical(5, 8)),
                                          side: BorderSide(width: 1, color: Colors.blue),
                                        ),
                                        backgroundColor: Colors.white
                                    ),
                                    child: Text(
                                      'Xem chi tiết',
                                      style: TextStyle(color: Colors.blue[900], fontSize: 16, fontWeight: FontWeight.w500),
                                    )
                                ),
                              ),
                              const SizedBox(height: 20,),
                              OverallForHomePage(overall: appbarNotifier.overall),
                              const SizedBox(height: 30,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 200,
                                      child: Image.network(
                                        appbarNotifier.albums[0].imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 5,),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 100,
                                      child:  PageView(

                                        onPageChanged: (index) {
                                          appbarNotifier.setSelectedPageAlbum(index);
                                        },
                                        controller: pageAlbumController,
                                        scrollDirection: Axis.horizontal,
                                        children: getListAlbumImage(appbarNotifier),
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: List.generate(getListAlbumImage(appbarNotifier).length, (index) =>
                                          Indicator(isActive: appbarNotifier.selectedPageAlbum == index ? true : false)
                                      ),
                                    ),
                                    const SizedBox(height: 30,),
                                  ]
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  'TIN TỨC - SỰ KIỆN',
                                  style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 400,
                                      child:  PageView(
                                        onPageChanged: (index) {
                                          appbarNotifier.setSelectedPageNewAndEvent(index);
                                        },
                                        controller: pageNewController,
                                        scrollDirection: Axis.horizontal,
                                        children: getListNew(appbarNotifier)
                                      ),
                                    ),
                                    const SizedBox(height: 12,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: List.generate(getListNew(appbarNotifier).length, (index) =>
                                          Indicator(isActive: appbarNotifier.selectedPageNewAndEvent == index ? true : false)
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30,),
                              const DescribeLearningOnlinePlatform(),
                              Information(introInformation: appbarNotifier.introInformation),
                            ]
                        )
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
                    child: NotificationDialog(notifications: appbarNotifier.notifications, existParent: false),
                  ),
                  if(appbarNotifier.choices[2]) const ProfileMenu(currentPage: null,)
                ],
              )
          ): const Scaffold(
            body: Center(child: CircularProgressIndicator(),),
          ),
        );
      },
    );
  }

}
