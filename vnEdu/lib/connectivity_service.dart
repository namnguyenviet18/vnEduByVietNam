
import 'package:connectivity_plus/connectivity_plus.dart';

typedef void ConnectivityCallback(bool isConnected);

class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._();

  final Connectivity _connectivity = Connectivity();
  bool _isConnected = false;
  List<ConnectivityCallback> _callBacks = [];

  ConnectivityService._() {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
        _isConnected = true;
      }else {
        _isConnected = false;
      }
      for (var callBack in _callBacks) {
        callBack(_isConnected);
      }
    });
  }

  factory ConnectivityService() => _instance;

  Future<void> checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
      _isConnected = true;
    }else {
      _isConnected = false;
    }
    for (var callBack in _callBacks) {
      callBack(_isConnected);
    }
  }

  void addCallBack(ConnectivityCallback callback) {
    _callBacks.add(callback);
  }

  void removeCallBack(ConnectivityCallback callback) {
    _callBacks.remove(callback);
  }

  List<ConnectivityCallback> get getListCallBack => _callBacks;

  bool get isConnected => _isConnected;
}