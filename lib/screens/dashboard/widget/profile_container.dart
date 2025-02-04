import 'package:flutter/material.dart';
import 'package:ms_ess_portal/style/color.dart';
import 'package:ms_ess_portal/style/text_style.dart';

class ProfileContainer extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? iconColor;
  final Color? textColor;
  final Color? backgroundColor;
  final double? iconSize;
  final double? textSize;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final VoidCallback? onTap; // Added onTap property to handle tap

  const ProfileContainer({
    super.key,
    required this.icon,
    required this.text,
    this.iconColor,
    this.textColor,
    this.backgroundColor,
    this.iconSize,
    this.textSize,
    this.padding,
    this.borderRadius,
    this.boxShadow,
    this.onTap, // Added onTap to constructor
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double containerWidth = screenWidth < 600 ? screenWidth * 1 : screenWidth * 1;
    double containerHeight = screenHeight < 600 ? 100 : 65;

    return GestureDetector(
      onTap: onTap, // Trigger the onTap callback when the container is tapped
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          width: containerWidth,
          height: containerHeight,
          padding: padding,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.white50),
            boxShadow: boxShadow,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(icon, color: AppColors.primaryColor, size: 30),
                      const SizedBox(width: 15),
                      Text(
                        text,
                        style: AppTextStyles.kCaption14SemiBoldTextStyle,
                      ),
                    ],
                  ),
                ),
                const CircleAvatar(
                  radius:18,
                  backgroundColor: AppColors.primary1,
                  child: Icon(Icons.add),
                ),
                const SizedBox(height: 60,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
