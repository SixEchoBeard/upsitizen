import 'package:flutter/material.dart';
import 'package:upsitizen/theme/color.dart';

class RoundTextBox extends StatelessWidget {
  const RoundTextBox(
      {Key? key, this.prefixIcon, this.hintText, this.controller})
      : super(key: key);
  final Widget? prefixIcon;
  final String? hintText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(50)),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: textColor),
        decoration: InputDecoration(
            prefixIcon: prefixIcon,
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 17)),
      ),
    );
  }
}
