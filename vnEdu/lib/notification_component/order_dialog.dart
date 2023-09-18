

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vnedu/controller/notification_provider.dart';

class OrderDialog extends StatelessWidget {
  const OrderDialog({super.key, required this.notificationNotifier, required this.width});
  final NotificationNotifier notificationNotifier;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              notificationNotifier.updateSelectedOrder(0);
              notificationNotifier.updateCurrentGroup(1);
              notificationNotifier.getNotifications((notificationNotifier.currentGroup - 1).toString());
              notificationNotifier.updateIsOpenOrderDialog(false);
            },
            child: Container(
              width: width,
              height: 50,
              decoration: BoxDecoration(
                  color: notificationNotifier.selectedOrder == 0 ? Colors.blue[200] : Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8))
              ),
              child: Row(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.06,
                      child: notificationNotifier.selectedOrder == 0 ?
                      const Icon(Icons.check, size: 24, color: Colors.blue,) : null
                  ),
                  const SizedBox(width: 7,),
                  Text(
                    notificationNotifier.order[0],
                    style: TextStyle(
                        color: notificationNotifier.selectedOrder == 0 ? Colors.blue : Colors.black87,
                        fontSize: 16
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              notificationNotifier.updateSelectedOrder(1);
              notificationNotifier.updateCurrentGroup(1);
              notificationNotifier.getNotifications((notificationNotifier.currentGroup - 1).toString());
              notificationNotifier.updateIsOpenOrderDialog(false);
            },
            child: Container(
              width: width,
              height: 50,
              decoration: BoxDecoration(
                  color: notificationNotifier.selectedOrder == 1 ? Colors.blue[200] : Colors.white,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(8), bottomLeft: Radius.circular(8))
              ),
              child: Row(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.06,
                      child: notificationNotifier.selectedOrder == 1 ?
                      const Icon(Icons.check, size: 24, color: Colors.blue,) : null
                  ),
                  const SizedBox(width: 7,),
                  Text(
                    notificationNotifier.order[1],
                    style: TextStyle(
                        color: notificationNotifier.selectedOrder == 1 ? Colors.blue : Colors.black87,
                        fontSize: 16
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

