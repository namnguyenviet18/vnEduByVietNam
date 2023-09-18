

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vnedu/modal/new_board.dart';

class NewBoardHomePage extends StatelessWidget {
  const NewBoardHomePage({super.key, required this.newBoard, required this.onTapShowDetails});
  final NewBoard? newBoard;
  final void Function()? onTapShowDetails;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              child: SvgPicture.network(
                "http://lms-school-node1.vnpt.edu.vn/app/assets/img/calendar.svg?v=20230908171000",
                width: 90,
                height: 90,
              ),
            ),
            Positioned(
              left: 23,
              top: 32,
              child: Text('${newBoard?.createDate.substring(5, 7)}.${newBoard?.createDate.substring(8, 10)}', style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.bold, fontSize: 19),),
            ),
            Positioned(
                left: 18,
                top: 57,
                child: Text('năm ${newBoard!.createDate.substring(0, 4)}',
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
              newBoard!.title,
              style: TextStyle(color: Colors.blue[700], fontSize: 15,),
              maxLines: 5,

            ),
          ),
        )
      ],
    );
  }


}