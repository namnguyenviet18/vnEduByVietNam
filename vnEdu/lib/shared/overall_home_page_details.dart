
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OHPDetail extends StatelessWidget {
  const OHPDetail({
    super.key,
    required this.icon,
    required this.name,
    required this.value
  });
  final String icon;
  final String name;
  final String value;




  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          child: Image.asset(icon, fit: BoxFit.cover,),
        ),

        const SizedBox(height: 50,),

        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(value,
              style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
             Text(name,
              style: const TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold),)
          ],
        )
      ],
    );
  }

}