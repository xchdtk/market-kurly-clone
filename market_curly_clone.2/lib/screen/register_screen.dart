import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_curly_clone/colors/color.dart';
import 'package:market_curly_clone/providers/registerCheck.dart';
import 'package:market_curly_clone/screen/button.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<RegisterCheck>(context, listen: false)
          .changeduplicateCheck(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        leadingWidth: width * 0.15,
        iconTheme: IconThemeData(color: blackColor),
        toolbarHeight: height * 0.06,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "회원가입",
          style: TextStyle(color: blackColor, fontSize: width * 0.04),
        ),
      ),
      body: ListView(
        children: [
          Container(
              margin: EdgeInsets.all(width * 0.02),
              child: const _InputUseridWidget()),
        ],
      ),
    );
  }
}

class _InputUseridWidget extends StatefulWidget {
  const _InputUseridWidget({Key? key}) : super(key: key);

  @override
  State<_InputUseridWidget> createState() => __InputUseridWidgetState();
}

class __InputUseridWidgetState extends State<_InputUseridWidget> {
  TextEditingController userIdController = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool hasFocus = false;

  final List<Text> userIdCheckTextList = [
    Text(
      ". 6자 이상의 영문 혹은 영문과 숫자를 조합",
      style: TextStyle(color: blackColor),
    ),
    Text(
      "O 6자 이상의 영문 혹은 영문과 숫자를 조합",
      style: TextStyle(color: greenColor),
    ),
    Text(
      "X 6자 이상의 영문 혹은 영문과 숫자를 조합",
      style: TextStyle(color: redColor),
    )
  ];

  final List<Text> duplicateCheckTextList = [
    Text(
      ". 아이디 중복확인",
      style: TextStyle(color: blackColor),
    ),
    Text(
      "O 아이디 중복확인",
      style: TextStyle(color: greenColor),
    ),
    Text(
      "X 아이디 중복확인",
      style: TextStyle(color: redColor),
    ),
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
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.01, vertical: width * 0.025),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: width * 0.02, left: width * 0.02),
            child: const Text(
              "아이디",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: width * 0.65,
                  child: TextFormField(
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          if (Provider.of<RegisterCheck>(context, listen: false)
                                  .duplicateCheck ==
                              1) {
                            Provider.of<RegisterCheck>(context, listen: false)
                                .changeduplicateCheck(-1);
                          }

                          setState(() {});
                        }
                      },
                      focusNode: focusNode,
                      controller: userIdController,
                      autofocus: false,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).nextFocus(),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        border: const OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(width * 0.03),
                        hintText: "예 : marketkurly12",
                      ))),
              OutLinedButtonWidget(
                title: "중복확인",
                onPressed: () {
                  String title = '';
                  if (userIdController.text == "xchdtk" &&
                      userIdController.text.length > 5) {
                    title = "사용할 수 있음";
                  } else {
                    title = "사용할 수 없음";
                    Provider.of<RegisterCheck>(context, listen: false)
                        .changeduplicateCheck(-1);
                  }
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(title),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text("확인"),
                              onPressed: () {
                                if (title == "사용할 수 있음") {
                                  Provider.of<RegisterCheck>(context,
                                          listen: false)
                                      .changeduplicateCheck(1);
                                }
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                },
                textSize: 0.04,
                widthSize: 0.23,
                heightSize: 0.06,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.03),
              width: width,
              child: (() {
                if (focusNode.hasFocus) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: (() {
                          if (userIdController.text.length > 5) {
                            return userIdCheckTextList[1];
                          } else if (userIdController.text.length < 6 &&
                              userIdController.text.isNotEmpty) {
                            return userIdCheckTextList[2];
                          }
                          return userIdCheckTextList[0];
                        }()),
                      ),
                      Container(
                        child: (() {
                          if (Provider.of<RegisterCheck>(context)
                                  .duplicateCheck ==
                              1) {
                            return duplicateCheckTextList[1];
                          } else if (Provider.of<RegisterCheck>(context)
                                  .duplicateCheck ==
                              -1) {
                            return duplicateCheckTextList[2];
                          }
                          return duplicateCheckTextList[0];
                        }()),
                      )
                    ],
                  );
                }
              }())),
        ],
      ),
    );
  }
}
