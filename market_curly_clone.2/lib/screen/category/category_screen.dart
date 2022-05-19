import "package:flutter/material.dart";
import 'package:market_curly_clone/providers/category.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final categoriesData = Provider.of<GetCategories>(context);
    return categoriesData.loading
        ? const SizedBox(
            width: 20,
            height: 20,
            child: ScrollConfiguration(
              behavior: ScrollBehavior(),
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
                strokeWidth: 2,
              ),
            ))
        : Scrollbar(
            showTrackOnHover: true,
            child: ListView(children: [
              ...categoriesData.categories
                  .map((element) => _categoryListWidget(
                        icon: element.icon,
                        title: element.title,
                        subCategory: element.subCategory,
                      ))
                  .toList()
            ]),
          );
  }
}

// ignore: camel_case_types
class _categoryListWidget extends StatefulWidget {
  final icon;
  final title;
  final subCategory;
  const _categoryListWidget(
      {required this.icon,
      required this.title,
      required this.subCategory,
      Key? key})
      : super(key: key);

  @override
  State<_categoryListWidget> createState() => __categoryListWidgetState();
}

// ignore: camel_case_types
class __categoryListWidgetState extends State<_categoryListWidget> {
  bool isSelect = false;

  @override
  Widget build(BuildContext context) {
    Color color = isSelect ? const Color(0xff5f0080) : Colors.black;
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
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Color(0xffE3DFDF), width: 1))),
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
                              style: const TextStyle(
                                color: Color(0xff5f0080),
                              ),
                            )
                          : Text(
                              widget.title,
                              style: const TextStyle(color: Colors.black),
                            )
                    ],
                  ),
                  isSelect
                      ? const Icon(
                          Icons.keyboard_arrow_up_outlined,
                          color: Colors.grey,
                        )
                      : const Icon(Icons.keyboard_arrow_down_outlined,
                          color: Colors.grey)
                ],
              ),
            ),
          ]),
        ),
        isSelect
            ? dropDownWidget(
                subCategory: widget.subCategory,
              )
            : const SizedBox()
      ]),
    );
  }
}

// ignore: camel_case_types
class dropDownWidget extends StatelessWidget {
  final List<dynamic> subCategory;
  const dropDownWidget({required this.subCategory, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffD9D3D2),
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
