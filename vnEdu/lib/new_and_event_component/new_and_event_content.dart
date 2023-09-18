


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:vnedu/modal/detail_new.dart';
import 'package:vnedu/shared/format_date.dart';
import 'package:html/parser.dart';

class NewContent extends StatelessWidget {
  const NewContent({super.key, required this.detailNew});
  final DetailNew? detailNew;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              detailNew!.title,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w500
              ),
              maxLines: 10,
            ),
          ),
          const SizedBox(height: 15,),
          Text(
            '${formatDateHH_MM_dd_MM_yyyy(detailNew!.createDate)} | Bởi ${detailNew!.creatorName}',
            style: const TextStyle(
                fontSize: 17,
                color: Colors.black54,
                fontWeight: FontWeight.w500
            ),
          ),
          const SizedBox(height: 20,),
          const Divider(height: 2, color: Colors.grey,),
          const SizedBox(height: 10,),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(
              parse(parse(detailNew?.description).body?.text).documentElement!.text,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17
              ),
              maxLines: null,
            ),
          ),
          const SizedBox(height: 15,),
          Html(
            data: detailNew?.content,
            style: {
              "p": Style(
                  fontSize: FontSize(15),
                  color: Colors.black54
              )
            },
          )
        ],
      ),
    );
  }
}