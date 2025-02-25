import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_portal/noInternet/no_internet_controller.dart';

class NoInternetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NetworkController networkController = Get.find<NetworkController>();
    return Scaffold(
      body: Center(
        child: Obx(() {
          if(networkController.isConnected.value) {
            return SnackBar(content: Text("You are connected to the internet"));
          } else {
            return  Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Colors.white),
                    SizedBox(height: 20),
                    Text(
                      'No Internet Connection',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}