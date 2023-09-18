
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:vnedu/modal/anouncement_detail.dart';
import 'package:vnedu/shared/announcement_detail.dart';
import 'package:vnedu/shared/format_date.dart';

class AnnouncementDetailPage extends StatelessWidget {
  const AnnouncementDetailPage({super.key, required this.announcementDetail});
  final AnnouncementDetail? announcementDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              announcementDetail!.title,
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
            '${formatDateHH_MM_dd_MM_yyyy(announcementDetail!.createDate)} | Bởi ${announcementDetail!.creatorName}',
            style: const TextStyle(
              fontSize: 17,
              color: Colors.black54,
              fontWeight: FontWeight.w500
            ),
          ),
          const SizedBox(height: 20,),
          const Divider(height: 2, color: Colors.grey,),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(
              announcementDetail!.description,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 17
              ),
              maxLines: null,
            ),
          ),
          const SizedBox(height: 15,),
          Html(
            data: announcementDetail?.content,
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