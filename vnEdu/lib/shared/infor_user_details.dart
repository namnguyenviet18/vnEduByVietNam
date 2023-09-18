

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InformationUserDetails extends StatelessWidget {
  const InformationUserDetails({super.key, required this.type, required this.value});
  final String type;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          type,
          style: const TextStyle(
            color: Colors.black54, fontSize: 15, fontWeight: FontWeight.normal
          ),
        ),
        const SizedBox(height: 5,),
        Text(
          value,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500
          ),
        )
      ],
    );
  }
}