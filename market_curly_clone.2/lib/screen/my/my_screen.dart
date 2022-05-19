import '../../providers/login.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:market_curly_clone/screen/login.dart';
import 'package:market_curly_clone/screen/button.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Provider.of<LoginState>(context).isLogined
              ? const logOutWidget()
              : const LoginResigerWidget(),
          Container(
            color: const Color(0xffe5dede),
            height: MediaQuery.of(context).size.height * 0.01,
          ),
        ],
      ),
    );
  }
}

class LoginResigerWidget extends StatelessWidget {
  const LoginResigerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.3,
      padding: EdgeInsets.all(width * 0.04),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("회원가입 하고", style: TextStyle(fontSize: width * 0.035)),
          Text("다양한 혜택을 받아보세요!", style: TextStyle(fontSize: width * 0.035)),
          SizedBox(
            height: width * 0.12,
          ),
          ElevatedButtonWidget(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const LoginScreen()));
            },
            title: "로그인/회원가입",
          )
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class logOutWidget extends StatelessWidget {
  const logOutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutLinedButtonWidget(
      onPressed: () {
        Hive.box('LocalMarketKulry').put('userId', "");
        Hive.box('LocalMarketKulry').put('accessToken', "");
        Provider.of<LoginState>(context, listen: false).changeLoginState();
      },
      title: "로그아웃",
    );
  }
}
