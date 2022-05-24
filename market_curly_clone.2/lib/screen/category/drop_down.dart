import 'package:flutter/material.dart';

import '../../colors/color.dart';

// ignore: camel_case_types
class CategoryDropDownWidget extends StatelessWidget {
  final List<dynamic> subCategory;
  const CategoryDropDownWidget({required this.subCategory, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: greyTone,
      child: Container(
        padding: const EdgeInsets.only(left: 55.0),
        child: ListView(
            shrinkWrap: true,
            children: subCategory.map((element) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(element),
              );
            }).toList()),
      ),
    );
  }
}
