import 'package:flutter/material.dart';

class MediaQueryExtension {
  double designScreenHeight;
  double designScreenwidth;
  BuildContext context;
  double compnentHeightInFigma;
  double componentwidthInFigma;
  MediaQueryExtension({
    required this.designScreenHeight,
    required this.designScreenwidth,
    required this.context,
    required this.compnentHeightInFigma,
    required this.componentwidthInFigma,
  });

  double calcHeight(double compnentHeightInFigma) {
    double realScreenHeight = MediaQuery.of(context).size.height;
    return (compnentHeightInFigma / designScreenHeight) * realScreenHeight;
  }

  double calcWidth(double componentwidthInFigma) {
    double realWidth = MediaQuery.of(context).size.width;
    return (componentwidthInFigma / designScreenwidth) * realWidth;
  }
}
