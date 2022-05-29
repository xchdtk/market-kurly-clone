import 'package:flutter/material.dart';
import 'package:market_curly_clone/colors/color.dart';
import 'package:provider/provider.dart';

import '../../providers/register_check.dart';

class InputPasswordWidget extends StatefulWidget {
  const InputPasswordWidget({Key? key}) : super(key: key);

  @override
  State<InputPasswordWidget> createState() => _InputPasswordWidgetState();
}

class _InputPasswordWidgetState extends State<InputPasswordWidget> {
  TextEditingController passwordController = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool hasFocus = false;

  final List<String> passwordCheckTextList = [
    "10자 이상 입력",
    "영문/숫자/특수문자(공백 제외)만 허용하면, 2개 이상 조합",
    "동일한 숫자 3개 이상 연속 사용 불가"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          hasFocus = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(width * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: width * 0.02, left: width * 0.02),
            child: const Text(
              "비밀번호",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              margin:
                  EdgeInsets.only(left: width * 0.015, right: width * 0.015),
              width: width,
              child: TextFormField(
                  onChanged: (value) {
                    if (passwordController.text.isNotEmpty) {
                      Provider.of<RegisterCheck>(context, listen: false)
                          .setCurrentPassword(passwordController.text);
                      setState(() {});
                    }
                  },
                  focusNode: focusNode,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: passwordController,
                  autofocus: false,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.go,
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: blackColor)),
                    border: const OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(width * 0.03),
                    hintText: "비밀번호를 입력해주세요.",
                  ))),
          const SizedBox(
            height: 10,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.03),
              width: width,
              child: (() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: (() {
                        if (passwordController.text.length >= 10) {
                          Provider.of<RegisterCheck>(context, listen: false)
                              .changePasswordLengthCheck(true);
                          return Text(
                            "O ${passwordCheckTextList[0]}",
                            style: TextStyle(color: greenColor),
                          );
                        } else if (passwordController.text.isNotEmpty &&
                            passwordController.text.length < 10) {
                          Provider.of<RegisterCheck>(context, listen: false)
                              .changePasswordLengthCheck(false);
                          return Text(
                            "X ${passwordCheckTextList[0]}",
                            style: TextStyle(color: redColor),
                          );
                        } else if (hasFocus) {
                          return Text(". ${passwordCheckTextList[0]}");
                        }
                      }()),
                    ),
                    Container(
                      child: (() {
                        return Text(
                          "O ${passwordCheckTextList[1]}",
                          style: TextStyle(color: greenColor),
                        );
                      }()),
                    ),
                    Container(
                      child: (() {
                        return Text(
                          "O ${passwordCheckTextList[2]}",
                          style: TextStyle(color: greenColor),
                        );
                      }()),
                    )
                  ],
                );
              }())),
        ],
      ),
    );
  }
}

class InputPasswordCheckWidget extends StatefulWidget {
  const InputPasswordCheckWidget({Key? key}) : super(key: key);

  @override
  _InputPasswordCheckWidgetState createState() =>
      _InputPasswordCheckWidgetState();
}

class _InputPasswordCheckWidgetState extends State<InputPasswordCheckWidget> {
  TextEditingController passwordController = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool hasFocus = false;
  Text passwordCheckText = Text(
    ". 동일한 비밀번호를 입력해주세요",
    style: TextStyle(color: blackColor),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          hasFocus = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(width * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: width * 0.02, left: width * 0.02),
            child: const Text(
              "비밀번호 확인",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              margin:
                  EdgeInsets.only(left: width * 0.015, right: width * 0.015),
              width: width,
              child: TextFormField(
                  onChanged: (value) {
                    if (passwordController.text.isNotEmpty) {
                      setState(() {});
                    }
                  },
                  focusNode: focusNode,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: passwordController,
                  autofocus: false,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: blackColor)),
                    border: const OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(width * 0.03),
                    hintText: "비밀번호를 한번 더 입력해주세요.",
                  ))),
          const SizedBox(
            height: 10,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.03),
              width: width,
              child: (() {
                return Container(
                  child: (() {
                    if (passwordController.text !=
                        Provider.of<RegisterCheck>(context).currentPassword) {
                      Provider.of<RegisterCheck>(context)
                          .changeConfirmPasswordCheck(-1);
                      return Text("x 동일한 비밀번호를 입력해주세요",
                          style: TextStyle(color: redColor));
                    } else if (Provider.of<RegisterCheck>(context)
                            .currentPassword
                            .isNotEmpty &&
                        passwordController.text ==
                            Provider.of<RegisterCheck>(context)
                                .currentPassword) {
                      Provider.of<RegisterCheck>(context)
                          .changeConfirmPasswordCheck(1);
                      return Text("O 동일한 비밀번호를 입력해주세요",
                          style: TextStyle(color: greenColor));
                    } else if (hasFocus) {
                      return Text(". 동일한 비밀번호를 입력해주세요",
                          style: TextStyle(color: blackColor));
                    }
                  }()),
                );
              }())),
        ],
      ),
    );
  }
}
