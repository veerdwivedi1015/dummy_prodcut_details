import 'package:flutter/material.dart';

class Typography1 extends StatelessWidget {
  const Typography1({
    super.key,
    required this.data,
    this.textColor = Colors.white,
    this.underLine = false,
  });

  final String data;
  final Color textColor;
  final bool underLine;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontSize: 24,
        color: textColor,
        decoration: underLine ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }
}
