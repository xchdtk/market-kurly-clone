import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
        width: width * 0.02,
        height: width * 0.02,
        child: const ScrollConfiguration(
          behavior: ScrollBehavior(),
          child: CircularProgressIndicator(
            backgroundColor: Colors.grey,
            strokeWidth: 2,
          ),
        ));
  }
}
