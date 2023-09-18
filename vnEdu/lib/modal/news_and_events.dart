
import 'dart:convert';
List<NewsAndEvents> newsAndEventsFromJson(String str) => List<NewsAndEvents>.from(json.decode(str).map((x) => NewsAndEvents.fromJson(x)));

class NewsAndEvents {
  final dynamic id;
  final dynamic donViId;
  final dynamic imageId;
  final dynamic imageUrl;
  final dynamic videoUrl;
  final dynamic categoryId;
  final dynamic title;
  final dynamic description;
  final dynamic content;
  final dynamic siteId;
  final dynamic userId;
  final String createDate;
  final dynamic createUser;
  final dynamic updateDate;
  final dynamic updateUser;
  final dynamic status;
  final dynamic logs;
  final dynamic pageUrl;
  final dynamic shared;
  final dynamic hot;
  final dynamic deleted;
  final dynamic siteTypes;
  final dynamic userName;
  final dynamic fullName;
  final dynamic cateUrl;
  final dynamic cateTitle;
  final dynamic cateId;
  final dynamic leadShort;
  final dynamic stt;
  final dynamic href;

  NewsAndEvents({
    required this.id,
    required this.donViId,
    required this.imageId,
    required this.imageUrl,
    required this.videoUrl,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.content,
    required this.siteId,
    required this.userId,
    required this.createDate,
    required this.createUser,
    required this.updateDate,
    required this.updateUser,
    required this.status,
    required this.logs,
    required this.pageUrl,
    required this.shared,
    required this.hot,
    required this.deleted,
    required this.siteTypes,
    required this.userName,
    required this.fullName,
    required this.cateUrl,
    required this.cateTitle,
    required this.cateId,
    required this.leadShort,
    required this.stt,
    required this.href,
  });


  factory NewsAndEvents.fromJson(Map<String, dynamic> json) {
    return NewsAndEvents(
        id: json['id'],
        donViId: json['don_vi_id'],
        imageId: json['image_id'],
        imageUrl: json['image_url'],
        videoUrl: json['video_url'],
        categoryId: json['category_id'],
        title: json['title'],
        description: json['description'],
        content: json['content'],
        siteId: json['site_id'],
        userId: json['user_id'],
        createDate: json['create_date'],
        createUser: json['create_user'],
        updateDate: json['update_date'],
        updateUser: json['update_user'],
        status: json['status'],
        logs: json['logs'],
        pageUrl: json['page_url'],
        shared: json['shared'],
        hot: json['hot'],
        deleted: json['deleted'],
        siteTypes: json['site_types'],
        userName: json['user_name'],
        fullName: json['fullName'],
        cateUrl: json['cate_url'],
        cateTitle: json['cate_title'],
        cateId: json['cate_id'],
        leadShort: json['lead_short'],
        stt: json['_stt'],
        href: json['href']
    );
  }

}
