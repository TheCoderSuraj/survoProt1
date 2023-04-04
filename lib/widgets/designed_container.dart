import 'package:flutter/material.dart';

import '../utils/constants.dart';

class DesignedContainer extends StatelessWidget {
  const DesignedContainer({
    Key? key,
    this.color = kHighLightColor,
    this.child,
    this.width,
    this.minHeight,
    this.padding = kPagePadding,
    this.gradient,
  }) : super(key: key);

  final Color? color;
  final Widget? child;
  final double? width;
  final double? minHeight;
  final EdgeInsets? padding;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return Material(
      // elevation: 2.0,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Container(
          width: width,
          margin: const EdgeInsets.symmetric(
            vertical: 5,
          ),
          padding: padding,
          constraints: BoxConstraints(minHeight: minHeight ?? 0),
          decoration: BoxDecoration(
            gradient: gradient,
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: child,
        ),
      ),
    );
  }
}
