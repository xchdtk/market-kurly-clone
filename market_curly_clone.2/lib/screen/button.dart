import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const ElevatedButtonWidget(
      {required this.title, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final ButtonStyle ElevatedButtonStyle = ElevatedButton.styleFrom(
        primary: const Color(0xff5f0080),
        textStyle: const TextStyle(fontSize: 15));
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ConstrainedBox(
        constraints: const BoxConstraints.tightFor(height: 40),
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
    // ignore: non_constant_identifier_names
    final ButtonStyle OutLinedButtonStyle = OutlinedButton.styleFrom(
        primary: Color(0xff5f0080),
        side: const BorderSide(color: Color(0xff5f0080), width: 1),
        textStyle: const TextStyle(fontSize: 15));
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ConstrainedBox(
        constraints: const BoxConstraints.tightFor(height: 40),
        child: OutlinedButton(
          onPressed: onPressed,
          child: Text(title),
          style: OutLinedButtonStyle,
        ),
      ),
    );
  }
}
