
import 'package:flutter/material.dart';

class LoginInstructions extends StatelessWidget {
  const LoginInstructions({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.red, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: Colors.amber.withOpacity(0.7)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '⁕ Hướng dẫn đăng nhập',
              style: TextStyle(color: Colors.red.withOpacity(0.7), fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10,),
            RichText(
              text: const TextSpan(
                  children: [
                    TextSpan(text: '\t• Nếu có ', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w300)),
                    TextSpan(
                        text: 'tài khoản vnEdu ', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500)
                    ),
                    TextSpan(text: 'vui lòng nhập ', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w300)),
                    TextSpan(
                      text: 'tên tài khoản vnEdu ', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    TextSpan(text: 'và ', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w300)),
                    TextSpan(
                        text: 'mật khẩu vnEdu ', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500)
                    ),
                    TextSpan(text: 'tương ứng.', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w300)),
                  ]
              ),
            ),
            const SizedBox(height: 10,),
            RichText(
              text: const TextSpan(
                  children: [
                    TextSpan(text: '\t• Hoặc nhập ', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w300)),
                    TextSpan(
                        text: 'Tên đăng nhập/Email ', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500)
                    ),
                    TextSpan(text: 'đã đăng ký tài khoản tại ', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w300)),
                    TextSpan(
                        text: 'vnEdu LMS ', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500)
                    ),
                    TextSpan(text: 'vào ô ', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w300)),
                    TextSpan(
                        text: 'Tên tài khoản, ', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500)
                    ),
                    TextSpan(text: 'sau đó nhập ', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w300)),
                    TextSpan(
                        text: 'Mật khẩu.', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500)
                    ),
                  ]
              ),
            ),
            const SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }

}