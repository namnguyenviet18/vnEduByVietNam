

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';
import 'package:vnedu/controller/appbar_provider.dart';

class WelCome extends StatelessWidget {
  const WelCome({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppBarNotifier>(context, listen: false);
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.35,
          child: Image.network(
            parse(parse(provider.albums[0].imageUrl).body?.text).documentElement!.text, fit: BoxFit.cover,
          )
        ),
        Positioned(
          left: 10,
          top: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            color: Colors.purple[900],
            child: const Text(
              'chào mừng bạn đến với',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ),
        Positioned(
          left: 10,
          top: 27,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            color: Colors.purple[900],
            child: const Text(
              'Hệ thống dạy học trực tuyến (vnEdu LMS) của',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ),
        Positioned(
          left: 10,
          top: 45,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            color: Colors.amber,
            child: Text(
              provider.introInformation?.tenDonVi,
              style: const TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            color: Colors.purple[900],
            child:  Text(
              provider.introInformation?.headerBannerText,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        )
      ],
    );
  }
}