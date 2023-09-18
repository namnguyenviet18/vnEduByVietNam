

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vnedu/controller/notification_provider.dart';

class ButtonIndicate extends StatelessWidget {
  const ButtonIndicate({super.key, required this.onPress, required this.order});
  final void Function()? onPress;
  final String order;

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<NotificationNotifier>(context, listen: true);
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 30,
        height: 30,
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(3)),
          border: Border.all(color: notifier.currentGroup == int.parse(order)? Colors.lightBlue : Colors.grey, width: 0.5),
          color: notifier.currentGroup == int.parse(order)? Colors.lightBlueAccent : Colors.white
        ),
        alignment: Alignment.center,
        child: Text(
          order,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16
          ),
        ),
      ),
    );
  }
}