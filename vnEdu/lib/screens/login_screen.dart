


import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vnedu/const/constant.dart';
import 'package:vnedu/controller/appbar_provider.dart';
import 'package:vnedu/device_id.dart';
import 'package:vnedu/dialogs/contest_code_dialog.dart';
import 'package:vnedu/modal/user_profile.dart';
import 'package:vnedu/screens/introduce_screen.dart';
import 'package:vnedu/screens/news_screen.dart';
import 'package:vnedu/screens/school_yard_screen.dart';
import 'package:vnedu/shared/login_instructions.dart';
import 'package:vnedu/shared/other_login_options.dart';
import 'package:http/http.dart';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.rootScreenId});
  final int rootScreenId;


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isCreateAccount = false;
  final TextEditingController _accController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  bool _isAccEmpty = false;
  bool _isPwEmpty = false;
  bool _isObscureText = true;
  bool _isForgotPasswork = false;

  void _checkTextFieldEmpty(String inputValue, String type) {
    if(inputValue.isEmpty) {
      if(type == 'acc') {
        setState(() {
          _isAccEmpty = true;
        });
      }else {
        _isPwEmpty = true;
      }
    }else {
      if(type == 'acc') {
        setState(() {
          _isAccEmpty = false;
        });
      }else if(type == 'pw'){
        _isPwEmpty = false;
      }
    }
  }


  Future<String> initDeviceId() async {
    await DeviceId.init();
    return DeviceId.getDeviceId().replaceAll('-', '');
  }

  Future<void> callApiLogin(String deviceId) async {
    print("${deviceId}____________________________");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Response response = await post(
      Uri.parse('http://lms-school-node1.vnpt.edu.vn/service/security/loginJWT'),
      body: {
        "email": _accController.text.trim(),
        "password": md5.convert(utf8.encode(_pwController.text.trim())).toString(),
        "deviceId": deviceId
      }
    );
    if(response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data.toString());
      if(data['success']) {
        preferences.setString(Constants.TOKEN, data['data']['token']);
      }
    }
  }


  Future<void> capCha() async {
    String url = 'http://lms-school-node1.vnpt.edu.vn/test/resetCaptcha?key=c373d05adf87625818d1a478b59975f93ff9c95544910f1b2863a5899882b53f&captchaKey=loginForm';
    Response response = await post(
        Uri.parse(url),
        body: {}
    );
  }
  @override
  Widget build(BuildContext context) {
    print('build_______________________');
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.pinkAccent.withOpacity(0.7),
        resizeToAvoidBottomInset: false,
        body: Scrollbar(
          thickness: 7,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                    color: Colors.white
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      const Center(
                        child: Text(
                          'ĐĂNG NHẬP',
                          style: TextStyle(fontSize: 26, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 30,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Chưa có tài khoản?',
                                  style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(width: 5,),
                                GestureDetector(
                                  onLongPressDown: (v) => setState(() {
                                    _isCreateAccount = true;
                                  }),
                                  onTapUp: (v) => setState(() {
                                    _isCreateAccount = false;
                                  }),
                                  child: Container(
                                    color: _isCreateAccount ? Colors.blue.withOpacity(0.2) : Colors.white,
                                    child: const Text(
                                      'Tạo tài khoản',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.blueAccent, fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 15,),
                            TextField(
                              controller: _accController,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      borderSide: BorderSide(color: Colors.grey, width: 1)
                                  ),
                                  hintText: 'Tên tài khoản',
                                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.normal),
                                  errorText: _isAccEmpty ? 'Tên tài khoản không được bỏ trống.' : null,
                                  errorStyle: const TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.normal),
                                  contentPadding: const EdgeInsets.all(5)
                              ),
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                              onChanged: (value) => _checkTextFieldEmpty(value, 'acc'),
                            ),
                            const SizedBox(height: 20,),
                            TextField(
                              controller: _pwController,
                              obscureText: _isObscureText,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      icon: _isObscureText ? const Icon(Icons.visibility, color: Colors.black,) : const Icon(Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          _isObscureText = !_isObscureText;
                                        });
                                      }
                                  ),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      borderSide: BorderSide(color: Colors.grey, width: 1)
                                  ),
                                  hintText: 'Mật khẩu',
                                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.normal),
                                  errorText: _isPwEmpty ? 'Mật khẩu không được bỏ trống.' : null,
                                  errorStyle: const TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.normal),
                                  contentPadding: const EdgeInsets.all(5)
                              ),
                              textInputAction: TextInputAction.done,
                              style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                              onChanged: (value) => _checkTextFieldEmpty(value, 'pw'),
                            ),
                            const SizedBox(height: 20,),
                            Container(
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onLongPressDown: (v) => setState(() {
                                    _isForgotPasswork = true;
                                  }),
                                  onTapUp: (v) => setState(() {
                                    _isForgotPasswork = false;
                                  }),
                                  child: Container(
                                    color: _isForgotPasswork ? Colors.blue.withOpacity(0.2) : Colors.white,
                                    child: const Text(
                                      'Quên mật khẩu',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.blueAccent, fontWeight: FontWeight.w400
                                      ),
                                    ),
                                  ),
                                )
                            ),
                            const SizedBox(height: 20,),
                            GestureDetector(
                              onTap: () {
                                capCha();
                                initDeviceId().then((deviceId) => callApiLogin(deviceId)).then((value) {
                                  final controller = Provider.of<AppBarNotifier>(context, listen: false);
                                  controller.refresh();
                                  controller.getData().then((value) {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (BuildContext context) {
                                        if(widget.rootScreenId == 1) {
                                          return const SchoolYardScreen(
                                            isLogged: true,
                                          );
                                        }else if(widget.rootScreenId == 2) {
                                          return IntroduceScreen(isLogged: true);
                                        }
                                        return NewsScreen(
                                          isLogged: true,
                                        );
                                      }),
                                          (Route<dynamic> route) => false,
                                    );
                                  });

                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 45,
                                decoration: const BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                                child: const Center(
                                  child: Text(
                                    'Đăng nhập',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30,),
                            const Center(
                              child: Text(
                                'Hoặc đăng nhập bằng',
                                style: TextStyle(fontSize: 15, color: Colors.blueGrey, fontWeight: FontWeight.normal),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            OtherLoginOptions(
                              onTapContestCode: () {
                                showDialog(context: context, builder: (context) => const ContestCodeDialog());
                              },
                              onTapSSO: () {
                                print('ddfdfdfdf');
                              },
                            ),
                            const SizedBox(height: 15,)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30,),
                const LoginInstructions()
              ],
            ),
          ),
        ),
      ),
    );
  }

}