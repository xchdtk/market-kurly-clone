import 'home_screen.dart';
import "package:flutter/material.dart";
import '../../providers/products.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class NewItem extends StatefulWidget {
  const NewItem({Key? key}) : super(key: key);

  @override
  State<NewItem> createState() => NewItemState();
}

class NewItemState extends State<NewItem> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<GetProducts>(context).products;

    return Column(children: [
      Expanded(
        child: Scaffold(
          body: RefreshIndicator(
            onRefresh: fetchProducts,
            child: Scrollbar(
              showTrackOnHover: true,
              controller: scrollController,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                controller: scrollController,
                child: Column(
                  children: [
                    CountSortWidget(productLength: products.length),
                    ...products.mapIndexed((index, element) {
                      if (index % 2 == 1) {
                        return const SizedBox();
                      }
                      if (products.length == 1 ||
                          index % 2 == 0 && index == products.length - 1) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 1,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                )),
                            ProductsView(product: element),
                            Expanded(
                                flex: 14,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
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
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                              )),
                          ProductsView(
                            product: element,
                          ),
                          Expanded(
                              flex: 1,
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                              )),
                          ProductsView(
                            product: products[index + 1],
                          ),
                          Expanded(
                              flex: 2,
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                              )),
                        ],
                      );
                    }).toList()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}

class CountSortWidget extends StatelessWidget {
  final int productLength;
  const CountSortWidget({required this.productLength, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.01,
          vertical: MediaQuery.of(context).size.width * 0.01),
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04,
          vertical: MediaQuery.of(context).size.width * 0.01),
      height: MediaQuery.of(context).size.height * 0.04,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("총 $productLength개", style: const TextStyle(fontSize: 14)),
          const DropDownWidget(),
        ],
      ),
    );
  }
}

class ProductsView extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final product;
  const ProductsView({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.44,
      margin: EdgeInsets.symmetric(horizontal: width * 0.002),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(product.thumbnail,
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width / 2,
              fit: BoxFit.fill),
          const SizedBox(
            height: 15,
          ),
          Text(
            product.title,
            style: const TextStyle(fontSize: 14),
          ),
          Text(product.price),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
