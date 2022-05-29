import "package:flutter/material.dart";

import 'package:market_curly_clone/providers/search.dart';
import 'package:market_curly_clone/screen/search/recent_search.dart';
import 'package:provider/provider.dart';

import 'input_search.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SearchTextCheck>(
            create: (_) => SearchTextCheck()),
      ],
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            //FocusManager.instance.primaryFocus?.unfocus();
            FocusScope.of(context).unfocus();
          },
          child: Consumer<SearchTextCheck>(
            builder: ((context, value, child) {
              return Container(
                  margin: EdgeInsets.only(
                      top: width * 0.03,
                      bottom: width * 0.03,
                      left: width * 0.03,
                      right: width * 0.03),
                  child: Column(children: [
                    const InputSearchWidget(),
                    value.searchWord != ""
                        ? Provider.of<SearchTextCheck>(context)
                                .listWidget
                                .isEmpty
                            ? const SizedBox()
                            : Provider.of<SearchTextCheck>(context)
                                .listWidget[0]
                        : const RecentSearchWidget()
                  ]));
            }),
          ),
        ),
      ),
    );
  }
}

class TextStyleWidget extends StatelessWidget {
  final String title;
  const TextStyleWidget({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.002, vertical: height * 0.015),
      child: Text(title),
    );
  }
}
