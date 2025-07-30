import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class R {
  static double sh(double height, BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (kIsWeb) {
      return size.height * (height / 900);
    } else {
      return size.height * (height / 812);
    }
  }

  static double sw(double width, BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (kIsWeb) {
      return size.width * (width / 1440);
    } else {
      return size.width * (width / 375);
    }
  }
}
