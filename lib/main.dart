import 'package:flutter/material.dart';
import 'screens/list_page.dart';
import 'screens/waste_detail_page.dart';
import 'screens/choose_photo_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static final routes = {
    ListPage.routeName: (context) => ListPage(),
    WasteDetailPage.routeName: (context) => WasteDetailPage(),
    ChoosePhotoPage.routeName: (context) => ChoosePhotoPage()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      initialRoute: '/',
    );
  }
}