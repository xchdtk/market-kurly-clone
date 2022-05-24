import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_curly_clone/colors/color.dart';
import 'package:market_curly_clone/screen/button.dart';
import 'package:market_curly_clone/screen/show_dialog.dart';
import 'package:provider/provider.dart';
import '../../providers/register_check.dart';

class InputUseridWidget extends StatefulWidget {
  const InputUseridWidget({Key? key}) : super(key: key);

  @override
  State<InputUseridWidget> createState() => _InputUseridWidgetState();
}

class _InputUseridWidgetState extends State<InputUseridWidget> {
  TextEditingController userIdController = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool hasFocus = false;

  final String userIdCheckText = "6자 이상의 영문 혹은 영문과 숫자를 조합";

  final String duplicateCheckText = "아이디 중복확인";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      userIdController.text =
          Provider.of<RegisterCheck>(context, listen: false).currentUserId;
    });

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
    void onPressed() {
      bool state = false;
      if (userIdController.text == "xchdtk" &&
          userIdController.text.length > 5) {
        state = true;
      } else {
        state = false;
        Provider.of<RegisterCheck>(context, listen: false)
            .changeDuplicateUserIdCheck(-1);
      }
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(state ? "사용할 수 있음" : "사용할 수 없음"),
              actions: [
                CupertinoDialogAction(
                  child: const Text("확인"),
                  onPressed: () {
                    if (state) {
                      Provider.of<RegisterCheck>(context, listen: false)
                          .changeDuplicateUserIdCheck(1);
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
      focusNode.unfocus();
    }

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.all(width * 0.03),
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
                                  .duplicateUserIdCheck ==
                              1) {
                            Provider.of<RegisterCheck>(context, listen: false)
                                .changeDuplicateUserIdCheck(-1);
                          }
                          if (userIdController.text.length > 5) {
                            Provider.of<RegisterCheck>(context, listen: false)
                                .changeCombinationUserIdCheck(1);
                          } else if (userIdController.text.length < 6 &&
                              userIdController.text.isNotEmpty) {
                            Provider.of<RegisterCheck>(context, listen: false)
                                .changeCombinationUserIdCheck(-1);
                          }
                          Provider.of<RegisterCheck>(context, listen: false)
                              .setCurrentUserId(value);
                          setState(() {});
                        }
                      },
                      focusNode: focusNode,
                      controller: userIdController,
                      autofocus: false,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.go,
                      onFieldSubmitted: (_) => onPressed(),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: blackColor)),
                        border: const OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(width * 0.03),
                        hintText: "예 : marketkurly12",
                      ))),
              OutLinedButtonWidget(
                title: "중복확인",
                onPressed: onPressed,
                textSize: 0.04,
                widthSize: 0.23,
                heightSize: 0.06,
              )
            ],
          ),
          SizedBox(
            height: height * 0.02,
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
                        if (Provider.of<RegisterCheck>(context)
                                .combinationUserIdCheck ==
                            1) {
                          return Text(
                            "O $userIdCheckText",
                            style: TextStyle(color: greenColor),
                          );
                        } else if (Provider.of<RegisterCheck>(context)
                                .combinationUserIdCheck ==
                            -1) {
                          return Text(
                            "X $userIdCheckText",
                            style: TextStyle(color: redColor),
                          );
                        } else if (hasFocus) {
                          return Text(
                            ". $userIdCheckText",
                            style: TextStyle(color: blackColor),
                          );
                        }
                      }()),
                    ),
                    Container(
                      child: (() {
                        if (Provider.of<RegisterCheck>(context)
                                .duplicateUserIdCheck ==
                            1) {
                          return Text(
                            "O $duplicateCheckText",
                            style: TextStyle(color: greenColor),
                          );
                        } else if (Provider.of<RegisterCheck>(context)
                                .duplicateUserIdCheck ==
                            -1) {
                          return Text(
                            "X $duplicateCheckText",
                            style: TextStyle(color: redColor),
                          );
                        } else if (hasFocus &&
                            Provider.of<RegisterCheck>(context)
                                    .duplicateUserIdCheck ==
                                0) {
                          return Text(
                            ". $duplicateCheckText",
                            style: TextStyle(color: blackColor),
                          );
                        }
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
