import 'package:flutter/material.dart';
import 'package:market_curly_clone/colors/color.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double? size;
  const ElevatedButtonWidget(
      {required this.title, required this.onPressed, this.size, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    // ignore: non_constant_identifier_names
    final ButtonStyle ElevatedButtonStyle = ElevatedButton.styleFrom(
        primary: originalColor, textStyle: TextStyle(fontSize: width * 0.045));
    return SizedBox(
        width: size.runtimeType == double ? width * size! : width,
        height: height * 0.06,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(title),
          style: ElevatedButtonStyle,
        ));
  }
}

class OutLinedButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double? textSize;
  final double? widthSize;
  final double? heightSize;
  const OutLinedButtonWidget(
      {required this.title,
      required this.onPressed,
      this.widthSize,
      this.heightSize,
      this.textSize,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    // ignore: non_constant_identifier_names
    final ButtonStyle OutLinedButtonStyle = OutlinedButton.styleFrom(
        primary: originalColor,
        side: BorderSide(color: originalColor, width: 0.7),
        textStyle: TextStyle(
            fontSize: textSize.runtimeType == double
                ? width * textSize!
                : width * 0.045));

    return SizedBox(
      width: widthSize.runtimeType == double ? width * widthSize! : width,
      height: heightSize.runtimeType == double
          ? height * heightSize!
          : height * 0.06,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(title),
        style: OutLinedButtonStyle,
      ),
    );
    // );
  }
}
