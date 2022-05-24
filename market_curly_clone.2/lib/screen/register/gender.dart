import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:market_curly_clone/colors/color.dart';

enum SingingCharacter { man, woman, uncheck }

SingingCharacter? character;

class GenderWidget extends StatefulWidget {
  const GenderWidget({Key? key}) : super(key: key);

  @override
  State<GenderWidget> createState() => _GenderWidgetState();
}

class _GenderWidgetState extends State<GenderWidget> {
  SingingCharacter? _character;

  final controller = GroupButtonController();

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
              "성별",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            children: [
              ListTile(
                title: Text(
                  "남자",
                  style: TextStyle(fontSize: width * 0.04),
                ),
                horizontalTitleGap: 0,
                contentPadding: const EdgeInsets.only(
                    left: 0.0, right: 0.0, top: 0, bottom: 0),
                leading: Transform.scale(
                  scale: 1.3,
                  child: Radio(
                    activeColor: originalColor,
                    value: SingingCharacter.man,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "여자",
                  style: TextStyle(fontSize: width * 0.04),
                ),
                contentPadding:
                    const EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),
                horizontalTitleGap: 0,
                leading: Transform.scale(
                  scale: 1.3,
                  child: Radio<SingingCharacter>(
                    value: SingingCharacter.woman,
                    activeColor: originalColor,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "선택안함",
                  style: TextStyle(fontSize: width * 0.04),
                ),
                contentPadding: const EdgeInsets.only(
                    left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
                horizontalTitleGap: 0,
                leading: Transform.scale(
                  scale: 1.3,
                  child: Radio<SingingCharacter>(
                    value: SingingCharacter.uncheck,
                    activeColor: originalColor,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
