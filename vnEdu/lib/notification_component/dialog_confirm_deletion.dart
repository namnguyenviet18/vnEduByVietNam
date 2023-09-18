

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vnedu/controller/notification_provider.dart';

class DialogConfirmDeletion extends StatelessWidget {
  const DialogConfirmDeletion({super.key, required this.notificationIds, required this.notificationNotifier});
  final Map<String, String> notificationIds;
  final NotificationNotifier notificationNotifier;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300,
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(right: 5),
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.close, color: Colors.blueGrey, size: 20,
              ),
            ),
          ),
          SvgPicture.network(
            "http://lms-school-node1.vnpt.edu.vn/app/assets/img/warning-icon.svg?v=20230913153300",
            width: 50,
            height: 50,
          ),
          const SizedBox(height: 8,),
          const Text(
            'Cảnh báo',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500
            ),
          ),
          const SizedBox(height: 10,),
          const Text(
            'Bạn có chắc chắn muốn xóa thông báo này?',
            style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.w400
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  notificationNotifier.delete(notificationIds);
                  Navigator.pop(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 45,
                  margin: const EdgeInsets.only(right: 3),
                  decoration: BoxDecoration(
                    borderRadius:  const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(width: 1, color: Colors.blue)
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Đồng ý',
                    style: TextStyle(color: Colors.blue, fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 45,
                  margin: const EdgeInsets.only(left: 3),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.blue
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Hủy',
                    style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

}