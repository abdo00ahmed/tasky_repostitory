import 'package:flutter/material.dart';

extension MediaQueryExtension on BuildContext {
  static const double designScreenHeight = 844;
  static const double designScreenwidth = 390;

  double get realScreenHeight => MediaQuery.of(this).size.height;

  double get realWidth => MediaQuery.of(this).size.width;
  double calcHeight(double compnentHeightInFigma) {
    return (compnentHeightInFigma / designScreenHeight) * realScreenHeight;
  }

  double calcWidth(double componentwidthInFigma) {
    return (componentwidthInFigma / designScreenwidth) * realWidth;
  }

  double calcFonts(double fontSize) {
    return calcHeight(fontSize);
  }
}
