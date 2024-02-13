import 'package:flutter/material.dart';

class Typography3 extends StatelessWidget {
  const Typography3(
      {super.key,
      required this.data,
      this.textColor = Colors.white,
      this.underLine = false,
      this.textAlign});

  final String data;
  final Color textColor;
  final bool underLine;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontSize: 14,
        color: textColor,
        decoration: underLine ? TextDecoration.underline : TextDecoration.none,
      ),
      textAlign: textAlign ?? TextAlign.center,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
    );
  }
}
