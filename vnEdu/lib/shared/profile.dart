

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vnedu/controller/appbar_provider.dart';
import 'package:vnedu/controller/profile_provider.dart';
import 'package:vnedu/modal/user_profile.dart';
import 'package:vnedu/shared/custom_button.dart';
import 'package:vnedu/shared/format_date.dart';
import 'package:vnedu/shared/infor_user_details.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  final UserProfile? userProfile;
  const Profile({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'THÔNG TIN HỌC SINH',
          style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 15,),
        ButtonUpdateUser(onPress: () {
          Provider.of<AppBarNotifier>(context, listen: false).changedNotUpdate(false);
        },),
        const SizedBox(height: 10,),
        const Divider(color: Colors.grey, height: 1,),
        const SizedBox(height: 20,),
        Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Column(
            children: [
              ClipOval(
                child: Image.network(
                  parse(parse(userProfile?.avt).body?.text).documentElement!.text,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 15,),
              Text(
                userProfile?.ten,
                style: const TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        const SizedBox(height: 20,),
        InformationUserDetails(type: 'Họ và tên', value: userProfile?.ten),
        const SizedBox(height: 15,),
        InformationUserDetails(type: 'Ngày sinh', value: formatDate_dd_mm_yyyy(userProfile?.ngaySinh)),
        const SizedBox(height: 15,),
        InformationUserDetails(type: 'Giới tính', value: userProfile?.gioiTinh == 1 ? 'Nữ' : 'Nam'),
        const SizedBox(height: 15,),
        InformationUserDetails(type: 'Đơn vị', value: userProfile?.donVi),
        const SizedBox(height: 15,),
        InformationUserDetails(type: 'Khối học', value: userProfile?.khoiHoc),
        const SizedBox(height: 15,),
        InformationUserDetails(type: 'Lớp học', value: userProfile?.lopHoc),
        const SizedBox(height: 15,),
        InformationUserDetails(type: 'Tên đăng nhập', value: userProfile?.tenDangNhap),
        const SizedBox(height: 15,),
        InformationUserDetails(type: 'Số điện thoại', value: userProfile?.soDienThoai),
        const SizedBox(height: 15,),
        InformationUserDetails(type: 'Email', value: userProfile?.email),
        const SizedBox(height: 15,),
        InformationUserDetails(type: 'Địa chi', value: userProfile?.diaChi),
        const SizedBox(height: 15,),
      ],
    );
  }

}