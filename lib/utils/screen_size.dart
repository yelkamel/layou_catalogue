import 'package:flutter/material.dart';

class Screen {
  Size screenSize;

  Screen(this.screenSize);

  double wp(int percentage) {
    return percentage / 100 * screenSize.width;
  }

  double hp(int percentage) {
    return percentage / 100 * screenSize.height;
  }
}

class XMargin extends StatelessWidget {
  final double x;
  const XMargin(this.x);
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: x);
  }
}

class YMargin extends StatelessWidget {
  final double y;
  const YMargin(this.y);
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: y);
  }
}

double screenHeight(BuildContext context, {double percent = 1}) =>
    MediaQuery.of(context).size.height * percent;

double screenWidth(BuildContext context, {double percent = 1}) =>
    MediaQuery.of(context).size.width * percent;
