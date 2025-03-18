
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxController {
  var isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    _checkConnectivity();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _checkConnectivity();
    });
  }
  void _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      isConnected.value = false;
    } else {
      isConnected.value = true;
    }
  }
}
