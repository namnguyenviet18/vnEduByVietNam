

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:vnedu/const/constant.dart';
import 'package:vnedu/controller/notification_provider.dart';
import 'package:vnedu/modal/album.dart' as ab;
import 'package:vnedu/modal/anouncement_detail.dart';
import 'package:vnedu/modal/check_ekyc.dart';
import 'package:vnedu/modal/detail_new.dart';
import 'package:vnedu/modal/intro_infor.dart';
import 'package:vnedu/modal/new_board.dart' as nb;
import 'package:vnedu/modal/new_board.dart';
import 'package:vnedu/modal/new_hot.dart' as nh;
import 'package:vnedu/modal/new_hot.dart';
import 'package:vnedu/modal/news_and_events.dart' as nav;
import 'package:vnedu/modal/notification.dart' as nt;
import 'package:vnedu/modal/others_new_and_event.dart' as on;
import 'package:vnedu/modal/overall.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vnedu/modal/user_profile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';


Future<Overall?> getOverallForHomePage () async {
  Overall? overall;
  try {
    Response response = await get(
      Uri.parse("http://lms-school-node1.vnpt.edu.vn/module/common/service/domain/getOverallForHomePage"),
    );
    if(response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if(data['success']) {
        overall = Overall.fromJson(data['data']);
      }
    }
  }catch (e) {
    print(e.toString());
  }
  return overall;
}



Future<List<dynamic>> getCurrentDomain() async {
  List<dynamic> ans = [];
  IntroInformation? introInformation;
  List<ab.Album?> albums;
  try {
    Response response = await get(
        Uri.parse('http://lms-school-node1.vnpt.edu.vn/module/common/service/domain/getCurrentDomainInformation')
    );

    if(response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if(data['success']) {
        introInformation = IntroInformation.fromJson(data['data']);
        ans.add(introInformation);
        albums = ab.albumFromJson(json.encode(data['data']['album']));
        ans.add(albums);
      }
    }
  } catch(e) {
    print(e.toString());
  }
  return ans;

}


Future<List<nav.NewsAndEvents>> getNewsAndEvents() async {
  List<nav.NewsAndEvents> result = [];
  try {
    Response response = await get(
      Uri.parse("http://lms-school-node1.vnpt.edu.vn/service/news/getListForHomepage"),
    );
    if(response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Thanh cong');
      if(data['success']) {
        result = nav.newsAndEventsFromJson(json.encode(data['data']['data']));
      }
    }else {
      print('that bai');
    }
  } catch(e) {
    print(e.toString());
  }
  return result;
}

Future<String> getToken() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String token = '';
  if (preferences.getString(Constants.TOKEN) != null) {
    token = preferences.getString(Constants.TOKEN)!;
  }
  return token;
}

Future<UserProfile?> getUserInformation(String token) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  UserProfile? userProfile;
  // String? profile.dart = preferences.getString(Constants.USER_PROFILE);
  // print(profile.dart);
  // if(profile.dart != null) {
  //   setState(() {
  //     currentProfile = jsonDecode(profile.dart);
  //   });
  //
  // }
  // print('í null __________ ${currentProfile == null}');
    if(token.isNotEmpty) {
      Response response = await get(
        Uri.parse('http://lms-school-node1.vnpt.edu.vn/service/user/getUserProfile'),
        headers: <String, String> {
          Constants.AUTHORIZATION: token
        },
      );
      if(response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if(data['success']) {
          userProfile = UserProfile(
            ten: data['data']['user_profile']['full_name'],
            lopHoc: data['data']['lopHoc']['ten'],
            diaChi: data['data']['user']['address'],
            donVi: data['data']['user']['ten_don_vi'],
            imageId: data['data']['user_profile']['image_id'],
            avt: data['data']['user_profile']['avatar_url'],
            email: data['data']['user_profile']['email'],
            gioiTinh: data['data']['user_profile']['gioi_tinh'],
            imageIdIdentify: null,
            imageUrlIdentify: null,
            khoiHoc: data['data']['khoiHoc']['name'],
            needChangeIdentifyImage: null,
            ngaySinh: data['data']['user_profile']['birthday'],
            soDienThoai: data['data']['user_profile']['phone'],
            tenDangNhap: data['data']['user_profile']['full_name'],
            publicSensInfor: data['data']['user_profile']['public_sens_info']
          );

          preferences.setString(Constants.USER_PROFILE, data.toString());
      }
    }else {
      print('token is empty');
    }
  }
  return userProfile;
}

