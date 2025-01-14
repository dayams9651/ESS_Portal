import 'package:flutter/material.dart';
import 'package:ms_ess_potal/style/color.dart';
import 'package:ms_ess_potal/style/text_style.dart';

class CustomContainer extends StatelessWidget {
  final IconData icon;
  final String text;
  final String subTitle;
  final Color? iconColor;
  final Color? textColor;
  final Color? backgroundColor;
  final double? iconSize;
  final double ?textSize;
  final EdgeInsetsGeometry ?padding;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow> ?boxShadow;

  CustomContainer({
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
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double containerWidth = screenWidth < 600 ? screenWidth * 0.47: screenWidth * 0.47; // Smaller width for phone, larger for tablets
    double containerHeight = screenHeight < 600 ? 100 : 75; // Smaller height for phone, larger for tablets
    return Container(
      width: containerWidth,
      height: containerHeight,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.white70),
        boxShadow: boxShadow,
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(text, style: AppTextStyles.kSmall10SemiBoldTextStyle.copyWith(color: AppColors.primaryColor),),
            subtitle: Text(subTitle, style: AppTextStyles.kSmall12SemiBoldTextStyle,),
            trailing: Icon(icon),
          )
        ],
      )
    );
  }
}