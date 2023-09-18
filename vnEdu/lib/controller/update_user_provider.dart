


import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:vnedu/service_class.dart';


class UpdateUserNotifier extends ChangeNotifier {
  bool isValidBirth = true;
  bool isValidPhoneNumber = true;
  bool isValidAddress = true;
  bool isValidPassword = true;
  bool isValidConfirmPassword = true;
  String sex = '';
  bool visibleIcon = true;
  bool isShowStd = false;
  XFile? selectedImage;
  String errorPhoneNumber = '';


  void getErrorPhoneNumber(String value) {
    if(value.isEmpty) {
      isValidPhoneNumber = false;
      errorPhoneNumber = 'Vui lòng nhập số điện thoại';
    }else if(value.isNotEmpty && value.length < 10 || value.contains(RegExp(r'[a-zA-Z]'))) {
      isValidPhoneNumber = false;
      errorPhoneNumber = 'Số điện thoại không hợp lệ';
    } else {
      isValidPhoneNumber = true;
      errorPhoneNumber = '';
    }

    notifyListeners();
  }

  void changedShowStd() {
    isShowStd = !isShowStd;
    notifyListeners();
  }

  void setIsShowSDT(bool value) {
    isShowStd = value;
    notifyListeners();
  }

  Future<void> pickImageFromGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image == null) return;
    selectedImage = image;
    print(await image.readAsBytes());
    notifyListeners();

  }


  void onChangedVisibleIcon() {
    visibleIcon = !visibleIcon;
    notifyListeners();
  }

  void onChangedBirth(String value) {
    if(value.isEmpty) {
      isValidBirth = false;
    }else {
      isValidBirth = true;
    }
    notifyListeners();
  }

  void onChangedPhoneNumber(String value) {
    if(value.isEmpty) {
      isValidPhoneNumber = false;
    }else {
      isValidPhoneNumber = true;
    }
    notifyListeners();
  }

  void onChangedAddress(String value) {
    if(value.isEmpty) {
      isValidAddress = false;
    }else {
      isValidAddress = true;
    }
    notifyListeners();
  }

  void setSex(String value) {
    sex = value;
    notifyListeners();
  }

  void onChangedPassword(String value) {
    if(value.isNotEmpty && value.length < 8 || !value.contains(RegExp(r'[A-Z]')) || !value.contains(RegExp(r'[a-z]'))
        || !value.contains(RegExp(r'\d')) || !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      isValidPassword = false;
    }else {
      isValidPassword = true;
    }
    notifyListeners();
  }

  void onChangedConfirmPassword(String value) {
    if(value.isNotEmpty && value.length < 8 || !value.contains(RegExp(r'[A-Z]')) || !value.contains(RegExp(r'[a-z]'))
        || !value.contains(RegExp(r'\d')) || !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      isValidConfirmPassword = false;
    }else {
      isValidConfirmPassword = true;
    }
    notifyListeners();
  }





}