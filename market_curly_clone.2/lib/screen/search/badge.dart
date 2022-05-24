import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:market_curly_clone/colors/color.dart';
import 'package:provider/provider.dart';

import '../../providers/search.dart';

class BadgeWidget extends StatefulWidget {
  final String title;
  final int index;
  const BadgeWidget({required this.title, required this.index, Key? key})
      : super(key: key);

  @override
  State<BadgeWidget> createState() => _BadgeWidgetState();
}

class _BadgeWidgetState extends State<BadgeWidget> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final deleteState = Provider.of<RecentSearchesState>(context).deleteState;
    return Container(
      margin: const EdgeInsets.all(5),
      child: Badge(
        toAnimate: false,
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.01),
        shape: BadgeShape.square,
        borderRadius: BorderRadius.circular(30),
        badgeColor: whiteColor,
        badgeContent: GestureDetector(
          onTap: () async {
            if (deleteState) {
              await Provider.of<RecentSearchesCheck>(context, listen: false)
                  .updateSearchWords(widget.index);
            } else {
              // 추후 상세페이지 기능 구현 시 추가
              print("상세페이지 이동");
            }
          },
          child: SizedBox(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(color: blackColor),
                  ),
                  deleteState
                      ? Icon(
                          Icons.remove,
                          size: width * 0.04,
                        )
                      : const SizedBox()
                ]),
          ),
        ),
      ),
    );
  }
}
