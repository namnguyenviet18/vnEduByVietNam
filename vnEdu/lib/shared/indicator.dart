

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  const Indicator({super.key, required this.isActive});
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(5))
      ),
    );
  }
}