Future<bool> changeIdentifyImage(String recordId, String token, String typeAction) async{
  try {
    Response response = await post(
      Uri.parse('http://lms-school-node1.vnpt.edu.vn/service/user/changeIdentifyImage'),
        headers: <String, String> {
          Constants.AUTHORIZATION: token
        },
      body: <String, String> {
        "recordId": recordId,
        "typeAction": typeAction
      }
    );

    if(response.statusCode == 200) {
      final result = jsonDecode(response.body);
      print(result);
      if(result['success']) {
        return true;
      }
    }
  } catch(e) {
    print(e.toString());
  }
  return false;
}

Future<CheckEkyc?> callCheckEkyc(String token) async {
  CheckEkyc? checkEkyc;
  try {
    Response response = await get(
      Uri.parse('http://lms-school-node1.vnpt.edu.vn/service/user/checkEkyc'),
      headers: <String, String> {
        Constants.AUTHORIZATION: token
      },
    );
    if(response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if(data['success']) {
        checkEkyc = CheckEkyc.fromJson(data['data']['userProfileInfo']);
      }
    }else {
      print('failure ___________________');
    }
  }catch(e) {
    print(e.toString());
  }
  return checkEkyc;
}

Future<List<NewBoard>> getNewBoard() async {
  List<NewBoard> newBoards = [];
  try {
    Response response = await get(
      Uri.parse("http://lms-school-node1.vnpt.edu.vn/service/announcement/getListForHomepage")
    );
    if(response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if(data['success']) {
        newBoards = nb.newBoardsFromJson(json.encode(data['data']['data']));
      }
    }

  } catch(e) {
    print(e.toString());
  }

  return newBoards;
}


Future<List<NewBoard>> getList() async {
  List<NewBoard> newBoards = [];
  try {
    Response response = await get(
        Uri.parse("http://lms-school-node1.vnpt.edu.vn/service/announcement/getList")
    );
    if(response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if(data['success']) {
        newBoards = nb.newBoardsFromJson(json.encode(data['data']['data']['data']));
      }
    }

  } catch(e) {
    print(e.toString());
  }

  return newBoards;
}

Future<AnnouncementDetail?> getAnnouncementDetail(String id) async {
  AnnouncementDetail? announcementDetail;
  try {
    Response response = await post(
      Uri.parse("http://lms-school-node1.vnpt.edu.vn/service/announcement/getDetailAnnouncement"),
      body: <String, String> {
        "id": id
      }
    );
    if(response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if(data['success']) {
        announcementDetail = AnnouncementDetail.fromJson(data['data']);
      }
    }
  } catch(e) {
    print(e.toString());
  }
  return announcementDetail;
}

Future<List<NewHots>> getNewHots() async {
  List<NewHots> newHots = [];
  try {
    Response response = await get(
      Uri.parse("http://lms-school-node1.vnpt.edu.vn/service/announcement/getNewHot")
    );

    if(response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      if(data['success']) {
        newHots = nh.newHotsFromJson(json.encode(data['data']));
      }
    }

  } catch(e) {
    print(e.toString());
  }
  return newHots;
}

