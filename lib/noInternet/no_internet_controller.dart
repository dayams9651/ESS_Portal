import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  // Observable variable to track connectivity status
  var isConnected = false.obs;

  @override
  void onInit() {
    super.onInit();
    _checkInternetConnection();
    _setupConnectivityListener();
  }

  // Check initial internet connection
  void _checkInternetConnection() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    _updateConnectionStatus(connectivityResult);
  }

  // Listen for connectivity changes
  void _setupConnectivityListener() {
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  // Update connection status based on connectivity result
  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      isConnected.value = false;
    } else {
      isConnected.value = true;
    }
  }
}