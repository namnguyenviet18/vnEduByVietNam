

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vnedu/modal/news_and_events.dart';
import 'package:vnedu/shared/format_date.dart';
import 'package:html/parser.dart';

class PreviewNewsAndEvent extends StatelessWidget {
  const PreviewNewsAndEvent({super.key, required this.newsAndEvents, required this.showDetails});
  final NewsAndEvents? newsAndEvents;
  final void Function()? showDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 400,
      color: Colors.blue.withOpacity(0.7),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.calendar_today_outlined, color: Colors.white, size: 17,),
              const SizedBox(width: 5,),
              Text(
                formatDate_dd_mm_yyyy(newsAndEvents!.createDate.substring(0, 10)),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15
                ),
              )
            ],
          ),
          const SizedBox(height: 10,),
          const Divider(height: 2,),
          const SizedBox(height: 40,),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  newsAndEvents?.title,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15,),
                Text(
                  parse(parse(newsAndEvents?.leadShort).body?.text).documentElement!.text,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40,),
                ElevatedButton(
                    onPressed: showDetails,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(150, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.white
                    ),
                    child: const Text(
                      'Xem chi tiết',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500
                      ),
                    )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}