import 'package:demo_assignment/components/atom/typography3.dart';
import 'package:flutter/material.dart';

class Functions {
  static double responsiveDeviceWidth({
    required BuildContext context,
    required double percent,
  }) {
    var total = MediaQuery.sizeOf(context).width;
    return (percent / 100) * total;
  }

  static double responsiveHeight({
    required BuildContext context,
    required double percent,
    double appBarHeight = 0,
  }) {
    var total = MediaQuery.sizeOf(context).height - appBarHeight;

    return (percent / 100) * total;
  }

  static DateTime formatIsoDate(String date) {
    return DateTime.parse(date);
  }

  static showSnackbar(BuildContext context, String data) {
    final snackBar = SnackBar(
      content: Typography3(
        data: data,
        textColor: Colors.red,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
