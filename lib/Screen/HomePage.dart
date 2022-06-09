import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shopping_app/Screen/ItemDisplay.dart';
import 'package:shopping_app/Widgets/big_text.dart';
import 'package:shopping_app/networkHandler.Dart';
import 'package:shopping_app/utilities/colors.dart';
import 'package:shopping_app/utilities/dimention.dart';

import '../Widgets/Listtile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NetworkHandler networkhandler = NetworkHandler();
  Widget page = CircularProgressIndicator();
  String header = 'Recommended';
  String cat = 'Recommended';
  var catt = ValueNotifier('Recommended');
  @override
  void initState() {
    super.initState();
    // checkProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          backgroundColor: AppColors.mainColor,
          elevation: 50,
          child: ListView(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(true);
                  // Navigator.of(context).pushReplacement(
                  //                     MaterialPageRoute(builder: (context) => super.widget));
                  setState(() => {
                        header = 'Mens Collection',
                        cat = "mens-fashion",
                        // ItemDisplay(
                        //   cat: "mens-fashion",
                        // )
                      });
                  catt.value = "men\'s-fashion";
                },
                child: Listtile(
                  icon: Icons.boy_sharp,
                  name: 'Men\'s Collection',
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(
                      () => {header = 'Women\'s Collection', cat = "Womens"});
                  Navigator.of(context).pop();
                },
                child: Listtile(
                  icon: Icons.girl,
                  name: 'Women\'s Collection',
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() => {header = 'Jewellery & watches'});
                  Navigator.of(context).pop();
                },
                child: Listtile(
                  icon: Icons.watch,
                  name: 'Jewellery & watches',
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() => {header = 'Bags & Shoes'});
                  Navigator.of(context).pop();
                },
                child: Listtile(
                  icon: Icons.shopping_bag,
                  name: 'Bags & Shoes',
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() => {header = 'Computer'});
                  Navigator.of(context).pop();
                },
                child: Listtile(
                  icon: Icons.computer,
                  name: 'Computer',
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() => {header = 'Phone & Tablets'});
                  Navigator.of(context).pop();
                },
                child: Listtile(
                  icon: Icons.phone_android,
                  name: 'Phone & Tablets',
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() => {header = 'Tools & Hardware'});
                  Navigator.of(context).pop();
                },
                child: Listtile(
                  icon: Icons.toll_rounded,
                  name: 'Tools & Hardware',
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() => {header = 'Home & Furniture'});
                  Navigator.of(context).pop();
                },
                child: Listtile(
                  icon: Icons.home_filled,
                  name: 'Home & Furniture',
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          brightness: Brightness.light,
          automaticallyImplyLeading: true,
          iconTheme:
              IconThemeData(color: AppColors.textColor, opacity: 30, size: 40),
          // flexibleSpace: Image.asset("assets/pilasaLogo2.png"),
          title: GestureDetector(
            onTap: () {
              setState(() => {header = 'Recommended'});
            },
            child: Text("Shoppers Choice"),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                  child: Column(
                children: [
                  Row(
                    children: [
                      BigText(
                        text: header,
                        size: Dimention.Bigtextsize + 1.5,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ValueListenableBuilder(
                      valueListenable: catt,
                      builder: (context, String n, Widget? child) {
                        print(n);
                        return ItemDisplay(
                          cat: n,
                        );
                      })
                ],
              ))),
        ));
  }
}
