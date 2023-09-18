

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vnedu/modal/notification.dart';
import 'package:html/parser.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.notifications});
  final Notifications? notifications;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.notifications, size: 20, color: Colors.blue,
          ),
          const SizedBox(width: 7,),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  parse(parse(notifications?.title).body?.text).documentElement!.text,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87
                  ),
                ),

                Text(
                  notifications!.createDate.substring(11, 16),
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                )

              ],
            )
          )
        ],
      ),
    );
  }

}