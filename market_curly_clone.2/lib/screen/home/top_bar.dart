import 'package:flutter/material.dart';

import '../../colors/color.dart';

class TopBar extends StatefulWidget {
  final String menu;
  final VoidCallback onTap;
  final bool isActive;

  const TopBar(
      {required this.menu,
      required this.onTap,
      required this.isActive,
      Key? key})
      : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.all(width * 0.033),
        child: Text(widget.menu,
            style: TextStyle(
                fontSize: width * 0.028,
                color: widget.isActive ? originalColor : greyColor)),
        decoration: widget.isActive
            ? BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 3, color: originalColor)))
            : null,
      ),
    );
  }
}
