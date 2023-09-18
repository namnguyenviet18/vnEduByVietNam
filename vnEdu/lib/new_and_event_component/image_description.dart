

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vnedu/modal/news_and_events.dart';
import 'package:html/parser.dart';

class ImageDescription extends StatelessWidget {
  const ImageDescription({super.key, required this.newsAndEvents, required this.isHideTitle});
  final NewsAndEvents? newsAndEvents;
  final bool isHideTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 400,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 400,
            child: Image.network(
              parse(parse(newsAndEvents?.imageUrl).body?.text).documentElement!.text,
              fit: BoxFit.cover,
            ),
          ),
          if(!isHideTitle)
          Positioned(
            bottom: 50,
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              child: Text(
                newsAndEvents?.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 17
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}