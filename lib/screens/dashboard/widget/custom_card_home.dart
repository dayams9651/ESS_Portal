import 'package:flutter/material.dart';
import 'package:ms_ess_portal/style/color.dart';
import 'package:ms_ess_portal/style/text_style.dart';

class CustomHomeCard extends StatefulWidget {
  final IconData? icon;
  final String text;
  final String text1;
  final String subTitle;
  final Color? iconColor;
  final Color? textColor;
  final Color? backgroundColor;
  final double? iconSize;
  final double? textSize;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final IconButton? iconButton;

  const CustomHomeCard({
    super.key,
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
    this.iconButton, // Pass the iconButton parameter here
  });

  @override
  _CustomHomeCardState createState() => _CustomHomeCardState();
}

class _CustomHomeCardState extends State<CustomHomeCard> {
  bool isLoading = false;

  void handleIconButtonClick() {
    setState(() {
      isLoading = true;
    });

    // Simulating a delay (for example, a network request)
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double containerWidth = screenWidth < 600 ? screenWidth * 0.47 : screenWidth * 0.45;
    double containerHeight = screenHeight < 600 ? 160 : 144;

    return Container(
      width: containerWidth,
      height: containerHeight,
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.white70),
        boxShadow: widget.boxShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: AppColors.primaryColor2,
              child: Icon(widget.icon),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.text,
                      style: AppTextStyles.kCaption13RegularTextStyle.copyWith(color: AppColors.white50),
                    ),
                    Text(
                      widget.text1,
                      style: AppTextStyles.kCaption13SemiBoldTextStyle,
                    ),
                  ],
                ),
                if (widget.iconButton != null)
                  IconButton(
                    icon: isLoading
                        ? CircularProgressIndicator(color: AppColors.primaryColor2)
                        : widget.iconButton!.icon!,
                    onPressed: handleIconButtonClick,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

