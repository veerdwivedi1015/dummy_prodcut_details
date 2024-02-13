import 'package:demo_assignment/components/atom/typography2.dart';
import 'package:demo_assignment/utils/functions.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.buttonTitle,
    required this.callback,
    this.textColor = Colors.white,
    this.isBusy = false,
  });

  final String buttonTitle;
  final VoidCallback callback;
  final Color textColor;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => callback.call(),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            return Colors.black;
          },
        ),
      ),
      child: SizedBox(
        width: Functions.responsiveDeviceWidth(context: context, percent: 100),
        child: isBusy
            ? const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  strokeWidth: 1,
                ),
              )
            : TypoGraphy2(
                data: buttonTitle,
                textColor: textColor,
              ),
      ),
    );
  }
}
