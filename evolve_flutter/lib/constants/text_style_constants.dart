import 'package:flutter/material.dart';

enum TextStyleWeight { light, normal, medium, bold, heavy }

extension TextStyleWeightExtension on TextStyleWeight {
  FontWeight get fontWeight {
    switch (this) {
      case TextStyleWeight.light:
        return FontWeight.w200;
      case TextStyleWeight.normal:
        return FontWeight.w400;
      case TextStyleWeight.medium:
        return FontWeight.w700;
      case TextStyleWeight.bold:
        return FontWeight.w800;
      case TextStyleWeight.heavy:
        return FontWeight.w900;
    }
  }
}

class TextStyleConstant {
  static h2(BuildContext context, Color color, TextStyleWeight weight) {
    return TextStyle(
        fontSize: MediaQuery.of(context).size.height * 0.03,
        color: color,
        fontWeight: weight.fontWeight);
  }

  static h3(BuildContext context, Color color, TextStyleWeight weight) {
    return TextStyle(
        fontSize: MediaQuery.of(context).size.height * 0.024,
        color: color,
        fontWeight: weight.fontWeight);
  }

  static h4(BuildContext context, Color color, TextStyleWeight weight) {
    return TextStyle(
        fontSize: MediaQuery.of(context).size.height * 0.020,
        color: color,
        fontWeight: weight.fontWeight);
  }

  static body(BuildContext context, Color color, TextStyleWeight weight) {
    return TextStyle(
        fontSize: MediaQuery.of(context).size.height * 0.018,
        color: color,
        fontWeight: weight.fontWeight);
  }

  static small(BuildContext context, Color color, TextStyleWeight weight) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.height * 0.0165,
      color: color,
      fontWeight: weight.fontWeight,
    );
  }

  static desc(BuildContext context, Color color, TextStyleWeight weight) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.height * 0.015,
      color: color,
      fontWeight: weight.fontWeight,
    );
  }
}
