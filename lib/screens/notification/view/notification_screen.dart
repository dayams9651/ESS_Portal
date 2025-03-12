import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ms_ess_portal/style/color.dart';
import 'package:ms_ess_portal/style/text_style.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  void onInitState(){
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize("77d4afee-a29f-4dfd-8b18-11e0384bffc1");
    OneSignal.Notifications.requestPermission(true);
  }
  String getTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} min${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    final String? msgTitle = GetStorage().read('msg_title');
    final String? msgDis = GetStorage().read('msg_dis');
    final String? timestampStr = GetStorage().read('msg_timestamp');

    String displayMessage = "No title available";
    String displayDescription = "No description available";
    String timeAgo = '';

    if (msgTitle != null && timestampStr != null) {
      DateTime timestamp = DateTime.parse(timestampStr);
      if (DateTime.now().difference(timestamp).inDays <= 2) {
        displayMessage = msgTitle;
        displayDescription = msgDis ?? "No description available";
        timeAgo = getTimeAgo(timestamp);
      } else {
        GetStorage().remove('msg_title');
        GetStorage().remove('msg_timestamp');
        GetStorage().remove('msg_dis');
      }
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Center(child: Text("Notification", style: AppTextStyles.kPrimaryTextStyle)),
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 24),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          Card(
            color: AppColors.white10,
            elevation: 7,
            child: ListTile(
              title: Text(
                displayMessage,
                style: AppTextStyles.kSmall12SemiBoldTextStyle,
              ),
              subtitle: Text(
                displayDescription,
                style: AppTextStyles.kSmall10RegularTextStyle,
              ),
              leading: Icon(Icons.notifications_outlined, size: 30),
              trailing: Text(timeAgo),
            ),
          ),
        ],
      ),
    );
  }
}
