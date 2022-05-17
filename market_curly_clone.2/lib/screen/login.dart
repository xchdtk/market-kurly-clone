import 'button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:market_curly_clone/providers/login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  AppBar appBar() {
    return AppBar(
      title: const Text(
        "로그인",
        style: TextStyle(color: Colors.black),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.white,
      bottomOpacity: 0.0,
      elevation: 0.0,
      leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.clear,
            color: Colors.black,
          )),
    );
  }

  void showToast(title) {
    Fluttertoast.showToast(
        msg: title,
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 2,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red);
  }

  // ignore: non_constant_identifier_names
  void LoginPressed() {
    try {
      if (userIdController.text == "") {
        showToast("아이디를 입력해주세요.");
      } else if (passwordController.text == "") {
        showToast("비밀번호를 입력해주세요.");
      } else {
        postLogin(userIdController.text, passwordController.text).then((data) {
          if (data == 'fail login') {
            showToast("아이디, 비밀번호를 확인해주세요.");
          } else if (data == 'success login') {
            Provider.of<LoginState>(context, listen: false).changeLoginState();
            Navigator.of(context).pop();
          }
        });
      }
    } catch (error) {
      throw Exception('failed login');
    }
  }

  @override
  Widget build(BuildContext context) {
    var userIdTextFormField = TextFormField(
      onChanged: (text) {
        setState(() {});
      },
      controller: userIdController,
      autofocus: false,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      style: const TextStyle(height: 1),
      decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          border: const OutlineInputBorder(),
          hintText: "아이디를 입력해주세요",
          suffixIcon: userIdController.text != ''
              ? IconButton(
                  icon: const Icon(
                    Icons.highlight_remove,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      userIdController.clear();
                    });
                  })
              : null),
    );

    var passwordTextFormField = TextFormField(
      controller: passwordController,
      onChanged: (text) {
        setState(() {});
      },
      autofocus: false,
      obscureText: true,
      style: const TextStyle(height: 1),
      onFieldSubmitted: (_) => LoginPressed(),
      decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          border: const OutlineInputBorder(),
          hintText: "비밀번호를 입력해주세요",
          suffixIcon: passwordController.text != ''
              ? IconButton(
                  icon: const Icon(
                    Icons.highlight_remove,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      passwordController.clear();
                    });
                  })
              : null),
    );
    return GestureDetector(
      onTap: () {
        //FocusManager.instance.primaryFocus?.unfocus();
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: appBar(),
          body: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  userIdTextFormField,
                  const SizedBox(height: 10),
                  passwordTextFormField,
                  const SizedBox(height: 18),
                  ElevatedButtonWidget(
                    onPressed: LoginPressed,
                    title: "로그인",
                  ),
                  const SizedBox(height: 10),
                  const _FindLoginPasswordWidget(),
                  const SizedBox(height: 40),
                ],
              ))),
    );
  }
}

// ignore: unused_element
class _FindLoginPasswordWidget extends StatelessWidget {
  const _FindLoginPasswordWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          "아이디 찾기",
          style: TextStyle(fontSize: 12),
        ),
        SizedBox(
          width: 4,
        ),
        Text("|"),
        SizedBox(
          width: 4,
        ),
        Text(
          "비밀번호 찾기",
          style: TextStyle(fontSize: 12),
        )
      ],
    );
  }
}
