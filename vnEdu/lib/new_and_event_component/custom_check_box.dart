

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({super.key, required this.isChecked, required this.onChange});
  final bool isChecked;
  final void Function()? onChange;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChange,
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          border: isChecked ? null : Border.all(color: Colors.blueGrey, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(3)),
          color: isChecked ? Colors.blue[900] : Colors.white
        ),
        alignment: Alignment.center,
        child: isChecked ? const Icon(
          Icons.check, size: 20, color: Colors.white,
        ) : null,
      ),
    );
  }
}