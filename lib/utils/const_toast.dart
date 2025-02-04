import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConstToast extends GetxController {
  static ConstToast get to => Get.find();

  void showDialog({
    String title = "Alert",
    String message = "",
    String onConfirm1Text1 = "",
    String onConfirm1Text2 = "",
    Function()? onConfirm2,
    Function()? onConfirm1,
  }) {
    Get.defaultDialog(
      backgroundColor: Colors.white,
      title: title,
      content: Text(message),
      actions: [
        TextButton(
          onPressed: onConfirm1 ?? () {},
          child: Text(onConfirm1Text1),
        ),
        TextButton(
          onPressed: onConfirm2 ?? () {}, // Execute onConfirm if provided
          child: Text(onConfirm1Text2),
        ),
      ],
    );
  }

  void showSuccess(String message) {
    Get.snackbar('Success', message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        icon: const Icon(
          Icons.check_circle,
          color: Colors.white,
        ),
        margin: const EdgeInsets.all(8));
  }

  void showError(String message) {
    Get.snackbar('Error', message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(
          Icons.error,
          // Icons.check_circle,
          color: Colors.white,
        ),
        isDismissible: true,
        // dismissDirection: ,
        // dismissDirection: SnackDismissDirection.HORIZONTAL,
        forwardAnimationCurve: Curves.easeOutBack,
        margin: const EdgeInsets.all(8));
  }

  void showInfo(String message) {
    Get.snackbar('Info', message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        forwardAnimationCurve: Curves.easeOutBack,
        icon: const Icon(Icons.add_alert),
        margin: const EdgeInsets.all(8));
  }

  void showCustomToast(
      String title, String message, Color backgroundColor, Color textColor) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: backgroundColor,
        colorText: textColor,
        margin: const EdgeInsets.all(8));
  }
}
