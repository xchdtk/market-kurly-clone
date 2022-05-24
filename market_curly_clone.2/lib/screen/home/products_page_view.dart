import 'package:flutter/material.dart';

import 'new_items_screen.dart';
import ' suggestion_screen.dart';

class ProductsPageView extends StatefulWidget {
  final PageController controller;
  int currentPage;
  final ValueChanged<int>? onPageChange;

  ProductsPageView(
      {required this.controller,
      required this.currentPage,
      required this.onPageChange,
      Key? key})
      : super(key: key);

  @override
  State<ProductsPageView> createState() => _ProductsPageViewState();
}

class _ProductsPageViewState extends State<ProductsPageView> {
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
