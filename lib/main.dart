import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/Screen/HomePage.dart';
import 'package:shopping_app/Screen/HomeTrail.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cafe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // scaffoldBackgroundColor: Palette.scaffold,
        primarySwatch: Colors.blue,
      ),
      home: HomeTrial(),
    );
  }
}
