import 'dart:async';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:market_curly_clone/colors/color.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:market_curly_clone/providers/login.dart';
import 'package:market_curly_clone/screen/navbar_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final String imageLogoUrl =
      "https://cdn.pixabay.com/photo/2016/11/28/21/20/happiness-1866081__340.jpg";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final data = Hive.box('LocalMarketKulry').get('accessToken');
      if (data != '') {
        Provider.of<LoginState>(context, listen: false).changeLoginState();
      }

      Timer(const Duration(milliseconds: 5000), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const NavBarScreen()),
            (route) => false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: originalColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: width * 0.384375,
            ),
            const Expanded(child: SizedBox()),
            Align(
              child: Text("© Copyright 2022, 마켓컬리",
                  style: TextStyle(
                    fontSize: width * (14 / 360),
                    color: const Color.fromRGBO(255, 255, 255, 0.6),
                  )),
            ),
            SizedBox(
              height: height * 0.0625,
            ),
          ],
        ),
      ),
    );
  }
}
