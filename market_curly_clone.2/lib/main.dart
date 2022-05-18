import 'package:flutter/material.dart';
import 'package:market_curly_clone/providers/category.dart';
import 'package:market_curly_clone/providers/search.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:market_curly_clone/screen/splash.dart';
import 'package:market_curly_clone/providers/login.dart';
import 'package:market_curly_clone/providers/navbar.dart';
import 'package:market_curly_clone/providers/products.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('LocalMarketKulry');
  await Hive.openBox('list');
  Hive.box('list').clear();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<GetProducts>(create: (_) => GetProducts()),
      ChangeNotifierProvider<GetCategories>(create: (_) => GetCategories()),
      ChangeNotifierProvider<NavbarIndex>(create: (_) => NavbarIndex()),
      ChangeNotifierProvider<LoginState>(create: (_) => LoginState()),
      ChangeNotifierProvider<RecentSearchesState>(
        create: (_) => RecentSearchesState(),
      ),
      ChangeNotifierProvider<RecentSearchesCheck>(
        create: (_) => RecentSearchesCheck(),
      )
    ],
    child: const MarketKurlyApp(),
  ));
}

class MarketKurlyApp extends StatelessWidget {
  const MarketKurlyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: Colors.white,
        ),
        home: const SplashScreen());
  }
}
