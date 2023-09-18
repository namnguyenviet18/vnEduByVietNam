import 'dart:convert';
List<Notifications> notificationsFromJson(String str) => List<Notifications>.from(json.decode(str).map((x) => Notifications.fromJson(x)));

class Notifications {
  final String id;
  final String siteId;
  final String userId;
  final String createDate;
  final String title;
  final String content;
  final String type;
  final dynamic icon;
  final String url;
  final int isRead;
  final String createDateAgo;

  Notifications({
    required this.id,
    required this.siteId,
    required this.userId,
    required this.createDate,
    required this.title,
    required this.content,
    required this.type,
    required this.icon,
    required this.url,
    required this.isRead,
    required this.createDateAgo,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json['id'],
      siteId: json['site_id'],
      userId: json['user_id'],
      createDate: json['create_date'],
      title: json['title'],
      content: json['content'],
      type: json['type'],
      icon: json['icon'],
      url: json['url'],
      isRead: json['is_read'],
      createDateAgo: json['create_date_ago'],
    );
  }

}
