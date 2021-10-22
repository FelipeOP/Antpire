import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFEF5350);
const kBackgroundColor = Color(0xFFFFFFFF);
const kErrorColor = Color(0xFFFE5350);

class Config {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static Orientation? orientation;
  static bool? isKeyboardOn;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    orientation = _mediaQueryData!.orientation;
    isKeyboardOn = _mediaQueryData!.viewInsets.bottom != 0;
  }
}
