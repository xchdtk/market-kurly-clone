import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'package:market_curly_clone/providers/products.dart';

import 'new_items_screen.dart';
import ' suggestion_screen.dart';

// ignore: constant_identifier_names
const List<String> TopBarMenus = ["컬리추천", "신상품", "베스트", "알뜰쇼핑", "특가/혜택"];
// ignore: constant_identifier_names
const List<String> DropDownMenus = ['신상품순', '판매량순', "혜택순", "낮은 가격순", "높은 가격순"];
const Duration defaultDuration = Duration(milliseconds: 200);
const Curve defaultCurve = Curves.linear;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController controller = PageController(initialPage: 0);
  int currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<GetProducts>(context, listen: false).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<GetProducts>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(children: [
        SizedBox(
          width: width,
          height: height * 0.05,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [...rendermenu()]),
        ),
        productsData.loading
            ? SizedBox(
                width: width * 0.02,
                height: width * 0.02,
                child: const ScrollConfiguration(
                  behavior: ScrollBehavior(),
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    strokeWidth: 2,
                  ),
                ))
            : Expanded(
                child: _PageView(
                controller: controller,
                currentPage: currentPage,
                onPageChange: (page) => {
                  setState(() => {currentPage = page}),
                },
              )),
      ]),
    );
  }

  List<Widget> rendermenu() {
    final widgets = TopBarMenus.mapIndexed((index, element) {
      return _TopBar(
          menu: element,
          onTap: () {
            controller.animateToPage(index,
                duration: defaultDuration, curve: defaultCurve);
          },
          isActive: currentPage == index);
    }).toList();

    return widgets;
  }
}

class _TopBar extends StatefulWidget {
  final String menu;
  final VoidCallback onTap;
  final bool isActive;

  const _TopBar(
      {required this.menu,
      required this.onTap,
      required this.isActive,
      Key? key})
      : super(key: key);

  @override
  State<_TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<_TopBar> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.all(width * 0.033),
        child: Text(widget.menu,
            style: TextStyle(
                fontSize: width * 0.028,
                color: widget.isActive
                    ? const Color(0xff5f0080)
                    : const Color.fromARGB(255, 129, 124, 124))),
        decoration: widget.isActive
            ? const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 3, color: Color(0xff5f0080))))
            : null,
      ),
    );
  }
}

// ignore: must_be_immutable
class _PageView extends StatefulWidget {
  final PageController controller;
  int currentPage;
  final ValueChanged<int>? onPageChange;

  _PageView(
      {required this.controller,
      required this.currentPage,
      required this.onPageChange,
      Key? key})
      : super(key: key);

  @override
  State<_PageView> createState() => __PageViewState();
}

class __PageViewState extends State<_PageView> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: widget.controller,
      onPageChanged: widget.onPageChange,
      scrollDirection: Axis.horizontal,
      children: const [
        KulyPicks(),
        NewItem(),
        NewItem(),
        NewItem(),
        NewItem(),
      ],
    );
  }
}

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({Key? key}) : super(key: key);

  @override
  State<DropDownWidget> createState() => DropDownWidgetState();
}

class DropDownWidgetState extends State<DropDownWidget> {
  String dropdownValue = DropDownMenus[0];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down_sharp),
      elevation: 16,
      style: TextStyle(fontSize: width * 0.025, color: Colors.black),
      underline: const SizedBox(),
      // ignore: non_constant_identifier_names
      onChanged: (String? NewValue) {
        setState(() {
          dropdownValue = NewValue!;
        });
      },
      items: DropDownMenus.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
