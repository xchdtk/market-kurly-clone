import 'package:flutter/material.dart';
import 'package:market_curly_clone/colors/color.dart';
import 'package:market_curly_clone/providers/products.dart';
import 'package:provider/provider.dart';

class DetailPageWidget extends StatefulWidget {
  const DetailPageWidget({Key? key}) : super(key: key);

  @override
  State<DetailPageWidget> createState() => _DetailPageWidgetState();
}

class _DetailPageWidgetState extends State<DetailPageWidget> {
  late final productData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    productData = Provider.of<GetProduct>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: blackColor),
        backgroundColor: whiteColor,
        toolbarHeight: height * 0.06,
        title: Text(
          productData.product.title,
          style: TextStyle(color: blackColor, fontSize: width * 0.045),
        ),
        centerTitle: true,
        actions: [
          const Icon(Icons.add_shopping_cart),
          SizedBox(
            width: width * 0.04,
          ),
        ],
      ),
      body: productData.loading
          ? SizedBox(
              width: width * 0.02,
              height: width * 0.02,
              child: const ScrollConfiguration(
                behavior: ScrollBehavior(),
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                  strokeWidth: 2,
                ),
              ))
          : Center(
              child: Text(productData.product.title),
            ),
    );
  }
}
