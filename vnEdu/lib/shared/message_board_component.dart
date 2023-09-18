


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBoardComponent extends StatelessWidget {
  const MessageBoardComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Card(
        elevation: 10,
        shadowColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        'assets/images/calendar.png', width: 100, height: 100,
                      ),
                      Positioned(
                        left: 26,
                        top: 35,
                        child: Text('28.06', style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.bold, fontSize: 18),),
                      ),
                      Positioned(
                          left: 21,
                          top: 60,
                          child: Text('Năm 2023', style: TextStyle(color: Colors.blue[700], fontSize: 13),)
                      )
                    ],
                  ),
                  const SizedBox(width: 7,),
                  Text(
                    'Thông báo 28/6 edi',
                    style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Content',
                style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 20,),
              InkWell(
                onTapUp: (v) { },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Xem chi tiết',
                    style: TextStyle(color: Colors.blue[800], fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}