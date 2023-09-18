import 'dart:convert';
List<NewBoard> newBoardsFromJson(String str) => List<NewBoard>.from(json.decode(str).map((x) => NewBoard.fromJson(x)));

class NewBoard {
  final String id;
  final String donViId;
  final String imageId;
  final dynamic imageUrl;
  final dynamic videoUrl;
  final String categoryId;
  final String title;
  final String description;
  final String content;
  final String siteId;
  final dynamic userId;
  final String createDate;
  final String createUser;
  final String updateDate;
  final String updateUser;
  final int status;
  final dynamic logs;
  final dynamic pageUrl;
  final int shared;
  final int hot;
  final int deleted;
  final int isPublic;
  final dynamic lopId;
  final dynamic siteTypes;
  final String userName;
  final String fullName;
  final String tenDonVi;
  final dynamic left;
  final dynamic right;
  final String tenDanhMuc;
  final String href;

  NewBoard({
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
    required this.isPublic,
    required this.lopId,
    required this.siteTypes,
    required this.userName,
    required this.fullName,
    required this.tenDonVi,
    required this.left,
    required this.right,
    required this.tenDanhMuc,
    required this.href,
  });


  factory NewBoard.fromJson(Map<String, dynamic> json) {
    return NewBoard(
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
        isPublic: json['is_public'],
        lopId: json['lop_id'],
        siteTypes: json['site_types'],
        userName: json['user_name'],
        fullName: json['full_name'],
        tenDonVi: json['ten_don_vi'],
        left: json['__left'],
        right: json['__right'],
        tenDanhMuc: json['ten_danh_muc'],
        href: json['href']
    );
  }

}