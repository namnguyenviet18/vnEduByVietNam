

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vnedu/const/constant.dart';

class DescribeLearningOnlinePlatform extends StatelessWidget {
  const DescribeLearningOnlinePlatform({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      color: Colors.blue[100],
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.network(
                "http://lms-school-node1.vnpt.edu.vn/app/assets/img/vnEdu-logo.svg?v=20230912094900",
                width: 50,
                height: 50,
              ),
              const SizedBox(width: 5,),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const  Text(
                    'NỀN TẢNG DẠY HỌC TRỰC TUYẾN VNEDU LMS',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 15,),
          const Text(
            Constants.MO_TA_NEN_TANG_DAY_TRUC_TUYEN,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16
            ),
          ),
          const SizedBox(height: 25,),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    '20K+',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 27,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Trường học',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    '600+',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 27,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Giáo viên',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    '8M+',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 27,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Học sinh',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 25,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Image.network(
                    "http://lms-school-node1.vnpt.edu.vn/app/assets/img/sao-khue.png?v=20230912094900",
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 15,),
                  const Text(
                    '2 dang hiệu\nSao Khuê 2019',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              Column(
                children: [
                  Image.network(
                    "http://lms-school-node1.vnpt.edu.vn/app/assets/img/stevle-awards.png?v=20230912094900",
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 15,),
                  const Text(
                    '1 Giải vàng quốc tế\nStevie Awards IBA 2021',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

}