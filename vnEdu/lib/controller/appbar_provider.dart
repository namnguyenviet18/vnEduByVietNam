

import 'package:flutter/cupertino.dart';
import 'package:vnedu/modal/album.dart';
import 'package:vnedu/modal/anouncement_detail.dart';
import 'package:vnedu/modal/detail_new.dart';
import 'package:vnedu/modal/intro_infor.dart';
import 'package:vnedu/modal/new_board.dart';
import 'package:vnedu/modal/new_hot.dart';
import 'package:vnedu/modal/news_and_events.dart';
import 'package:vnedu/modal/notification.dart';
import 'package:vnedu/modal/others_new_and_event.dart';
import 'package:vnedu/modal/overall.dart';
import 'package:vnedu/modal/user_profile.dart';
import 'package:vnedu/service_class.dart';

class AppBarNotifier extends ChangeNotifier {
  List<bool> choices = [false, false, false, false, false];
  bool isShowStudyCornerDetails = false;
  UserProfile? userProfile;
  IntroInformation? introInformation;
  Overall? overall;
  bool isLoading = false;
  bool notUpdate = true;
  List<NewBoard> newBoards = [];
  AnnouncementDetail? announcementDetail;
  List<NewHots> newHots = [];
  List<Album> albums = [];
  List<Notifications> notifications = [];

  Future<void> getListNotification() async {
    getToken().then((token) async {
      notifications = await getNotifications(token);
      notifyListeners();
    });
  }

  int selectedPageAlbum = 0;
  int selectedPageNewAndEvent = 0;

  List<NewsAndEvents> listNewsAndEvents = [];



  List<OthersNewAndEvent> othersNewAndEvent = [];
  DetailNew? detailNew;

  Future<void> getDataForDetailNewScreen(String id) async {
    detailNew = await getDetailNew(id);
    othersNewAndEvent = await getOthersNewAndEvent();
    notifyListeners();
  }

  void updateDetailNew(String id) async {
    detailNew = await getDetailNew(id);
    notifyListeners();
  }


  void setSelectedPageAlbum(int newIndex) {
    selectedPageAlbum = newIndex;
    notifyListeners();
  }

  void setSelectedPageNewAndEvent(int newIndex) {
    selectedPageNewAndEvent = newIndex;
    notifyListeners();
  }


  Future<void> getAnnouncementDetailForNewPage(String id) async {
    announcementDetail = await getAnnouncementDetail(id);
    newHots = await getNewHots();
    notifyListeners();
  }

  void setAnnouncementDetail(AnnouncementDetail? newAnnoun) {
    announcementDetail = newAnnoun;
    notifyListeners();
  }


  Future<void> getDataForNewBoardPage() async {
    isLoading = true;
    notifyListeners();
    newBoards = await getList();
    isLoading = false;
    notifyListeners();
  }
  // thong bao -> basket -> profile -> quocki -> menu

  void changedNotUpdate(bool state) {
    notUpdate = state;
    notifyListeners();
  }

  void updateUserProfile(UserProfile? newProfile) {
    userProfile = newProfile;
    notifyListeners();
    changedNotUpdate(true);
    notifyListeners();
  }

  Future<void> getData() async {
    print('get data');
    isLoading = true;
    notifyListeners();
    userProfile = await getToken().then((token) => getUserInformation(token));
    List<dynamic> domain = await getCurrentDomain();
    if(domain.isNotEmpty) {
      introInformation = domain[0];
      albums = domain[1];
    }
    listNewsAndEvents = await getNewsAndEvents();
    overall = await getOverallForHomePage();
    newBoards = await getNewBoard();
    isLoading = false;
    notifyListeners();
  }

  void changedOption(int index) {
    for(int i = 0; i < 5; i++) {
      if(index == i) {
        choices[i] = !choices[i];
      }else {
        choices[i] = false;
      }
    }
    notifyListeners();
  }

  void changedShowStudyCornerDetails() {
    isShowStudyCornerDetails = !isShowStudyCornerDetails;
    notifyListeners();
  }

  void refresh() {
    notUpdate = true;
    for(int i = 0; i < 5; i++) {
      choices[i] = false;
    }
    isShowStudyCornerDetails = false;
    notifyListeners();
  }

}
