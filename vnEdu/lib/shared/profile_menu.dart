

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vnedu/controller/appbar_provider.dart';
import 'package:vnedu/controller/chang_image_provider.dart';
import 'package:vnedu/controller/update_user_provider.dart';
import 'package:vnedu/modal/intro_infor.dart';
import 'package:vnedu/modal/overall.dart';
import 'package:vnedu/modal/user_profile.dart';
import 'package:vnedu/screens/my_profile_screen.dart';
import 'package:vnedu/screens/school_yard_screen.dart';
import 'package:vnedu/shared/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key, required this.currentPage});
  final String? currentPage;
  void logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AppBarNotifier>(context, listen: false);
    final checkEkys = Provider.of<ChangeImageProvider>(context, listen: false);
    return Positioned(
      left: MediaQuery.of(context).size.width * 0.27,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.55,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
          child: Column(
            children: [
              ButtonProfile(
                  icon: Icons.folder_open_outlined,
                  title: 'Hồ sơ cá nhân',
                  onPress: currentPage == 'pf' ? null : () {
                    controller.refresh();
                    checkEkys.getCheckEkyc().then((value) {
                      final updateProvider = Provider.of<UpdateUserNotifier>(context, listen: false);
                      if(controller.userProfile?.gioiTinh == 1) {
                        updateProvider.setSex('Nữ');
                      }else if(controller.userProfile?.gioiTinh == 0) {
                        updateProvider.setSex('Nam');
                      }
                      if(controller.userProfile?.publicSensInfor == 1) {
                        updateProvider.setIsShowSDT(true);
                      }else {
                        updateProvider.setIsShowSDT(false);
                      }
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                          MyProfileScreen(userProfile: controller.userProfile, introInformation: controller.introInformation, isLogged: true,)
                      ));
                    });
                  }
              ),
              const Divider(color: Colors.grey, height: 1,),
              ButtonProfile(
                icon: Icons.shopping_cart_outlined,
                title: 'Đơn hàng',
                onPress: () { },
              ),
              const Divider(color: Colors.grey, height: 1,),
              ButtonProfile(
                icon: Icons.check_box_outline_blank,
                title: 'Dịch vụ của tôi',
                onPress: () { },
              ),
              const Divider(color: Colors.grey, height: 1,),
              ButtonProfile(
                icon: Icons.login_outlined,
                title: 'Đăng xuất',
                onPress: () {
                  controller.refresh();
                  logOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) => const SchoolYardScreen(
                      isLogged: false,
                    )),
                        (Route<dynamic> route) => false,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

}