Future<DetailNew?> getDetailNew(String id) async {
  DetailNew? detailNew;
  try {
    Response response = await get(
      Uri.parse("http://lms-school-node1.vnpt.edu.vn/service/news/getDetailNew?id=$id")
    );
    if(response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if(data['success']) {
        detailNew = DetailNew.fromJson(data['data']);
      }
    }
  } catch(e) {
    print(e.toString());
  }
  return detailNew;
}

Future<List<on.OthersNewAndEvent>> getOthersNewAndEvent() async {
  List<on.OthersNewAndEvent> othersNew = [];
  try {
    Response response = await get(
      Uri.parse("http://lms-school-node1.vnpt.edu.vn/service/news/getNewHot")
    );
    if(response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if(data['success']) {
        othersNew = on.othersNewAndEventsFromJson(json.encode(data['data']));
      }
    }
  } catch(e) {
    print(e.toString());
  }
  return othersNew;
}


Future<void> huongDanSuDung() async {
  Uri url = Uri.parse("https://lms.vnedu.vn/trang-tinh/huong-dan-su-dung");
  if(!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}


Future<void> openAppStore() async {
  final url = Uri.parse("https://apps.apple.com/us/app/vnedu-lms/id1501291334?ls=1");
  if(!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

Future<void> openCHPlay() async {
  final url = Uri.parse("https://play.google.com/store/apps/details?id=com.vnptit.schoolelearning");
  if(!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

Future<List<nt.Notifications>> getNotifications(String token) async {
  print('get');
  List<nt.Notifications> notifications = [];
  try {
    Response response = await get(
      Uri.parse("http://lms-school-node1.vnpt.edu.vn/service/notification/getNotification?page=1&limit=10"),
      headers: <String, String> {
        Constants.AUTHORIZATION: token
      }
    );
    if(response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      if(data['success']) {
        print('get notification success');
        notifications = nt.notificationsFromJson(json.encode(data['data']));
      }
    }else {
      print('fail');
    }
  } catch(e) {
    print(e.toString());
  }
  return notifications;
}

//http://lms-school-node1.vnpt.edu.vn/service/notification/getNotificationByUserV2

Future<List<dynamic>> getNotificationsByUser(String token, String start, String isRead, order) async {
  List<nt.Notifications> notifications = [];
  List<dynamic> result = [];
  int total = 0;
  try {
    Response response = await get(
      Uri.parse("http://lms-school-node1.vnpt.edu.vn/service/notification/getNotificationByUserV2?start=$start&limit=6&is_read=$isRead&order=$order"),
      headers: <String, String> {
        Constants.AUTHORIZATION: token
      },
    );
    if(response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      if(data['success']) {
        notifications = nt.notificationsFromJson(json.encode(data['data']["notifications"]["data"]));
        total = data['data']['total'];
      }
    }else {
      print('fail');
    }

  } catch(e) {
    print(e.toString());
  }
  result.add(notifications);
  result.add(total);
  return result;
}

Future<bool> deleteNotifications(Map<String, String> body, String token) async {
  bool isSuccess = false;
  try {
    Response response = await post(
      Uri.parse("http://lms-school-node1.vnpt.edu.vn/service/notification/deleteNotification"),
      headers: <String, String> {
        Constants.AUTHORIZATION: token
      },
      body: body
    );
    if(response.statusCode == 200) {
      final data = jsonDecode(response.body);
      isSuccess = data['success'];
    }
  } catch(e) {
    print(e.toString());
  }
  return isSuccess;
}
///http://lms-school-node1.vnpt.edu.vn/service/notification/notificationMarkRead

Future<bool> notificationMarkRead(Map<String, String> body, String token) async {
  bool isSucees = false;
  try {
    Response response = await post(
      Uri.parse("http://lms-school-node1.vnpt.edu.vn/service/notification/notificationMarkRead"),
      body: body,
      headers: <String, String> {
        Constants.AUTHORIZATION: token
      },
    );
    if(response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      isSucees = data['success'];
    }
  } catch(e) {
    print(e.toString());
  }
  return isSucees;
}
