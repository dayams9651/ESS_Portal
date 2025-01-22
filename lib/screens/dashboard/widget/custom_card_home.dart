import 'package:flutter/material.dart';
import 'package:ms_ess_potal/style/color.dart';
import 'package:ms_ess_potal/style/text_style.dart';

class CustomHomeCard extends StatelessWidget {
  final IconData ?icon;
  final String text;
  final String text1;
  final String subTitle;
  final Color? iconColor;
  final Color? textColor;
  final Color? backgroundColor;
  final double? iconSize;
  final double ?textSize;
  final EdgeInsetsGeometry ?padding;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow> ?boxShadow;
  final IconButton? iconButton;

  const CustomHomeCard({super.key,
    this.icon,
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
    required this.text1,
    this.iconButton,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double containerWidth = screenWidth < 600 ? screenWidth * 0.47: screenWidth * 0.45; // Smaller width for phone, larger for tablets
    double containerHeight = screenHeight < 600 ? 160 : 144; // Smaller height for phone, larger for tablets
    return Container(
        width: containerWidth,
        height: containerHeight,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.white70),
          boxShadow: boxShadow,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.primaryColor2,
                  child: Icon(icon)),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(text, style: AppTextStyles.kCaption13RegularTextStyle.copyWith(color: AppColors.white50),),
                      Text(text1, style: AppTextStyles.kCaption13SemiBoldTextStyle,),
                    ],
                  ),
                  IconButton(onPressed: (){}, icon: Icon(Icons.refresh_outlined))
                ],
              )
            ],
          ),
        )
    );
  }
}