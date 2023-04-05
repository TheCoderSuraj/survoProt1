import 'package:flutter/material.dart';
import '../utils/constants.dart';

class ScreenPageSetup extends StatelessWidget {
  const ScreenPageSetup({
    Key? key,
    this.children = const <Widget>[],
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.padding = kPagePadding,
  }) : super(key: key);

  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: padding,
                child: Column(
                  crossAxisAlignment: crossAxisAlignment,
                  children: children,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
