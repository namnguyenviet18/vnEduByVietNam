

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vnedu/connectivity_service.dart';
import 'package:vnedu/const/constant.dart';
import 'package:vnedu/controller/appbar_provider.dart';
import 'package:vnedu/controller/chang_image_provider.dart';
import 'package:vnedu/controller/profile_provider.dart';
import 'package:vnedu/controller/update_user_provider.dart';
import 'package:vnedu/modal/check_ekyc.dart';
import 'package:vnedu/modal/intro_infor.dart';
import 'package:vnedu/modal/user_profile.dart';
import 'package:vnedu/screens/login_screen.dart';
import 'package:vnedu/screens/school_yard_screen.dart';
import 'package:vnedu/shared/custom_button.dart';
import 'package:vnedu/shared/format_date.dart';
import 'package:vnedu/shared/infor_user_details.dart';
import 'package:vnedu/shared/information.dart';
import 'package:vnedu/shared/profile.dart';
import 'package:vnedu/shared/profile_menu.dart';
import 'package:vnedu/shared/study_corner_details.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';
import 'package:vnedu/shared/update_user.dart';


class MyProfileScreen extends StatefulWidget {
  MyProfileScreen({super.key, required this.isLogged, required this.userProfile, required this.introInformation});
  final bool isLogged;
  UserProfile? userProfile;
  IntroInformation? introInformation;
  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {


  final connectivityService = ConnectivityService();
  bool isConnected = false;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // connectivityService.checkConnectivity();
    // connectivityService.addCallBack((isConnected) {
    //   setState(() {
    //     this.isConnected = isConnected;
    //   });
    // });


  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('disposed');
    connectivityService.removeCallBack((isConnected) {
    });
  }



  @override
  Widget build(BuildContext context) {
    ///Provider.of<ProfileNotifier>(context, listen: false).changedNotUpdate(true);
    final imgIdentify = Provider.of<ChangeImageProvider>(context, listen: false);
    print('build');
    return Consumer<AppBarNotifier>(
      builder: (context, appbarNotifier, child) {
        return SafeArea(
            child: Scaffold(
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
                toolbarHeight: 60,
                backgroundColor: Colors.white,
              ),
              body: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: Colors.grey.withOpacity(0.2),
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                const Icon(Icons.add_home_outlined, color: Colors.blue, size: 20,),
                                const SizedBox(width: 7,),
                                InkWell(
                                  onTap: () {
                                    Provider.of<ProfileNotifier>(context, listen: false).reFresh();
                                    final controller = Provider.of<AppBarNotifier>(context, listen: false);
                                    controller.getData().then((value) {
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                                          SchoolYardScreen(isLogged: widget.isLogged)));
                                    });

                                  },

                                  child: const Text(
                                    'Trang chủ >',
                                    style: TextStyle(color: Colors.blue, fontSize: 15),
                                  ),
                                ),
                                const SizedBox(width: 7,),
                                Text(
                                  widget.userProfile != null ? widget.userProfile?.ten : '',
                                  style: const TextStyle(color: Colors.black, fontSize: 15),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            child: appbarNotifier.notUpdate ? Profile(userProfile: appbarNotifier.userProfile) :
                            UpdateUser(userProfile: appbarNotifier.userProfile),
                          ),
                          const SizedBox(height: 15,),
                          Information(introInformation: appbarNotifier.introInformation,)

                        ],
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
                    if(appbarNotifier.choices[0]) Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.6,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Colors.white
                        ),
                        child: Stack(
                          children: [

                          ],
                        )
                    ),
                    if(appbarNotifier.choices[2]) const ProfileMenu(currentPage: 'pf',)
                  ]
              ),
            )
        );
      },
    );
  }

}