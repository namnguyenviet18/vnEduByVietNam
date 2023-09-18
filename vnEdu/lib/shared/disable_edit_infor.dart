

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DisableEditInformation extends StatelessWidget {
  const DisableEditInformation({
    super.key,
    required this.title,
    required this.content
  });
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.black54, fontSize: 15, fontWeight: FontWeight.normal
          ),
        ),
        const SizedBox(height: 10,),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 47,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: Colors.blue, width: 1)
          ),
          child: Text(
            content,
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500
            ),
          )
        )
      ],
    );
  }
}