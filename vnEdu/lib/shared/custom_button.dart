

import 'package:flutter/material.dart';
import 'package:vnedu/screens/login_screen.dart';

Widget ButtonMenu(BuildContext context, String title, void Function()? onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
        )
    ),
  );
}

Widget ButtonStudyCorner(BuildContext context, Icon icon, String title, void Function()? onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon,
          const SizedBox(width: 10,),
          Text(
            title, style: const TextStyle(color: Colors.black, fontSize: 15),
          )
        ],
      ),
    ),
  );
}

class ButtonLogOrRegis extends StatelessWidget {
  const ButtonLogOrRegis({super.key, required this.logType, required this.title, required this.onPress});
  final bool logType;
  final String title;
  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: logType ? Colors.purple[900] : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: logType ? null : Border.all(width: 1, color: Colors.blue)
        ),
        child: Text(
          title,
          style: TextStyle(
            color: logType ? Colors.white : Colors.blue[900],
            fontSize: 15,
            fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }
}

class ButtonProfile extends StatelessWidget {
  const ButtonProfile({
    super.key,
    required this.icon,
    required this.title,
    required this.onPress
  });
  final IconData icon;
  final String title;
  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 40,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 25, color: Colors.blueGrey),
            const SizedBox(width: 8,),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black54, fontSize: 16, fontWeight: FontWeight.normal
              ),
            )
          ],
        ),
      ),
    );
  }

}

class ButtonUpdateUser extends StatelessWidget {
  const ButtonUpdateUser({super.key, required this.onPress});
  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        width: MediaQuery.of(context).size.width * 0.65,
        height: 45,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        child: const Row(
          children: [
            Icon(Icons.edit_note_outlined,  color: Colors.white, size: 25,),
            SizedBox(width: 10,),
            Text(
              'Cập nhật hồ sơ/mật khẩu',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
            )
          ],
        )
      ),
    );
  }
}

class ButtonSaveUpdate extends StatelessWidget {
  const ButtonSaveUpdate({super.key, required this.onPress});
  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        padding: const EdgeInsets.symmetric(horizontal: 8),
          height: 45,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(8))
          ),
          child: const Row(
            children: [
              Icon(Icons.save_outlined,  color: Colors.white, size: 25,),
              SizedBox(width: 10,),
              Text(
                'Lưu lại',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
              )
            ],
          )
      ),
    );
  }
}




