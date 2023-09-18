

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vnedu/modal/new_hot.dart';

class OtherNewBoard extends StatelessWidget {
  const OtherNewBoard({super.key, required this.newHot, required this.onTapShowDetails});
  final NewHots? newHot;
  final void Function()? onTapShowDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white70,
        border: Border.all(color: Colors.blue, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(8))
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/images/calendar.png', width: 100, height: 100,
              ),
              Positioned(
                left: 26,
                top: 35,
                child: Text('${newHot?.createDate.substring(5, 7)}.${newHot?.createDate.substring(8, 10)}', style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.bold, fontSize: 18),),
              ),
              Positioned(
                  left: 21,
                  top: 60,
                  child: Text('năm ${newHot!.createDate.substring(0, 4)}',
                    style: TextStyle(color: Colors.blue[700], fontSize: 13),)
              )
            ],
          ),
          const SizedBox(width: 10,),
          InkWell(
            onTap: onTapShowDetails,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Text(
                  newHot!.title,
                  style: TextStyle(color: Colors.blue[700], fontSize: 15,),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis
              ),
            ),
          )
        ],
      )
    );
  }

}