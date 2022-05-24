import "package:flutter/material.dart";
import 'package:market_curly_clone/colors/color.dart';
import 'package:market_curly_clone/providers/category.dart';
import 'package:market_curly_clone/screen/loading.dart';
import 'package:provider/provider.dart';

import 'category_list.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final categoriesData = Provider.of<GetCategories>(context);
    return categoriesData.loading
        ? const LoadingScreen()
        : Scrollbar(
            child: ListView(children: [
              ...categoriesData.categories
                  .map((element) => CategoryListWidget(
                        icon: element.icon,
                        title: element.title,
                        subCategory: element.subCategory,
                      ))
                  .toList()
            ]),
          );
  }
}
