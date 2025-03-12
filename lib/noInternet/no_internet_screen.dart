// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ms_ess_portal/noInternet/no_internet_controller.dart';
//
// class NoInternetScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final NetworkController networkController = Get.find<NetworkController>();
//     return Scaffold(
//       body: Center(
//         child: Obx(() {
//           if(networkController.isConnected.value) {
//             return SnackBar(content: Text("You are connected to the internet"));
//           } else {
//             return  Container(
//               color: Colors.black.withOpacity(0.5),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     CircularProgressIndicator(color: Colors.white),
//                     SizedBox(height: 20),
//                     Text(
//                       'No Internet Connection',
//                       style: TextStyle(color: Colors.white, fontSize: 18),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }
//         }),
//       ),
//     );
//   }
// }


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxController {
  // To store the internet connection status
  var isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Initial check for the connection
    _checkConnectivity();

    // Listen to connectivity changes
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _checkConnectivity();
    });
  }

  // Method to check the connectivity status
  void _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      isConnected.value = false;
    } else {
      isConnected.value = true;
    }
  }
}
