import "package:flutter/material.dart";

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      showTrackOnHover: true,
      child: ListView(children: const [
        _categoryListWidget(),
        _categoryListWidget(),
        _categoryListWidget(),
        _categoryListWidget(),
        _categoryListWidget(),
        _categoryListWidget(),
        _categoryListWidget(),
        _categoryListWidget(),
        _categoryListWidget(),
        _categoryListWidget(),
        _categoryListWidget(),
        _categoryListWidget(),
        _categoryListWidget(),
        _categoryListWidget(),
        _categoryListWidget(),
        _categoryListWidget(),
        _categoryListWidget(),
        _categoryListWidget(),
        _categoryListWidget(),
        _categoryListWidget(),
        _categoryListWidget(),
        _categoryListWidget(),
        _categoryListWidget(),
      ]),
    );
  }
}

// ignore: camel_case_types
class _categoryListWidget extends StatefulWidget {
  const _categoryListWidget({Key? key}) : super(key: key);

  @override
  State<_categoryListWidget> createState() => __categoryListWidgetState();
}

// ignore: camel_case_types
class __categoryListWidgetState extends State<_categoryListWidget> {
  bool isSelect = false;
  @override
  Widget build(BuildContext context) {
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
                    children: const [
                      Text("채소1"),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text("채소2")
                    ],
                  ),
                  isSelect
                      ? const Icon(Icons.arrow_upward)
                      : const Icon(Icons.arrow_downward)
                ],
              ),
            ),
          ]),
        ),
        isSelect ? const dropDownWidget() : const SizedBox()
      ]),
    );
  }
}

// ignore: camel_case_types
class dropDownWidget extends StatelessWidget {
  const dropDownWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffD9D3D2),
      child: Container(
        padding: EdgeInsets.only(left: 55.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text("전체보기")),
            Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text("전체보기")),
            Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text("전체보기")),
          ],
        ),
      ),
    );
  }
}
