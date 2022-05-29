import 'package:flutter/material.dart';
import 'package:market_curly_clone/colors/color.dart';
import 'package:market_curly_clone/providers/register_check.dart';
import 'package:market_curly_clone/screen/button.dart';
import 'package:market_curly_clone/screen/register/conset.dart';
import 'package:market_curly_clone/screen/register/gender.dart';
import 'package:market_curly_clone/screen/register/password.dart';
import 'package:market_curly_clone/screen/show_dialog.dart';
import 'package:market_curly_clone/screen/register/user_id.dart';
import 'package:provider/provider.dart';

// ignore: prefer_function_declarations_over_variable

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<RegisterCheck>(context, listen: false).setCurrentUserId("");
      Provider.of<RegisterCheck>(context, listen: false)
          .changeCombinationUserIdCheck(0);
      Provider.of<RegisterCheck>(context, listen: false)
          .changeDuplicateUserIdCheck(0);

      Provider.of<RegisterCheck>(context, listen: false).setCurrentPassword("");
      Provider.of<RegisterCheck>(context, listen: false)
          .changePasswordLengthCheck(false);
      Provider.of<RegisterCheck>(context, listen: false)
          .changePasswordCombinationCheck(true);
      Provider.of<RegisterCheck>(context, listen: false)
          .changePasswordSameNumberCheck(true);
      Provider.of<RegisterCheck>(context, listen: false)
          .changeConfirmPasswordCheck(0);
    });

    controller.addListener(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider(
      create: (_) => ConsentToUseCheck(),
      child: Scaffold(
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
        body: Scrollbar(
          controller: controller,
          child: ListView(controller: controller, children: [
            const InputUseridWidget(),
            const InputPasswordWidget(),
            const InputPasswordCheckWidget(),
            const GenderWidget(),
            Container(
              height: height * 0.013,
              color: greyTone,
            ),
            const ConsentWidget(),
            Container(
                margin: EdgeInsets.all(width * 0.04),
                child: ElevatedButtonWidget(
                    title: "가입하기", onPressed: elevatedButtonOnPressed))
          ]),
        ),
      ),
    );
  }

  void elevatedButtonOnPressed() {
    if (Provider.of<RegisterCheck>(context, listen: false)
            .duplicateUserIdCheck !=
        1) {
      showDialogAlertMoveScroll(context, controller, "아이디 중복검사을 확인해 주세요.",
          () => dialogOnPressed(0.0));
    } else if (!Provider.of<RegisterCheck>(context, listen: false)
            .passwordLengthCheck ||
        !Provider.of<RegisterCheck>(context, listen: false)
            .passwordCombinationCheck ||
        !Provider.of<RegisterCheck>(context, listen: false)
            .passwordSameNumberCheck) {
      showDialogAlertMoveScroll(
          context, controller, "비밀번호를 입력해주세요", () => dialogOnPressed(0.0));
    } else if (Provider.of<RegisterCheck>(context, listen: false)
            .confirmPasswordCheck ==
        -1) {
      showDialogAlertMoveScroll(context, controller, "비밀번호 확인을 제대로 입력해주세요.",
          () => dialogOnPressed(0.0));
    }
  }

  void dialogOnPressed(offset) {
    Navigator.of(context).pop();
    controller.animateTo(offset,
        duration: const Duration(microseconds: 500), curve: Curves.easeIn);
  }
}
