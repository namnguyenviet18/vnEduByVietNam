

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vnedu/modal/others_new_and_event.dart';
import 'package:html/parser.dart';
import 'package:vnedu/shared/format_date.dart';
class OtherNewItem extends StatelessWidget {
  const OtherNewItem({super.key, required this.othersNewAndEvent, required this.onTapShowDetail});
  final OthersNewAndEvent? othersNewAndEvent;
  final void Function()? onTapShowDetail;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * (1.85 / 5),
            height: 80,
            margin: const EdgeInsets.only(right: 3),
            child: Image.network(
              parse(parse(othersNewAndEvent?.imageUrl).body?.text).documentElement!.text,
              fit: BoxFit.cover,
            ),
          ) ,
          const SizedBox(width: 8,),
          Container(
            width: MediaQuery.of(context).size.width * (2.39 / 5),
            height: 75,
            margin: const EdgeInsets.only(left: 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: onTapShowDetail,
                  child: Text(
                    othersNewAndEvent!.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 15
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.calendar_today_outlined, color: Colors.black, size: 17,),
                    const SizedBox(width: 5,),
                    Text(
                      formatDate_dd_mm_yyyy(othersNewAndEvent!.createDate.substring(0, 10)),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15
                      ),
                    )
                  ],
                ),
              ],
            )
          ) ,
        ],
      ),
    );
  }
}