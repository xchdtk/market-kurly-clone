import 'package:flutter/material.dart';
import 'package:market_curly_clone/providers/search.dart';
import 'package:market_curly_clone/screen/search/real_time_search.dart';
import 'package:market_curly_clone/screen/search/search_list.dart';
import 'package:market_curly_clone/screen/search/search_screen.dart';
import 'package:provider/provider.dart';

import '../../colors/color.dart';

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
    // ignore: todo
    // TODO: implement initState
    super.initState();

    focusNode.addListener(() {
      setState(() {
        if (focusNode.hasFocus) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Provider.of<SearchTextCheck>(context, listen: false)
                .changeWidget([const RealTimeSearchWidget()]);
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.07,
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          height: height * 0.05,
          padding: EdgeInsets.only(top: height * 0.008),
          margin: EdgeInsets.symmetric(vertical: height * 0.008),
          color: greyTone,
          width: focusNode.hasFocus ? width * 0.8 : width * 0.92,
          child: TextFormField(
              onChanged: (text) {
                Provider.of<SearchTextCheck>(context, listen: false)
                    .changeText(text);
                setState(() {});
              },
              cursorColor: blackColor,
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
                  fillColor: greyTone,
                  hintText: "검색어를 입력해주세요",
                  prefixIcon: Align(
                    widthFactor: 0.5,
                    heightFactor: 1,
                    child: Icon(
                      Icons.search,
                      color: greyColor,
                    ),
                  ),
                  suffixIcon: searchController.text == ''
                      ? null
                      : IconButton(
                          padding: EdgeInsets.only(bottom: height * 0.0075),
                          icon: Icon(
                            Icons.highlight_remove,
                            color: greyColor,
                          ),
                          onPressed: () {
                            searchController.clear();
                            Provider.of<SearchTextCheck>(context, listen: false)
                                .changeText("");
                            setState(() {});
                          }))),
        ),
        focusNode.hasFocus
            ? const Expanded(flex: 2, child: SizedBox())
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
            ? const Expanded(flex: 1, child: SizedBox())
            : const SizedBox(),
      ]),
    );
  }
}
