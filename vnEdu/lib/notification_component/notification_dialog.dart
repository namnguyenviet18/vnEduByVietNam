

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vnedu/controller/appbar_provider.dart';
import 'package:vnedu/controller/notification_provider.dart';
import 'package:vnedu/modal/notification.dart';
import 'package:collection/collection.dart';
import 'package:vnedu/notification_component/group_notification_by_day.dart';
import 'package:vnedu/screens/notification_screen.dart';
import 'package:provider/provider.dart';


class NotificationDialog extends StatefulWidget {
  const NotificationDialog({super.key, required this.notifications, required this.existParent});
  final List<Notifications> notifications;
  final bool existParent;

  @override
  State<NotificationDialog> createState() => _NotificationDialogState();
}

class _NotificationDialogState extends State<NotificationDialog> {

  List<Widget> getListNotificationWidget() {
    List<Widget> ans = [];
    var grouped = groupBy(widget.notifications, (Notifications noti) => noti.createDate.substring(0, 10));
    print(grouped.toString());
    grouped.forEach((date, listNoficationByDay) {
      ans.add(GroupNotificationsByDay(listNotificationByDay: listNoficationByDay));
    });
    return ans;
  }

  @override
  Widget build(BuildContext context) {
    final notificationNotifier = Provider.of<NotificationNotifier>(context, listen: false);
    final appbarNotifier = Provider.of<AppBarNotifier>(context, listen: false);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.57,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          const Text(
            'Thông báo',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500
            ),
          ),
          const SizedBox(height: 10,),
          const Divider(height: 2, color: Colors.grey,),
          Container(
            height: MediaQuery.of(context).size.height * 0.42,
            child: SingleChildScrollView(
              child: Column(
                children: getListNotificationWidget(),
              ),
            ),
          ),

          const SizedBox(height: 15,),
          Center(
            child: InkWell(
              onTap: () {
                if(widget.existParent) {
                  appbarNotifier.refresh();
                }else {
                  notificationNotifier.refresh();
                  appbarNotifier.refresh();
                  notificationNotifier.getNotifications(((notificationNotifier.currentGroup - 1) * 6).toString()).then((value) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationScreen(isLogged: true,)));
                  });
                }
              },
              child: const Text(
                'Xem Thêm',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 17,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
          )

        ],
      ),
    );
  }

}