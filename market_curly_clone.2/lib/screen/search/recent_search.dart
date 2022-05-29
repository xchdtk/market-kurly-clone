import 'package:flutter/material.dart';
import 'package:market_curly_clone/screen/search/search_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/search.dart';
import 'package:collection/collection.dart';

import 'badge.dart';

class RecentSearchWidget extends StatefulWidget {
  const RecentSearchWidget({Key? key}) : super(key: key);

  @override
  State<RecentSearchWidget> createState() => _RecentSearchWidgetState();
}

class _RecentSearchWidgetState extends State<RecentSearchWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (Provider.of<RecentSearchesState>(context, listen: false)
          .deleteState) {
        Provider.of<RecentSearchesState>(context, listen: false).changeState();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Provider.of<RecentSearchesCheck>(context).searchWords.isEmpty
              ? const SizedBox()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "최근 검색어",
                      style: TextStyle(
                          fontSize: width * 0.045, fontWeight: FontWeight.bold),
                    ),
                    Provider.of<RecentSearchesState>(context).deleteState
                        ? GestureDetector(
                            onTap: () {
                              Provider.of<RecentSearchesState>(context,
                                      listen: false)
                                  .changeState();
                            },
                            child: const Text("삭제 완료"))
                        : IconButton(
                            icon: const Icon(Icons.toc),
                            onPressed: () => showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(10.0))),
                                builder: (context) {
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    child: Container(
                                      margin: EdgeInsets.all(
                                          MediaQuery.of(context).size.width *
                                              0.05),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Provider.of<RecentSearchesState>(
                                                        context,
                                                        listen: false)
                                                    .changeState();
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                "선택 삭제",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                await Provider.of<
                                                            RecentSearchesCheck>(
                                                        context,
                                                        listen: false)
                                                    .deleteSearchWords();

                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                "전체 삭제",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            )
                                          ]),
                                    ),
                                  );
                                })),
                  ],
                ),
          SizedBox(
            width: width,
            height: height * 0.07,
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: Provider.of<RecentSearchesCheck>(context)
                    .searchWords
                    .mapIndexed((index, element) {
                  return BadgeWidget(title: element[1], index: element[0]);
                }).toList()),
          )
        ],
      ),
    );
  }
}
