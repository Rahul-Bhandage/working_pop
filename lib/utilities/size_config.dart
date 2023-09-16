import 'package:flutter/material.dart';

class SizeConfig {

  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;

  void init(BuildContext context) {

    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// Get the proportionate height as per screen size
double getProportionateHeight(double inputHeight) {

  double screenHeight = SizeConfig.screenHeight;
  // 784 is the layout height that designer use
  return (inputHeight / 844.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 360 is the layout width that designer use
  return (inputWidth / 390.0) * screenWidth;
}
