

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vnedu/modal/new_board.dart';
import 'package:vnedu/shared/newboard_homepage.dart';

class CardNotify extends StatelessWidget {
  const CardNotify({super.key, required this.onTapShowAll, required this.newBoards});

  final void Function()? onTapShowAll;
  final List<NewBoard>? newBoards;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
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
            Container(
              width: MediaQuery.of(context).size.width,
              height: 75,
              color: Colors.blue.withOpacity(0.2),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: SvgPicture.network(
                      "http://lms-school-node1.vnpt.edu.vn/app/assets/img/speaker.svg?v=20230908171000",
                      width: 50,
                      height: 50,
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Text(
                    'Bảng tin',
                    style: TextStyle(color: Colors.blue[900], fontSize: 23, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const SizedBox(height: 15,),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: newBoards == null || newBoards!.isEmpty ? [] : [
                    NewBoardHomePage(newBoard: newBoards?[0], onTapShowDetails: () { }),
                    if(newBoards!.length >= 2) NewBoardHomePage(newBoard: newBoards?[1], onTapShowDetails: () { }),
                  ],
                )
            ),

            const SizedBox(height: 25,),
            Center(
              child: InkWell(
                onTap: onTapShowAll,
                child: Text(
                  'Xem tất cả',
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
