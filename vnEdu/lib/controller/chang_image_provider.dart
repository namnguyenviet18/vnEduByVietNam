

import 'package:flutter/cupertino.dart';
import 'package:vnedu/modal/check_ekyc.dart';
import 'package:vnedu/service_class.dart';

class ChangeImageProvider extends ChangeNotifier {
  CheckEkyc? checkEkyc;

  bool isCancelledRequestIdentifyImage = false;

  Future<void> getCheckEkyc()  async {
    getToken().then((token) async {
      checkEkyc = await callCheckEkyc(token);
      if(checkEkyc?.need_change_identify_image == 0) {
        isCancelledRequestIdentifyImage = false;
      }else if(checkEkyc?.need_change_identify_image == 1) {
        isCancelledRequestIdentifyImage = true;
      }
      notifyListeners();
    });
  }

  void clickChangeIdentifyImage(String recordId, String typeAction)  {
    getToken().then((token) async {
      bool result = await changeIdentifyImage(recordId, token, typeAction);
      if(result) {
        isCancelledRequestIdentifyImage = !isCancelledRequestIdentifyImage;
        notifyListeners();
      }
    });
  }
}