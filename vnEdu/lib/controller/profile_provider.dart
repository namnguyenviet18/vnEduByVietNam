

import 'package:flutter/cupertino.dart';
import 'package:vnedu/modal/user_profile.dart';

class ProfileNotifier extends ChangeNotifier {
  UserProfile? userProfile;
  String tmpAvt = '';
  bool notUpdate = true;

  void updateUserProfile(UserProfile? newProfile) {
    userProfile = newProfile;
    notifyListeners();
  }

  void setTmpAvt(String newAvt) {
    tmpAvt = newAvt;
    notifyListeners();
  }

  void changedNotUpdate(bool state) {
    notUpdate = state;
    notifyListeners();
  }

  void reFresh() {
    userProfile = null;
    tmpAvt = '';
    notUpdate = true;
  }
}