import '../providers/category.dart';
import '../providers/navbar.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:market_curly_clone/screen/my/my_screen.dart';
import 'package:market_curly_clone/screen/home/home_screen.dart';
import 'package:market_curly_clone/screen/search/search_screen.dart';
import 'package:market_curly_clone/screen/category/category_screen.dart';

final List<String> appBarTitle = ["MarketKurly", "카테고리", "검색", "마이컬리"];

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({Key? key}) : super(key: key);

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CategoryScreen(),
    SearchScreen(),
    MyScreen()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<GetCategories>(context, listen: false).getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            appbar(appBarTitle[Provider.of<NavbarIndex>(context).seletedIndex]),
        body: Center(
          child: _widgetOptions
              .elementAt(Provider.of<NavbarIndex>(context).seletedIndex),
        ),
        bottomNavigationBar: _bottomNavigationBar());
  }

  AppBar appbar(String title) {
    return AppBar(
      backgroundColor: const Color(0xff5f0080),
      title: Text(title),
      centerTitle: true,
      actions: const [
        SizedBox(
          width: 10,
        ),
        Icon(Icons.location_on_outlined),
        SizedBox(
          width: 15,
        ),
        Icon(Icons.add_shopping_cart),
        SizedBox(
          width: 15,
        ),
      ],
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
          ),
          label: '홈',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: "카테고리"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "검색"),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_outlined), label: "마이컬리")
      ],
      type: BottomNavigationBarType.fixed,
      iconSize: 22,
      elevation: 0,
      currentIndex: Provider.of<NavbarIndex>(context).seletedIndex,
      selectedItemColor: Colors.purple,
      unselectedItemColor: Colors.black,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    Provider.of<NavbarIndex>(context, listen: false).ChangeSeletedIndex(index);
  }
}
