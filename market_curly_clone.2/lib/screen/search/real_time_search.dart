import 'package:flutter/material.dart';
import 'package:market_curly_clone/colors/color.dart';
import 'package:market_curly_clone/screen/search/search_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/products.dart';
import '../../providers/search.dart';

class RealTimeSearchWidget extends StatelessWidget {
  const RealTimeSearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final searchWord = Provider.of<SearchTextCheck>(context).searchWord;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: width * 0.002, vertical: height * 0.015),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.02,
            child: Text(
              "상품 바로가기",
              style: TextStyle(color: greyTone, fontSize: width * 0.035),
            ),
          ),
          Expanded(
            child: Scrollbar(
              child: ListView(
                  children: Provider.of<GetProducts>(context, listen: false)
                      .products
                      .where((item) {
                return item.title.contains(searchWord);
              }).map((item) {
                return TextStyleWidget(title: item.title);
              }).toList()),
            ),
          )
        ],
      ),
    );
  }
}
