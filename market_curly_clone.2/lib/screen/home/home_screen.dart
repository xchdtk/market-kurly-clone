import "package:flutter/material.dart";
import 'package:market_curly_clone/screen/home/products_page_view.dart';
import 'package:market_curly_clone/screen/home/top_bar.dart';
import 'package:market_curly_clone/screen/loading.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'package:market_curly_clone/providers/products.dart';

// ignore: constant_identifier_names
const List<String> TopBarMenus = ["컬리추천", "신상품", "베스트", "알뜰쇼핑", "특가/혜택"];

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
            ? const LoadingScreen()
            : Expanded(
                child: ProductsPageView(
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
      return TopBar(
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
