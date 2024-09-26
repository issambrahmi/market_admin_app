import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      required this.text,
      required this.height,
      required this.width,
      this.gradient,
      this.color,
      required this.textSize,
      this.onTap,
      this.textColor});

  final String text;
  final double height;
  final double width;
  final Gradient? gradient;
  final Color? color;
  final double textSize;
  final void Function()? onTap;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            gradient: gradient),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: textSize,
              fontWeight: FontWeight.bold,
              color: textColor ?? Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
