import 'package:flutter/material.dart';
import 'package:market_curly_clone/colors/color.dart';
import 'package:market_curly_clone/screen/category/drop_down.dart';

class CategoryListWidget extends StatefulWidget {
  final icon;
  final title;
  final subCategory;
  const CategoryListWidget(
      {required this.icon,
      required this.title,
      required this.subCategory,
      Key? key})
      : super(key: key);

  @override
  State<CategoryListWidget> createState() => _CategoryListWidget();
}

// ignore: camel_case_types
class _CategoryListWidget extends State<CategoryListWidget> {
  bool isSelect = false;

  @override
  Widget build(BuildContext context) {
    Color color = isSelect ? originalColor : blackColor;
    Image iconImage = Image.asset('assets/images/category_fruit.png',
        width: MediaQuery.of(context).size.width * 0.06,
        height: MediaQuery.of(context).size.height * 0.04,
        color: color);
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelect = !isSelect;
        });
      },
      child: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: greyTone, width: 1))),
          child: Column(children: [
            SizedBox(
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      iconImage,
                      const SizedBox(
                        width: 10.0,
                      ),
                      isSelect
                          ? Text(
                              widget.title,
                              style: TextStyle(
                                color: originalColor,
                              ),
                            )
                          : Text(
                              widget.title,
                              style: TextStyle(color: blackColor),
                            )
                    ],
                  ),
                  isSelect
                      ? Icon(
                          Icons.keyboard_arrow_up_outlined,
                          color: greyTone,
                        )
                      : Icon(Icons.keyboard_arrow_down_outlined,
                          color: greyTone)
                ],
              ),
            ),
          ]),
        ),
        isSelect
            ? CategoryDropDownWidget(
                subCategory: widget.subCategory,
              )
            : const SizedBox()
      ]),
    );
  }
}
