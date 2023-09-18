

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationsEmpty extends StatelessWidget {
  const NotificationsEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 400,
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/nothing_to_show.png",
            width: 250,
            height: 250,
          ),
          const SizedBox(height: 15,),
          Text(
            'Chưa có thông báo nào',
            style: TextStyle(
              color: Colors.blue[800],
              fontSize: 19,
              fontWeight: FontWeight.w500
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10,),
          const Text(
            'Hãy thử tra cứu lại với tiêu chí khác nhé!',
            style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w400
            ),
            textAlign: TextAlign.center,
          ),

        ],
      ),
    );
  }

}