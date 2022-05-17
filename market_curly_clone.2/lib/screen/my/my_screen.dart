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
            height: 6,
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
    return Container(
      height: 200,
      padding: const EdgeInsets.all(18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("회원가입 하고", style: TextStyle(fontSize: 18)),
          const Text("다양한 혜택을 받아보세요!", style: TextStyle(fontSize: 18)),
          const SizedBox(
            height: 50,
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
