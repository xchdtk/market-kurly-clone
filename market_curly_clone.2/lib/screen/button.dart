import 'package:flutter/material.dart';
import 'package:market_curly_clone/colors/color.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const ElevatedButtonWidget(
      {required this.title, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    // ignore: non_constant_identifier_names
    final ButtonStyle ElevatedButtonStyle = ElevatedButton.styleFrom(
        primary: originalColor, textStyle: TextStyle(fontSize: width * 0.03));
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(height: height * 0.07),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(title),
          style: ElevatedButtonStyle,
        ),
      ),
    );
  }
}

class OutLinedButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const OutLinedButtonWidget(
      {required this.title, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // ignore: non_constant_identifier_names
    final ButtonStyle OutLinedButtonStyle = OutlinedButton.styleFrom(
        primary: originalColor,
        side: BorderSide(color: originalColor, width: 1),
        textStyle: TextStyle(fontSize: width * 0.03));
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(height: height * 0.07),
        child: OutlinedButton(
          onPressed: onPressed,
          child: Text(title),
          style: OutLinedButtonStyle,
        ),
      ),
    );
  }
}
