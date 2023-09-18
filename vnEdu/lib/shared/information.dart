

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vnedu/modal/intro_infor.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';
import 'package:vnedu/service_class.dart';

class Information extends StatelessWidget {
  const Information({super.key, required this.introInformation});
  final IntroInformation? introInformation;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      color: Colors.deepPurple,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                parse(parse(introInformation?.logoImage).body?.text).documentElement!.text,
                width: 50,
                height: 50,
              ),
              const SizedBox(width: 5,),
              Text(
                introInformation?.tenDonVi,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w500
                ),
              )
            ],
          ),
          const SizedBox(height: 20,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.location_on_outlined, color: Colors.white, size: 25,),
              const SizedBox(height: 5,),
              Expanded(
                child: Text(
                  introInformation?.address,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  softWrap: true,
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.phone_outlined, color: Colors.white, size: 25, ),
              const SizedBox(width: 5,),
              Text(
                'Liên hệ: ${introInformation?.firstPhoneNumber} - ${introInformation?.secondPhoneNumber}',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                ),
              )
            ],
          ),
          const SizedBox(height: 30,),
          Row(
            children: [
              GestureDetector(
                onTap: () {

                },
                child: ClipOval(
                  child: SvgPicture.network(
                    "http://lms-school-node1.vnpt.edu.vn/app/assets/img/facebook.svg?v=20230908171000",
                    width: 50,
                    height: 50,
                  ),
                ),
              ),

              const SizedBox(width: 30,),
              GestureDetector(
                onTap: () {

                },
                child: ClipOval(
                  child: SvgPicture.network(
                    "http://lms-school-node1.vnpt.edu.vn/app/assets/img/email-footer.svg?v=20230908171000",
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          const Divider(height: 2, color: Colors.white,),
          const SizedBox(height: 20,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                child: SvgPicture.network(
                  "http://lms-school-node1.vnpt.edu.vn/app/assets/img/vnEdu-logo.svg?v=20230908171000",
                  width: 65,
                  height: 40,
                ),
              ),
              const SizedBox(width: 8,),
              const SizedBox(
                width: 250,
                child: Text(
                  'NỀN TẢNG DẠY HỌC TRỰC TUYẾN VNEDU LMS',
                  maxLines: 2,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500
                  ),
                ),
              )
            ],
          ),

          const SizedBox(height: 30,),
          TextButton(
              style: TextButton.styleFrom(
                fixedSize: const Size(200, 40),
                backgroundColor: Colors.blue,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))
                )
              ),
              onPressed: () {
                huongDanSuDung();
              },
              child: const Text(
                'Hướng dẫn sử dụng',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w500
                ),
              )
          ),

          const SizedBox(height: 20,),
          const Row(
            children: [
              Icon(Icons.phone_outlined, color: Colors.white, size: 25, ),
              SizedBox(width: 5,),
              Text(
                'Hotline: 18001260',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                ),
              )
            ],
          ),
          const SizedBox(height: 5,),
          const Row(
            children: [
              Icon(Icons.phone_outlined, color: Colors.white, size: 25, ),
              SizedBox(width: 5,),
              Text(
                'Email: Hotline@vnedu.vn',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                ),
              )
            ],
          ),

          const SizedBox(height: 25,),

          const Text(
            'ỨNG DỤNG TRỰC TUYẾN',
            maxLines: 2,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500
            ),
          ),

          const SizedBox(height: 15,),

          Row(
            children: [
              GestureDetector(
                onTap: () { openAppStore(); },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/app_store.png',
                    width: 145.0,
                    height: 40.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10,),

              GestureDetector(
                onTap: () { openCHPlay(); },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/google_play.png',
                    width: 145.0,
                    height: 40.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

            ],
          ),
          const SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sản phẩm cung cấp bởi',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 4,),
              SvgPicture.network(
                'http://lms-school-node1.vnpt.edu.vn/app/assets/img/vnpt.svg?v=20230908171000',
              )
            ],
          )
        ],
      ),

    );
  }


}