

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:vnedu/modal/notification.dart';
import 'package:vnedu/service_class.dart';

class NotificationNotifier extends ChangeNotifier {
  int totalNotifications = 0;
  List<Notifications> notifications = [];



  List<String> order = ["Mới nhất", "Cũ nhất"];
  List<String> payLoadOrder = ["create_date_desc", "create_date_asc"];
  int selectedOrder = 0;
  bool isOpenOderDialog = false;



  bool isSelectedAllNotify = false;

  int currentGroup = 1;
  List<int> listGroup = [1, 2, 3, 4, 5, 6, 7];



  /// bằng 1 => chọn tất cả
  /// bằng 2 => chọn Chưa đọc
  /// bằng 3 => chọn đã đọc
  int selectNotificationType = 1;
  List<String> payLoadNotificationType = ["", "", "unread", "read"];


  List<bool> selectElementController = [false, false, false, false, false, false];

  void refreshAllElementController() {
    isSelectedAllNotify = false;
    selectElementController = [false, false, false, false, false, false];
  }
  /// Các phần tử lần lượt quản lý trạng thái chọn của các thông báo trên màn hình
  /// Trên màn hình chỉ luôn hiển thị 6 thông báo

  void increaseCurrentGroup() {
    int numberGroup = (totalNotifications/6).ceil();
    if(currentGroup < numberGroup) {
      currentGroup++;
      refreshAllElementController();
    }
    if(currentGroup % 7 == 1) {
      listGroup = List<int>.generate(min(numberGroup - currentGroup + 1, 7), (index) => index + currentGroup);
    }
    notifyListeners();
  }

  void decreaseCurrentGroup() {
    if(currentGroup > 1) {
      currentGroup--;
      refreshAllElementController();
    }
    if(currentGroup % 7 == 0) {
      listGroup = List<int>.generate(min(currentGroup, 7), (index) => currentGroup - 6 + index);
      int i = 0, j = listGroup.length - 1;
    }

    notifyListeners();
  }

  void updateCurrentGroup(int newGroup) {
    currentGroup = newGroup;
    notifyListeners();
  }




  void updateSelectedOrder(int newOrder) {
    selectedOrder = newOrder;
    notifyListeners();
  }

  void updateIsOpenOrderDialog(bool value) {
    isOpenOderDialog = value;
    notifyListeners();
  }

  void onClickSelectAll() {
    isSelectedAllNotify = !isSelectedAllNotify;
    for(int i = 0; i < 6; i++) {
      selectElementController[i] = isSelectedAllNotify;
    }
    notifyListeners();
  }


  void updateSelectNotificationType(int index) {
    selectNotificationType = index;
    notifyListeners();
  }

  void updateOnlySelectElement(int index) {
    selectElementController[index] = !selectElementController[index];
    var cntTrue = selectElementController.where((element) => element == true);

    if(cntTrue.length < selectElementController.length) {
      isSelectedAllNotify = false;
    }else {
      isSelectedAllNotify = true;
    }
    notifyListeners();
  }



  Future<void> getNotifications(String start) async {
    getToken().then((token) async {
      print('Token: $token');
      List<dynamic> result = await getNotificationsByUser(
          token,
          start,
          payLoadNotificationType[selectNotificationType],
          payLoadOrder[selectedOrder]
      );
      notifications = result[0];
      totalNotifications = result[1];
      notifyListeners();
    });

  }

  void delete(Map<String, String> notificationIds) {
    getToken().then((token) async {
      bool success = await deleteNotifications(notificationIds, token);
      if(success) {
        getNotifications(((currentGroup - 1) * 6).toString());
      }
      notifyListeners();
    });
  }

  void handleMarkRead(Map<String, String> notificationIds)  {
    getToken().then((token) async {
      bool success = await notificationMarkRead(notificationIds, token);
      if(success) {
        refreshAllElementController();
      }
    });
  }

  void refresh() {
    refreshAllElementController();
    currentGroup = 1;
    selectedOrder = 0;
    isOpenOderDialog = false;
    notifyListeners();
  }

}