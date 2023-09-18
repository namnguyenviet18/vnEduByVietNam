

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vnedu/modal/new_board.dart';

class AnnouncementItem extends StatelessWidget {
  const AnnouncementItem({super.key, required this.newBoard, required this.showDetails});
  final NewBoard? newBoard;
  final void Function()? showDetails;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        elevation: 10,
        shadowColor: Colors.blueGrey,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
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
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    newBoard!.title,
                    style: TextStyle(color: Colors.blue[700], fontSize: 15,),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
            const SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                newBoard!.description,
                style: TextStyle(color: Colors.blue[700], fontSize: 15,),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: showDetails,
                child: Text(
                  'Xem chi tiết',
                  style: TextStyle(color: Colors.blue[800], fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(height: 22,)
          ],
        ),
      ),
    );
  }
}