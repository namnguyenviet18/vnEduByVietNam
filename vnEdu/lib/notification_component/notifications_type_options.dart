

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vnedu/controller/notification_provider.dart';

class NotificationTypeOptions extends StatelessWidget {
  const NotificationTypeOptions({super.key, required this.type, required this.totalNotifications, required this.notificationNotifier});
  final int type;
  final int totalNotifications;
  final NotificationNotifier notificationNotifier;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      color: Colors.white,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              notificationNotifier.updateSelectNotificationType(1);
              notificationNotifier.updateCurrentGroup(1);
              notificationNotifier.getNotifications((notificationNotifier.currentGroup - 1).toString());
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              height: 50,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                color: type == 1 ? Colors.blue[900] : Colors.white,
              ),
              child: Row(
                children: [
                  Icon(Icons.email, size: 20, color: type == 1 ? Colors.white : Colors.grey,),
                  const SizedBox(width: 8,),
                  Text(
                    'Tất cả ($totalNotifications)',
                    style: TextStyle(
                       color: type == 1 ? Colors.white : Colors.black87,
                      fontSize: 18
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              notificationNotifier.updateSelectNotificationType(2);
              notificationNotifier.updateCurrentGroup(1);
              notificationNotifier.getNotifications((notificationNotifier.currentGroup - 1).toString());
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              height: 50,
              alignment: Alignment.centerLeft,
              color: type == 2 ? Colors.blue[900] : Colors.white,
              child: Row(
                children: [
                  Stack(
                    children: [
                      Icon(Icons.mark_email_unread, size: 20, color: type == 2 ? Colors.white : Colors.grey,),
                      Positioned(
                        right: 1,
                        top: 1,
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(4))
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 8,),
                  Text(
                    'Chưa đọc',
                    style: TextStyle(
                        color: type == 2 ? Colors.white : Colors.black87,
                        fontSize: 18
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              notificationNotifier.updateSelectNotificationType(3);
              notificationNotifier.updateCurrentGroup(1);
              notificationNotifier.getNotifications((notificationNotifier.currentGroup - 1).toString());
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              height: 50,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                color: type == 3 ? Colors.blue[900] : Colors.white,
              ),
              child: Row(
                children: [
                  Icon(Icons.mark_email_read, size: 20, color: type == 3 ? Colors.white : Colors.grey,),
                  const SizedBox(width: 8,),
                  Text(
                    'Đã đọc',
                    style: TextStyle(
                        color: type == 3 ? Colors.white : Colors.black87,
                        fontSize: 18
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}