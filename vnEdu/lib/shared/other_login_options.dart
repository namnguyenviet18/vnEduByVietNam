

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OtherLoginOptions extends StatelessWidget {
  const OtherLoginOptions({super.key, required this.onTapContestCode, required this.onTapSSO});
  final void Function()? onTapContestCode;
  final void Function()? onTapSSO;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: onTapContestCode,
          child: Container(
            height: 45,
            width: MediaQuery.of(context).size.width * 0.35,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                color: Colors.white
            ),
            child: const Center(
              child: Text(
                'Mã dự thi',
                style: TextStyle(color: Colors.blueAccent, fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
          ),

        ),
        GestureDetector(
          onTap: onTapSSO,
          child: Container(
            height: 45,
            width: MediaQuery.of(context).size.width * 0.35,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                color: Colors.white
            ),
            child: const  Text(
              'SSO của Tỉnh',
              style: TextStyle(color: Colors.blueAccent, fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
        )
      ],
    );
  }

}
