

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vnedu/const/constant.dart';
import 'package:vnedu/controller/appbar_provider.dart';
import 'package:vnedu/modal/intro_infor.dart';
import 'package:vnedu/modal/overall.dart';
import 'package:vnedu/screens/login_screen.dart';
import 'package:vnedu/screens/school_yard_screen.dart';
import 'package:vnedu/shared/custom_button.dart';
import 'package:html/parser.dart';
import 'package:vnedu/shared/information.dart';
import 'package:vnedu/shared/overall_for_home_page.dart';
import 'package:vnedu/shared/profile_menu.dart';
import 'package:vnedu/shared/study_corner_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class IntroduceScreen extends StatefulWidget {
  const IntroduceScreen({super.key, required this.isLogged});
  final bool isLogged;

  @override
  State<IntroduceScreen> createState() => _IntroduceScreenState();
}

class _IntroduceScreenState extends State<IntroduceScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppBarNotifier>(
        builder: (context, appBarNotifier, Widget? child) {
          return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  leading: ClipOval(
                    child: Image.network(
                      parse(parse(appBarNotifier.introInformation?.logoImage).body
                          ?.text).documentElement!.text,
                      width: 30,
                      height: 30,
                    ),
                  ),
                  title: SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.3,
                      child: Text(
                        parse(parse(appBarNotifier.introInformation?.logoText).body
                            ?.text).documentElement!.text,
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
                            onTap: () => appBarNotifier.changedOption(0),
                            child: Icon(Icons.notifications, size: 25,
                                color: appBarNotifier.choices[0]
                                    ? Colors.blue[900]
                                    : Colors.blue[300])
                        ),
                        const SizedBox(width: 15,),
                        InkWell(
                            onTap: () => appBarNotifier.changedOption(1),
                            child: Icon(Icons.shopping_basket, size: 25,
                                color: appBarNotifier.choices[1]
                                    ? Colors.blue[900]
                                    : Colors.blue[300])
                        ),
                        const SizedBox(width: 15,),
                        InkWell(
                            onTap: () => appBarNotifier.changedOption(2),
                            child: ClipOval(
                              child: Image.network(
                                parse(parse(appBarNotifier.userProfile?.avt).body
                                    ?.text).documentElement!.text,
                                width: 35,
                                height: 35,
                              ),
                            )
                        )
                      ],
                    )
                        : GestureDetector(
                        onTap: () => appBarNotifier.changedOption(3),
                        child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 7),
                            child: Image.asset(
                              'assets/images/quoc_ki.png', width: 30, height: 25,))
                    ),

                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 7),
                      child: IconButton(
                          icon: appBarNotifier.choices[4] ? const Icon(
                            Icons.close, size: 25, color: Colors.black54,) :
                          const Icon(
                            Icons.menu_outlined, size: 25, color: Colors.black54,),
                          onPressed: () => appBarNotifier.changedOption(4)
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              height: 35,
                              padding: const EdgeInsets.symmetric(horizontal: 7),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.add_home_outlined, color: Colors.blue,
                                    size: 20,),
                                  const SizedBox(width: 7,),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                            return SchoolYardScreen(
                                                isLogged: widget.isLogged);
                                          }));
                                    },
                                    child: const Text(
                                      'Trang chủ >',
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 15),
                                    ),
                                  ),
                                  const SizedBox(width: 7,),
                                  const Text(
                                    'Giới thiệu',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            const Text(
                              'Giới thiệu',
                              style: TextStyle(color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 15,),
                            Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey, width: 1)
                              ),
                              child: Text(
                                appBarNotifier.introInformation != null ? parse(parse(appBarNotifier.introInformation?.aboutUs).body?.text).documentElement!.text : '',
                                style: const TextStyle(
                                    color: Colors.black54, fontSize: 17, fontWeight: FontWeight.normal
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            OverallForHomePage(overall: appBarNotifier.overall,),
                            const SizedBox(height: 20,),
                            Information(introInformation: appBarNotifier.introInformation)
                          ],
                        ),
                      ),
                      if(appBarNotifier.choices[4] && widget.isLogged)
                        Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ButtonMenu(context, 'Sân trường ', () {print('san truong');}),
                                const Divider(color: Colors.grey,height: 1,),
                                ButtonMenu(context, 'Kho học liệu ', () { }),
                                const Divider(color: Colors.grey,height: 1,),
                                InkWell(
                                  onTap: () => appBarNotifier.changedShowStudyCornerDetails(),
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
                                          appBarNotifier.isShowStudyCornerDetails ?
                                          const Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 25,):
                                          const Icon(Icons.keyboard_arrow_up, color: Colors.grey, size: 25,)
                                        ],
                                      )
                                  ),
                                ),
                                const Divider(color: Colors.grey,height: 1,),
                                if(appBarNotifier.isShowStudyCornerDetails) const StudyCornerDetails(),
                                ButtonMenu(context, 'Đấu trường', () { }),
                              ],
                            ),
                          ),
                        ),
                      if(appBarNotifier.choices[4] && !widget.isLogged) Container(
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
                      if(appBarNotifier.choices[0]) Container(
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
                      if(appBarNotifier.choices[2]) const ProfileMenu(currentPage: null,)
                    ]
                ),
              )
          );
        },
    );
  }



}