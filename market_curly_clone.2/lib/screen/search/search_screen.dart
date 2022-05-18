import 'package:badges/badges.dart';
import "package:flutter/material.dart";
import 'package:market_curly_clone/providers/search.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import '../../providers/products.dart';
import '../home/new_items_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
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
                            ? SizedBox()
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

class InputSearchWidget extends StatefulWidget {
  const InputSearchWidget({Key? key}) : super(key: key);

  @override
  State<InputSearchWidget> createState() => _InputSearchWidgetState();
}

class _InputSearchWidgetState extends State<InputSearchWidget> {
  FocusNode focusNode = FocusNode();
  // ignore: prefer_typing_uninitialized_variables

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    focusNode.addListener(() {
      setState(() {
        if (focusNode.hasFocus) {
          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            Provider.of<SearchTextCheck>(context, listen: false)
                .changeWidget([const ProductTitleWidget()]);
          });
        }
      });
    });
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.07,
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.05,
          margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.008),
          color: const Color(0xffEAE3E2),
          width: focusNode.hasFocus
              ? MediaQuery.of(context).size.width * 0.8
              : MediaQuery.of(context).size.width * 0.92,
          child: TextFormField(
              onChanged: (text) {
                Provider.of<SearchTextCheck>(context, listen: false)
                    .changeText(text);
                setState(() {});
              },
              cursorColor: Colors.black,
              focusNode: focusNode,
              controller: searchController,
              textInputAction: TextInputAction.search,
              onFieldSubmitted: (value) {
                Provider.of<RecentSearchesCheck>(context, listen: false)
                    .addSearchWords(
                        Provider.of<SearchTextCheck>(context, listen: false)
                            .searchWord);

                Provider.of<SearchTextCheck>(context, listen: false)
                    .changeWidget([const SearchListView()]);
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.grey,
                  hintText: "검색어를 입력해주세요",
                  prefixIcon: const Align(
                    widthFactor: 0.5,
                    heightFactor: 1,
                    child: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                  ),
                  suffixIcon: searchController.text == ''
                      ? null
                      : IconButton(
                          icon: const Icon(
                            Icons.highlight_remove,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            searchController.clear();
                            Provider.of<SearchTextCheck>(context, listen: false)
                                .changeText("");
                            setState(() {});
                          }))),
        ),
        focusNode.hasFocus
            ? const Expanded(
                flex: 2,
                child: SizedBox(
                  height: 40,
                ))
            : const SizedBox(),
        focusNode.hasFocus
            ? GestureDetector(
                onTap: () {
                  focusNode.unfocus();
                  searchController.clear();
                  Provider.of<SearchTextCheck>(context, listen: false)
                      .changeText("");
                },
                child: const Text("취소"))
            : const SizedBox(),
        focusNode.hasFocus
            ? const Expanded(
                flex: 1,
                child: SizedBox(
                  height: 40,
                ))
            : const SizedBox(),
      ]),
    );
  }
}

class ContentsWidget extends StatefulWidget {
  const ContentsWidget({Key? key}) : super(key: key);

  @override
  State<ContentsWidget> createState() => _ContentsWidgetState();
}

class _ContentsWidgetState extends State<ContentsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [RecentSearchWidget()],
    );
  }
}

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
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<RecentSearchesCheck>(context, listen: false).getItem();
      if (Provider.of<RecentSearchesState>(context, listen: false)
          .deleteState) {
        Provider.of<RecentSearchesState>(context, listen: false).changeState();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
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
                    const Text(
                      "최근 검색어",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                                              onTap: () {
                                                Provider.of<RecentSearchesCheck>(
                                                        context,
                                                        listen: false)
                                                    .deleteSearchWords();
                                                Provider.of<RecentSearchesCheck>(
                                                        context,
                                                        listen: false)
                                                    .getItem();

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
          Row(
              children: Provider.of<RecentSearchesCheck>(context)
                  .searchWords
                  .mapIndexed((index, element) {
            return BadgeWidget(title: element, index: index);
          }).toList())
        ],
      ),
    );
  }
}

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({Key? key}) : super(key: key);

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class BadgeWidget extends StatefulWidget {
  final String title;
  final int index;
  const BadgeWidget({required this.title, required this.index, Key? key})
      : super(key: key);

  @override
  State<BadgeWidget> createState() => _BadgeWidgetState();
}

class _BadgeWidgetState extends State<BadgeWidget> {
  @override
  Widget build(BuildContext context) {
    final deleteState = Provider.of<RecentSearchesState>(context).deleteState;
    return Container(
      margin: const EdgeInsets.all(5),
      child: Badge(
        toAnimate: false,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        shape: BadgeShape.square,
        borderRadius: BorderRadius.circular(30),
        badgeColor: Colors.white,
        badgeContent: GestureDetector(
          onTap: () {
            if (deleteState) {
              Provider.of<RecentSearchesCheck>(context, listen: false)
                  .updateSearchWords(widget.index);
              Provider.of<RecentSearchesCheck>(context, listen: false)
                  .getItem();
            } else {
              // 추후 상세페이지 기능 구현 시 추가
              print("상세페이지 이동");
            }
          },
          child: Row(children: [
            Text(
              widget.title,
              style: const TextStyle(color: Colors.black),
            ),
            deleteState
                ? const Icon(
                    Icons.remove,
                    size: 15,
                  )
                : const SizedBox()
          ]),
        ),
      ),
    );
  }
}

class ProductTitleWidget extends StatelessWidget {
  const ProductTitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchWord = Provider.of<SearchTextCheck>(context).searchWord;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.02,
            child: const Text(
              "상품 바로가기",
              style: TextStyle(color: Colors.grey, fontSize: 12),
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

class TextStyleWidget extends StatelessWidget {
  final String title;
  const TextStyleWidget({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
      child: Text(title),
    );
  }
}

class SearchListView extends StatefulWidget {
  const SearchListView({Key? key}) : super(key: key);

  @override
  State<SearchListView> createState() => _SearchListViewState();
}

class _SearchListViewState extends State<SearchListView> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
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
          Expanded(
              flex: 2,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              )),
          ProductsView(product: element),
          Expanded(
              flex: 1,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              )),
          ProductsView(
            product: filterProducts[index + 1],
          ),
          Expanded(
              flex: 2,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              )),
        ],
      );
    }).toList();

    return Expanded(
      child: Scaffold(
        body: Scrollbar(
          showTrackOnHover: true,
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
                          children: const [
                            Icon(
                              Icons.search,
                              size: 100,
                              color: Colors.grey,
                            ),
                            Text(
                              "검색한 상품이 없습니다.",
                              style: TextStyle(color: Colors.grey),
                            )
                          ]),
                    )),
        ),
      ),
    );
  }
}
