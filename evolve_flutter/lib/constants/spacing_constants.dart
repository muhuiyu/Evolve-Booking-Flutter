import 'package:flutter/material.dart';

class SpacingConstant {
  static trival(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.007;
  }

  static small(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.01;
  }

  static medium(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.025;
  }

  static large(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.035;
  }
}
