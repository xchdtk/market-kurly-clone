import 'package:flutter/material.dart';
import 'package:market_curly_clone/colors/color.dart';
import 'package:provider/provider.dart';

import '../../providers/products.dart';
import '../../providers/search.dart';
import '../home/new_items_screen.dart';
import 'package:collection/collection.dart';

class SearchListView extends StatefulWidget {
  const SearchListView({Key? key}) : super(key: key);

  @override
  State<SearchListView> createState() => _SearchListViewState();
}

class _SearchListViewState extends State<SearchListView> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final searchWord = Provider.of<SearchTextCheck>(context).searchWord;
    final products = Provider.of<GetProducts>(context).products;
    final filterProducts = products.where(
      (element) {
        return element.title.contains(searchWord);
      },
    ).toList();

    final searchProductsWidget = filterProducts.mapIndexed((index, element) {
      if (index % 2 == 1) {
        return const SizedBox();
      }
      if (filterProducts.length == 1 ||
          index % 2 == 0 && index == filterProducts.length - 1) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                flex: 1,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                )),
            ProductsView(product: element),
            Expanded(
                flex: 14,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                )),
          ],
        );
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Expanded(flex: 2, child: SizedBox()),
          ProductsView(product: element),
          const Expanded(flex: 1, child: SizedBox()),
          ProductsView(
            product: filterProducts[index + 1],
          ),
          const Expanded(flex: 2, child: SizedBox()),
        ],
      );
    }).toList();

    return Expanded(
      child: Scaffold(
        body: Scrollbar(
          controller: scrollController,
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              controller: scrollController,
              child: filterProducts.isNotEmpty
                  ? Column(children: [
                      CountSortWidget(productLength: filterProducts.length),
                      ...searchProductsWidget
                    ])
                  : SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              size: width * 0.1,
                              color: greyTone,
                            ),
                            Text(
                              "검색한 상품이 없습니다.",
                              style: TextStyle(color: greyTone),
                            )
                          ]),
                    )),
        ),
      ),
    );
  }
}
