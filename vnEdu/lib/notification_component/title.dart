

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vnedu/modal/notification.dart';
import 'package:vnedu/shared/format_date.dart';

class TitleNotification extends StatelessWidget {
  const TitleNotification({super.key, required this.notifications, required this.length});
  final Notifications? notifications;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.lightBlueAccent,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            getThuNgayThang(notifications!.createDate.substring(0, 10)),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.brown
            ),
          ),
          Text(
            'Thông báo ($length)',
            style: const TextStyle(
                fontSize: 14,
                color: Colors.brown
            ),
          )
        ],
      ),
    );
  }
}