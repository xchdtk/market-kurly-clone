import 'package:flutter/material.dart';
import 'package:market_curly_clone/colors/color.dart';
import 'package:market_curly_clone/providers/register_check.dart';
import 'package:provider/provider.dart';

class ConsentWidget extends StatefulWidget {
  const ConsentWidget({Key? key}) : super(key: key);

  @override
  State<ConsentWidget> createState() => _ConsentWidgetState();
}

class _ConsentWidgetState extends State<ConsentWidget> {
  bool isState = false;

  void checkFullConsent(context) {
    if (Provider.of<ConsentToUseCheck>(context, listen: false)
            .requiredTermsOfServiceState &&
        Provider.of<ConsentToUseCheck>(context, listen: false)
            .requiredPrivacyConsent &&
        Provider.of<ConsentToUseCheck>(context, listen: false)
            .selectPrivacyConsent &&
        Provider.of<ConsentToUseCheck>(context, listen: false)
            .selectBenefitInformationConsent &&
        Provider.of<ConsentToUseCheck>(context, listen: false)
            .requiredAgeLimit) {
      isState = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      // margin: EdgeInsets.symmetric(
      //     vertical: height * 0.03, horizontal: width * 0.03),
      margin: EdgeInsets.only(
          left: width * 0.03, right: width * 0.03, top: height * 0.03),
      height: height * 0.52,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: width * 0.02, left: width * 0.025),
            child: const Text(
              "이용약관동의",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ConsentCheckBoxWidget(
              title: Text(
                "전체 동의합니다.",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: width * 0.04),
              ),
              value: isState,
              onChanged: (value) {
                setState(() {
                  if (value!) {
                    Provider.of<ConsentToUseCheck>(context, listen: false)
                        .acceptFullConsent();
                  } else if (!value) {
                    Provider.of<ConsentToUseCheck>(context, listen: false)
                        .rejectionFullConsent();
                  }
                  isState = value;
                });
              }),
          Container(
            margin: EdgeInsets.only(bottom: width * 0.02, left: width * 0.025),
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(bottom: height * 0.02),
                    child: const Text(
                        "선택 항목에 동의하지 않은 경우도 회원가입 및 일반적인 서비스를 이용할 수 있습니다.")),
                Container(
                  color: greyTone,
                  height: height * 0.001,
                ),
              ],
            ),
          ),
          ConsentCheckBoxWidget(
            title: Text("이용약관 동의 (필수)"),
            value: Provider.of<ConsentToUseCheck>(context)
                .requiredTermsOfServiceState,
            onChanged: (value) {
              setState(() {
                Provider.of<ConsentToUseCheck>(context, listen: false)
                    .changeRequiredTermsOfServiceState();
                if (value) {
                  checkFullConsent(context);
                } else if (!value!) {
                  isState = false;
                }
              });
            },
          ),
          ConsentCheckBoxWidget(
            title: Text("개인정보 수정, 이용 동의 (필수)"),
            value:
                Provider.of<ConsentToUseCheck>(context).requiredPrivacyConsent,
            onChanged: (value) {
              setState(() {
                Provider.of<ConsentToUseCheck>(context, listen: false)
                    .changeRequiredPrivacyConsent();
                if (value) {
                  checkFullConsent(context);
                } else if (!value!) {
                  isState = false;
                }
              });
            },
          ),
          ConsentCheckBoxWidget(
            title: Text("개인정보 수집, 이용 동의 (선택)"),
            value: Provider.of<ConsentToUseCheck>(context).selectPrivacyConsent,
            onChanged: (value) {
              setState(() {
                Provider.of<ConsentToUseCheck>(context, listen: false)
                    .changeSelectPrivacyConsent();
                if (value) {
                  checkFullConsent(context);
                } else if (!value!) {
                  isState = false;
                }
              });
            },
          ),
          ConsentCheckBoxWidget(
            title: Text("무료배송, 할인쿠폰 등 혜택/정보 수신 동의 (선택)"),
            value: Provider.of<ConsentToUseCheck>(context)
                .selectBenefitInformationConsent,
            onChanged: (value) {
              setState(() {
                Provider.of<ConsentToUseCheck>(context, listen: false)
                    .changeSelectBenefitInformationConsent();
                if (value) {
                  checkFullConsent(context);
                } else if (!value!) {
                  isState = false;
                }
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ConsentCheckBoxWidget(
                title: Text("SMS"),
                value: Provider.of<ConsentToUseCheck>(context)
                    .selectBenefitInformationConsent,
                onChanged: (value) {
                  setState(() {
                    Provider.of<ConsentToUseCheck>(context, listen: false)
                        .changeSelectBenefitInformationConsent();
                    if (value) {
                      checkFullConsent(context);
                    } else if (!value!) {
                      isState = false;
                    }
                  });
                },
              ),
              ConsentCheckBoxWidget(
                title: Text("이메일"),
                value: Provider.of<ConsentToUseCheck>(context)
                    .selectBenefitInformationConsent,
                onChanged: (value) {
                  setState(() {
                    Provider.of<ConsentToUseCheck>(context, listen: false)
                        .changeSelectBenefitInformationConsent();
                    if (value) {
                      checkFullConsent(context);
                    } else if (!value!) {
                      isState = false;
                    }
                  });
                },
              ),
            ],
          ),
          ConsentCheckBoxWidget(
            title: Text("본인은 만 14세 이상입니다. (필수)"),
            value: Provider.of<ConsentToUseCheck>(context).requiredAgeLimit,
            onChanged: (value) {
              setState(() {
                Provider.of<ConsentToUseCheck>(context, listen: false)
                    .changeSequiredAgeLimit();
                if (value) {
                  checkFullConsent(context);
                } else if (!value!) {
                  isState = false;
                }
              });
            },
          ),
        ],
      ),
    );
  }
}

class ConsentCheckBoxWidget extends StatelessWidget {
  final Text title;
  final bool value;
  // ignore: prefer_typing_uninitialized_variables
  final onChanged;

  const ConsentCheckBoxWidget(
      {required this.title,
      required this.onChanged,
      required this.value,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.3,
          child: Checkbox(
              value: value,
              shape: const CircleBorder(),
              side: BorderSide(color: greyTone, width: 0.8),
              checkColor: whiteColor,
              activeColor: originalColor,
              onChanged: onChanged),
        ),
        title
      ],
    );
  }
}
