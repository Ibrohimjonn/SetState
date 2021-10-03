import 'package:flutter/material.dart';
import 'package:walley/pages/create_page.dart';
import 'package:walley/pages/home_page.dart';
import 'package:walley/pages/update_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
    HomePage.id: (context) => const HomePage(),
    CreatePage.id: (context) => const CreatePage(),
    UpdatePage.id: (context) => UpdatePage(),
    },
    );
  }
}
