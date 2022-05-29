import 'dart:async';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:market_curly_clone/colors/color.dart';
import 'package:market_curly_clone/screen/detail_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/products.dart';

class KulyPicks extends StatefulWidget {
  const KulyPicks({Key? key}) : super(key: key);

  @override
  State<KulyPicks> createState() => _KulyPicksState();
}

class _KulyPicksState extends State<KulyPicks> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: fetchProducts,
      child: Scrollbar(
          controller: scrollController,
          showTrackOnHover: false,
          child: ListView(
              controller: scrollController,
              scrollDirection: Axis.vertical,
              children: const [
                SliderImages(),
                HowAboutTheProductWidget(),
              ])),
    );
  }
}

class SliderImages extends StatefulWidget {
  const SliderImages({Key? key}) : super(key: key);

  @override
  State<SliderImages> createState() => _SliderImagesState();
}

class _SliderImagesState extends State<SliderImages> {
  List<String> images = [
    "https://img-cf.kurly.com/banner/main/pc/img/d266437d-ae52-472c-8582-f5f817b5b4bd",
    "http://img-cf.kurly.com/shop/data/goods/1626849521445l0.jpg",
    "http://img-cf.kurly.com/shop/data/goods/1626849521445l0.jpg"
  ];

  LoopPageController controller = LoopPageController(initialPage: 0);
  int currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (controller.hasClients) {
        currentPage = controller.page.toInt();
        int nextPage = currentPage + 1;
        if (currentPage == 2) {
          nextPage = 0;
        }

        controller.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(children: [
      SizedBox(
        width: width,
        height: height * 0.47,
        child: LoopPageView.builder(
          pageSnapping: true,
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              currentPage = index;
            });
          },
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Image.network(
              images[index],
              fit: BoxFit.cover,
            );
          },
        ),
      ),
      Positioned(
        right: 10,
        bottom: 10,
        child: Opacity(
          opacity: 0.4,
          child: Container(
            width: 40,
            height: 20,
            decoration: BoxDecoration(
                color: blackColor,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                '${currentPage + 1} / ${images.length}',
                textAlign: TextAlign.center,
                style: TextStyle(color: whiteColor),
              ),
            ]),
          ),
        ),
      )
    ]);
  }
}

// ignore: camel_case_types
class HowAboutTheProductWidget extends StatefulWidget {
  const HowAboutTheProductWidget({Key? key}) : super(key: key);

  @override
  State<HowAboutTheProductWidget> createState() =>
      _HowAboutTheProductWidgetState();
}

class _HowAboutTheProductWidgetState extends State<HowAboutTheProductWidget> {
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(
          top: height * 0.02,
          left: width * 0.015,
          right: width * 0.01,
          bottom: height * 0.1),
      padding: EdgeInsets.all(width * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            " 이 상품 어때요?",
            style:
                TextStyle(fontSize: width * 0.04, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: height * 0.015,
          ),
          SizedBox(
            width: width,
            height: height * 0.4,
            child: ListView(
              controller: controller,
              scrollDirection: Axis.horizontal,
              primary: false,
              children: Provider.of<GetProducts>(context)
                  .products
                  .map<Widget>(
                    (element) => Container(
                      width: width * 0.4,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 3,
                        vertical: 8,
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          await Provider.of<GetProduct>(context, listen: false)
                              .getProduct(1);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const DetailPageWidget()));
                        },
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(children: [
                                Image.network(
                                  element.thumbnail,
                                  width: width,
                                  height: height * 0.23,
                                  fit: BoxFit.fill,
                                ),
                                Positioned(
                                  bottom: 8,
                                  right: 8,
                                  child: SvgPicture.network(
                                    "https://s3.ap-northeast-2.amazonaws.com/res.kurly.com/kurly/ico/2021/cart_white_45_45.svg",
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                              ]),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(element.title),
                              Text("${element.price} 원",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold))
                            ]),
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
