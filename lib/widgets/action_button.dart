import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.widthRatio = 0.6,
    this.backgroundColor,
    this.padding = const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
    this.radius = 8,
  });
  final Function() onPressed;
  final String title;
  final double widthRatio;
  final Color? backgroundColor;
  final EdgeInsets padding;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: Size(MediaQuery.of(context).size.width * widthRatio, 25),
        padding: padding,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 25,
        ),
      ),
    );
  }
}
