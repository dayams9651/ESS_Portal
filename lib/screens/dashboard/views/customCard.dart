import 'package:flutter/material.dart';

class CustomHomeCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final String text1;
  final String subTitle;
  final IconButton iconButton;

  const CustomHomeCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.text1,
    required this.subTitle,
    required this.iconButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Icon(icon),
          Text(text),
          Text(text1),
          Text(subTitle),
          iconButton,
        ],
      ),
    );
  }
}
