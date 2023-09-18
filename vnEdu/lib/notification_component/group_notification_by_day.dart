

import 'package:flutter/cupertino.dart';
import 'package:vnedu/modal/notification.dart';
import 'package:vnedu/notification_component/notification_item.dart';
import 'package:vnedu/notification_component/title.dart';

class GroupNotificationsByDay extends StatelessWidget {
  const GroupNotificationsByDay({super.key, required this.listNotificationByDay});
  final List<Notifications> listNotificationByDay;
  
  List<Widget> getNotificationByDayWidget() {
    List<Widget> ans = [];
    ans.add(TitleNotification(notifications: listNotificationByDay[0], length: listNotificationByDay.length,));
    for(int i = 0; i < listNotificationByDay.length; i++) {
      ans.add(NotificationItem(notifications: listNotificationByDay[i]));
    }
    return ans;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: getNotificationByDayWidget(),
    );
  }
}