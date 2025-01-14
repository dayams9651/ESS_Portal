import 'package:flutter/material.dart';
import 'package:ms_ess_potal/style/color.dart';

import '../../style/text_style.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  final Icon ? icon;
  final Color? color; // This will allow the custom color

  const RoundButton({
    super.key,
    this.color, // Optional parameter to pass custom color
    required this.title,
    required this.onTap,
    this.loading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // Use the custom color if provided, otherwise default to primary color
    final buttonColor = color ?? AppColors.primaryColor;

    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Center(
            child: loading
                ? const CircularProgressIndicator(
                strokeWidth: 3, color: Colors.white)
                : Text(
              title,
              style: AppTextStyles.kPrimaryTextStyle.copyWith(color: AppColors.white),
            ),
          ),
        ),
      ),
    );
  }
}
