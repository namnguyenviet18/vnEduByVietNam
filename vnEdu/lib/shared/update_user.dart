

import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vnedu/const/constant.dart';
import 'package:vnedu/controller/appbar_provider.dart';
import 'package:vnedu/controller/chang_image_provider.dart';
import 'package:vnedu/controller/profile_provider.dart';
import 'package:vnedu/controller/update_user_provider.dart';
import 'package:vnedu/modal/check_ekyc.dart';
import 'package:vnedu/modal/user_profile.dart';
import 'package:vnedu/service_class.dart';
import 'package:vnedu/shared/custom_button.dart';
import 'package:html/parser.dart';
import 'package:vnedu/shared/disable_edit_infor.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:vnedu/shared/format_date.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:vnedu/shared/information.dart';



class UpdateUser extends StatefulWidget {
  const UpdateUser({
    super.key,
    required this.userProfile,
  });
  final UserProfile? userProfile;



  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  bool isBirthEmpty = false;
  final TextEditingController _controllerBirth = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword = TextEditingController();
  bool isShowPhoneNumber = false;
  
  Uri url = Uri.parse("https://hoc.vnedu.vn/");

  Future<void> _launchVnEduVn() async {
    if(!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> changeAvata(File  avt, String token, BuildContext context) async {
    var stream = ByteStream(avt.openRead());
    var length = avt.lengthSync();
    var uri = Uri.parse("http://lms-school-node1.vnpt.edu.vn/service/user/changeAvatar");
    var request = MultipartRequest("POST", uri);
    request.headers.addAll({
      Constants.AUTHORIZATION: token
    });

    var multipartFile = MultipartFile('file', stream, length, filename: basename(avt.path));
    request.files.add(multipartFile);
    var response = await request.send();

    if(response.statusCode == 200) {
      response.stream.transform(utf8.decoder).listen((event) {
        Map<String, dynamic> data = jsonDecode(event);
      });
    }else {
      print('fail');
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerBirth.text = formatDate_dd_mm_yyyy(widget.userProfile?.ngaySinh);
    _controllerPhone.text = widget.userProfile?.soDienThoai;
    _controllerAddress.text = widget.userProfile?.diaChi;
    //Provider.of<UpdateUserNotifier>( listen: false).onChangedBirth(formatDate_dd_mm_yyyy(widget.userProfile?.ngaySinh));
  }

  void updateBirth(BuildContext context, UpdateUserNotifier updateUserNotifier) async {
    final DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: DateFormat("dd-MM-yyyy").parse(_controllerBirth.text),
        firstDate: DateTime(1973),
        lastDate: DateTime(2100)
    );

    if(dateTime == null) return;
    _controllerBirth.text = DateFormat("dd-MM-yyyy").format(dateTime);
    updateUserNotifier.onChangedBirth(_controllerBirth.text);
  }

  Future<String> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = '';
    if (preferences.getString(Constants.TOKEN) != null) {
      token = preferences.getString(Constants.TOKEN)!;
    }
    return token;
  }

  bool isValidDetails(BuildContext context, UpdateUserNotifier x) {
    if(!x.isValidBirth) {
      return false;
    }else if(!x.isValidAddress) {
      return false;
    }else if(!x.isValidConfirmPassword) {
      return false;
    }else if(!x.isValidPassword) {
      return false;
    }
    return true;
  }

  Future<UserProfile?> editProfile(String token, String name, String address, String phone, String sex,
      String birthDay, String password, String rePassword, String checkPublic) async {
    Response response = await post(
      Uri.parse("http://lms-school-node1.vnpt.edu.vn/service/user/editProfile"),
      headers: <String, String> {
        Constants.AUTHORIZATION: token
      },
      body: <String, String> {
        "full_name": name,
        "address": address,
        "phone": phone,
        "gioi_tinh": sex,
        "birthday": birthDay,
        "password": password,
        "repassword": rePassword,
        "check_public": checkPublic
      }
    );

    if(response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      if(data['success']) {
        UserProfile userProfile = UserProfile(
          ten: data['data']['userProfileInfo']['full_name'],
          lopHoc: data['data']['userProfileInfo']['ten_lop'],
          diaChi: data['data']['userProfileInfo']['address'],
          donVi: data['data']['userInfo']['ten_don_vi'],
          imageId: data['data']['userProfileInfo']['image_id'],
          avt: data['data']['userProfileInfo']['avatar_url'],
          email: data['data']['userInfo']['email'],
          gioiTinh: data['data']['userProfileInfo']['gioi_tinh'],
          imageIdIdentify: data['data']['userProfileInfo']['image_id_identify'],
          imageUrlIdentify: data['data']['userProfileInfo']['image_url_identify'],
          khoiHoc: data['data']['userProfileInfo']['ten_khoi'],
          needChangeIdentifyImage: data['data']['userProfileInfo']['need_change_identify_image'],
          ngaySinh: data['data']['userProfileInfo']['birthday'],
          soDienThoai: data['data']['userProfileInfo']['phone'],
          tenDangNhap: data['data']['userProfileInfo']['full_name'],
          publicSensInfor: data['data']['userProfileInfo']['public_sens_info'],
        );
        return userProfile;
      }
    }else {
      print('fail');
    }
        
  }

  bool isValidDate(String date) {
    RegExp regExp = RegExp(
      r"^(0[1-9]|[12][0-9]|3[01])-[-]\d{4}$",
    );
    return regExp.hasMatch(date);
  }
  
  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateUserNotifier>(
      builder: (context, updateUserNotifier, child) {
        print('build');
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'THÔNG TIN HỌC SINH',
                style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 15,),
              ButtonSaveUpdate(
                onPress: () {
                  if(isValidDetails(context, updateUserNotifier)) {
                    getToken().then((token) {
                      editProfile(
                        token,
                        widget.userProfile?.ten,
                        _controllerAddress.text,
                        _controllerPhone.text,
                        updateUserNotifier.sex == 'Nam' ? "0" : "1",
                        formatDate_yyyy_mm_dd(_controllerBirth.text),
                        _controllerPassword.text,
                        _controllerConfirmPassword.text,
                        updateUserNotifier.isShowStd ? "1" : "0"
                      ).then((userProfile) {
                        final appbarProvider = Provider.of<AppBarNotifier>(context, listen: false);
                        appbarProvider.updateUserProfile(userProfile);
                      });
                    });
                  }
                },
              ),
              const SizedBox(height: 10,),
              const Divider(color: Colors.grey, height: 1,),
              const SizedBox(height: 20,),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Stack(
                        children:[
                          ClipOval(
                            child: updateUserNotifier.selectedImage != null ?
                                Image.file(File(updateUserNotifier.selectedImage!.path), height: 150, width: 150, fit: BoxFit.cover,):
                            Image.network(
                              parse(parse(widget.userProfile?.avt).body?.text).documentElement!.text,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                              right: 10,
                              top: 100,
                              child: GestureDetector(
                                onTap: () {
                                  updateUserNotifier.pickImageFromGallery().then((value)  {
                                    getToken().then((token) async {
                                      if(updateUserNotifier.selectedImage == null) return;
                                      File avt = File(updateUserNotifier.selectedImage!.path);
                                      changeAvata(avt, token, context);
                                    });
                                  });
                                },
                                child: ClipOval(
                                  child: Image.asset('assets/images/edit_icon.png', width: 40, height: 40, fit: BoxFit.cover,),
                                ),
                              )
                          )
                        ]
                    ),
                    const SizedBox(height: 15,),
                    Text(
                      widget.userProfile?.ten,
                      style: const TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w500,),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              DisableEditInformation(title: 'Họ và tên', content: widget.userProfile?.ten,),
              const SizedBox(height: 15,),
              const Text(
                'Ngày sinh',
                style: TextStyle(
                    color: Colors.black54, fontSize: 15, fontWeight: FontWeight.normal
                ),
              ),
              const SizedBox(height: 10,),
              TextField(
                onTap: () { updateBirth(context, updateUserNotifier);},
                controller: _controllerBirth,
                onChanged: (value) => updateUserNotifier.onChangedBirth(value),
                decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(width: 1, color: Colors.blue)
                    ),
                    hintText: 'DD-MM-YYYY',
                    hintStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
                    errorText: !updateUserNotifier.isValidBirth ? 'Chọn ngày sinh' : null,
                    errorStyle: const TextStyle(fontSize: 14, color: Colors.red),
                    suffixIcon: updateUserNotifier.isValidBirth ?
                    IconButton(
                      onPressed: () {
                        _controllerBirth.text = '';
                        updateUserNotifier.onChangedBirth('');
                        updateBirth(context, updateUserNotifier);
                      },
                      icon: const Icon(Icons.close, size: 20, color: Colors.blueGrey,),
                    ) :
                    IconButton(
                      onPressed: () {
                        updateBirth(context, updateUserNotifier );
                      },
                      icon: const Icon(Icons.calendar_today_outlined, size: 20, color: Colors.blueGrey,),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 7)
                ),
              ),
              const SizedBox(height: 15,),
              const Text(
                'Giới tính',
                style: TextStyle(
                    color: Colors.black54, fontSize: 15, fontWeight: FontWeight.normal
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    value: 'Nam',
                    groupValue: updateUserNotifier.sex,
                    onChanged: (value) {
                      updateUserNotifier.setSex(value!);
                      print(updateUserNotifier.sex);
                    },
                  ),
                  const SizedBox(width: 8,),
                  const Text('Nam', style: TextStyle(fontSize: 16, color: Colors.black54),),
                  const SizedBox(width: 8,),
                  Radio(
                    value: 'Nữ',
                    groupValue: updateUserNotifier.sex,
                    onChanged: (value) {
                      updateUserNotifier.setSex(value!);
                    },
                  ),
                  const SizedBox(width: 8,),
                  const Text('Nữ', style: TextStyle(fontSize: 16, color: Colors.black54),),
                ],
              ),
              const SizedBox(height: 15,),
              DisableEditInformation(title: 'Họ và tên', content: widget.userProfile?.ten,),
              const SizedBox(height: 15,),
              DisableEditInformation(title: 'Khối học', content: widget.userProfile?.khoiHoc,),
              const SizedBox(height: 15,),
              DisableEditInformation(title: 'Lớp học', content: widget.userProfile?.lopHoc,),
              const SizedBox(height: 15,),
              DisableEditInformation(title: 'Tên đăng nhập', content: widget.userProfile?.tenDangNhap,),
              const SizedBox(height: 15,),
              const Text(
                'Số điện thoại',
                style: TextStyle(
                    color: Colors.black54, fontSize: 15, fontWeight: FontWeight.normal
                ),
              ),
              const SizedBox(height: 10,),
              TextField(
                obscureText: false,
                controller: _controllerPhone,
                onChanged: (value) => updateUserNotifier.getErrorPhoneNumber(value),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(width: 1, color: Colors.blue)
                  ),
                  hintText: 'Nhập số điện thoại',
                  hintStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
                  errorText: updateUserNotifier.errorPhoneNumber,
                  errorStyle: const TextStyle(fontSize: 14, color: Colors.red),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 7),
                ),
              ),
              const SizedBox(height: 15,),
              DisableEditInformation(title: 'Email', content: widget.userProfile?.email,),
              const SizedBox(height: 15,),
              const Text(
                'Địa chỉ',
                style: TextStyle(
                    color: Colors.black54, fontSize: 15, fontWeight: FontWeight.normal
                ),
              ),
              const SizedBox(height: 10,),
              TextField(
                obscureText: false,
                controller: _controllerAddress,
                onChanged: (value) => updateUserNotifier.onChangedAddress(value),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(width: 1, color: Colors.blue)
                  ),
                  hintText: 'Nhập địa chỉ',
                  hintStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
                  errorText: updateUserNotifier.isValidAddress? null: 'Vui lòng nhập địa chỉ',
                  errorStyle: const TextStyle(fontSize: 14, color: Colors.red),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 7),
                ),
              ),
              const SizedBox(height: 15,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: updateUserNotifier.isShowStd,
                    onChanged: (bool? value) {
                      updateUserNotifier.changedShowStd();
                      isShowPhoneNumber = updateUserNotifier.isShowStd;
                    },
                  ),
                  const SizedBox(height: 8,),
                  RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'Cho phép hiển thị SĐT, địa chỉ trên\nsite ',
                              recognizer: TapGestureRecognizer()..onTap = () {
                                updateUserNotifier.changedShowStd();
                                isShowPhoneNumber = updateUserNotifier.isShowStd;
                              },
                              style: const TextStyle(
                                  fontSize: 17, color: Colors.black54, fontWeight: FontWeight.w400
                              )
                          ),
                          TextSpan(
                              text: 'hoc.vnedu.vn',
                              style: TextStyle(fontSize: 17, color: Colors.blue[900], fontWeight: FontWeight.normal),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                _launchVnEduVn();
                              }
                          )
                        ]
                    ),
                  )
                ],
              ),

              const SizedBox(height: 15,),
              const Divider(height: 2, color: Colors.grey,),
              const SizedBox(height: 10,),


              TextField(
                obscureText: updateUserNotifier.visibleIcon,
                controller: _controllerPassword,
                onChanged: (value) => updateUserNotifier.onChangedPassword(value),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      icon: Icon(updateUserNotifier.visibleIcon ?
                      Icons.visibility_off : Icons.visibility, color: Colors.grey,),
                      onPressed: () {updateUserNotifier.onChangedVisibleIcon();},
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(width: 1, color: Colors.blue)
                  ),
                  hintText: 'Mật khẩu',
                  hintStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
                  errorText: updateUserNotifier.isValidPassword ? null : 'Mật khẩu phải: có tối thiểu 8 kí tự, bao gồm 1 số,\n1 chữ hoa, 1 chữ thường và 1 kí tự đặc biệt',
                  errorStyle: const TextStyle(fontSize: 14, color: Colors.red,),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 7),
                ),
              ),
              const SizedBox(height: 20,),


              TextField(
                obscureText: updateUserNotifier.visibleIcon,
                controller: _controllerConfirmPassword,
                onChanged: (value) => updateUserNotifier.onChangedConfirmPassword(value),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(updateUserNotifier.visibleIcon ?
                    Icons.visibility_off : Icons.visibility, color: Colors.grey,),
                    onPressed: () {updateUserNotifier.onChangedVisibleIcon();},
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(width: 1, color: Colors.blue)
                  ),
                  hintText: 'Nhập lại mật khẩu',
                  hintStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
                  errorText: updateUserNotifier.isValidConfirmPassword? null : (_controllerPassword.text != _controllerConfirmPassword.text) ?
                      'Mật khẩu nhập lại không khớp' : 'Vui lòng nhập lại mật khẩu',
                  errorStyle: const TextStyle(fontSize: 14, color: Colors.red,),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 7),
                ),
              ),

              const SizedBox(height: 8,),
              const Divider(height: 5, color: Colors.grey,),
              const SizedBox(height: 15,),
              const Text(
                'Định danh cá nhân',
                style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 15,),
              Consumer<ChangeImageProvider>(
                builder: (context, changeImageProvider, child) {
                  print(changeImageProvider.isCancelledRequestIdentifyImage);
                  return DottedBorder(
                    dashPattern: const [4, 2],
                    strokeWidth: 2,
                    color: Colors.blueGrey,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 200,
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if(changeImageProvider.checkEkyc?.image_url_identify != null)
                            Image.network(
                              parse(parse(changeImageProvider.checkEkyc?.image_url_identify).body?.text).documentElement!.text,
                              width: 180,
                              height: 100,
                            ),
                          const SizedBox(height: 10,),
                          changeImageProvider.isCancelledRequestIdentifyImage ?
                              GestureDetector(
                                onTap: () { changeImageProvider.clickChangeIdentifyImage(changeImageProvider.checkEkyc?.record_user_ext_id, '1');},
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.6,
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.all(Radius.circular(8))
                                  ),
                                  child: const Text(
                                    'Yêu cầu định danh thay đổi ảnh',
                                    style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ):
                            GestureDetector(
                              onTap: () {changeImageProvider.clickChangeIdentifyImage(changeImageProvider.checkEkyc?.record_user_ext_id, '0'); },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white60,
                                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(color: Colors.blue, width: 2)
                                ),
                                child: const Text(
                                  'Hủy yêu cầu định danh thay đổi ảnh',
                                  style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10,),
            ]
        );
      },
    );

  }
}
