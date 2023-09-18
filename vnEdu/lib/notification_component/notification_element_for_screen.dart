

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vnedu/modal/notification.dart';
import 'package:vnedu/new_and_event_component/custom_check_box.dart';
import 'package:html/parser.dart';
import 'package:vnedu/shared/format_date.dart';

class NotificationElement extends StatelessWidget {
  const NotificationElement({
    super.key,
    required this.notification,
    required this.isSelected,
    required this.onChanged
  });
  final Notifications? notification;
  final bool isSelected;
  final void Function()? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(10))
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomCheckBox(isChecked: isSelected, onChange: onChanged),
          //SizedBox(width: MediaQuery.of(context).size.width * 0.042,),
          Container(
            width: MediaQuery.of(context).size.width * 0.727,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: Text(
                    parse(parse(notification?.title).body?.text).documentElement!.text,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    parse(parse(notification?.content).body?.text).documentElement!.text,
                    style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 15),
                  child: Text(
                    formatDate_dd_mm_yyyy(notification!.createDate.substring(0, 10)),
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 17,
                      fontWeight: FontWeight.normal
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}