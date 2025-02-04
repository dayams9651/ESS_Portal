import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:ms_ess_portal/style/color.dart';

import '../../../style/text_style.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<NotificationItem> notifications = [
    NotificationItem(
      icon: Icons.notifications,
      title: 'New Message',
      subtitle: 'You have a new message from John',
      time: '12:30 PM',
    ),
    NotificationItem(
      icon: Icons.event,
      title: 'Event Reminder',
      subtitle: 'Don\'t forget about your meeting at 2 PM',
      time: '11:45 AM',
    ),
    NotificationItem(
      icon: Icons.update,
      title: 'App Update Available',
      subtitle: 'New update for the app is available!',
      time: '10:00 AM',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Center(child: Text("Notification", style: AppTextStyles.kPrimaryTextStyle)),
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 24),
          onPressed: () {
            Navigator.pop(context); // Use Navigator instead of Get.back() for stateful widgets
          },
        ),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: Card(
              color: AppColors.white,
              elevation: 12.0,
              child: ListTile(
                leading: Icon(notification.icon),
                title: Text(notification.title, style: AppTextStyles.kSmall12SemiBoldTextStyle,),
                subtitle: Text(notification.subtitle, style: AppTextStyles.kSmall10RegularTextStyle,),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      notification.time,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class NotificationItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;

  NotificationItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
  });
}