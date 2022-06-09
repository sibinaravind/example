import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shopping_app/Screen/ItemDisplay.dart';
import 'package:shopping_app/Widgets/big_text.dart';
import 'package:shopping_app/networkHandler.Dart';
import 'package:shopping_app/utilities/colors.dart';
import 'package:shopping_app/utilities/dimention.dart';

import '../Widgets/Listtile.dart';
import '../Widgets/widgets.dart';

class HomeTrial extends StatefulWidget {
  @override
  _HomeTrialState createState() => _HomeTrialState();
}

class _HomeTrialState extends State<HomeTrial> {
  NetworkHandler networkhandler = NetworkHandler();
  Widget page = CircularProgressIndicator();
  String header = 'Recommended';
  String cat = 'Recommended';
  var catt = ValueNotifier('Recommended');
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final SnackBar _snackBar = SnackBar(
    content: SmallText(
      text: "Item added to the Cart",
      color: Colors.white,
      size: 15,
    ),
    duration: const Duration(seconds: 3),
    backgroundColor: AppColors.mainColor,
  );
  List<dynamic> datas = [];
  var price = 100;

  @override
  void initState() {
    fetchdata();
    super.initState();
    // checkProfile();
  }

  void fetchdata() async {
    print(cat);
    datas = [];
    var response =
        await networkhandler.get("https://api.storerestapi.com/products");
    int i = 0;
    if (cat == "Recommended") {
      setState(() {
        datas = response["data"];
      });
    } else {
      response["data"]
          .map((item) => {
                if (item["category"]["slug"] == cat) {datas.add(item)}
              })
          .toList();
      print(datas);
      setState(() {
        datas;
      });
    }
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
                        header = 'Men\'s Fashion',
                        cat = "mens-fashion",
                        fetchdata()
                        // ItemDisplay(
                        //   cat: "mens-fashion",
                        // )
                      });
                  catt.value = "mens-fashion";
                },
                child: Listtile(
                  icon: Icons.boy_sharp,
                  name: 'Men\'s Fashion',
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() => {
                        header = 'Women\'s Fashion',
                        cat = "womens-fashion",
                        fetchdata()
                      });
                  Navigator.of(context).pop();
                },
                child: Listtile(
                  icon: Icons.girl,
                  name: 'Women\'s Fashion',
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() => {
                        header = 'Jewellery & watches',
                        cat = "jewlary-and-watches",
                        fetchdata()
                      });
                  Navigator.of(context).pop();
                },
                child: Listtile(
                  icon: Icons.watch,
                  name: 'Jewellery & watches',
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() => {
                        header = 'Bags & Shoes',
                        cat = "bags-and-shoes",
                        fetchdata()
                      });
                  Navigator.of(context).pop();
                },
                child: Listtile(
                  icon: Icons.shopping_bag,
                  name: 'Bags & Shoes',
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() =>
                      {header = 'Computer', cat = "computers", fetchdata()});
                  Navigator.of(context).pop();
                },
                child: Listtile(
                  icon: Icons.computer,
                  name: 'Computer',
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() => {
                        header = 'Phone & Tablets',
                        cat = "phone-and-tablets",
                        fetchdata()
                      });
                  Navigator.of(context).pop();
                },
                child: Listtile(
                  icon: Icons.phone_android,
                  name: 'Phone & Tablets',
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() => {
                        header = 'Tools & Hardware',
                        cat = "tools-and-hardware",
                        fetchdata()
                      });
                  Navigator.of(context).pop();
                },
                child: Listtile(
                  icon: Icons.toll_rounded,
                  name: 'Tools & Hardware',
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() => {
                        header = 'Home & Furniture',
                        cat = "home-and-furniture",
                        fetchdata()
                      });
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
              setState(() =>
                  {header = 'Recommended', cat = "Recommended", fetchdata()});
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
                  Column(
                      key: _scaffoldKey,
                      children: datas
                          .map((item) => datas.isEmpty
                              ? Center(
                                  child: Text(
                                    "Cant load Items , please Try again",
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        height: 110,
                                        width: Dimention.screenWidth / 1.05,
                                        decoration: const BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 2.0)
                                            ],
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      print("Hello");
                                                    },
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      children: [
                                                        BigText(
                                                          text: item["title"],
                                                          size: 17,
                                                        ),
                                                        SmallText(
                                                          text: item["category"]
                                                              ["name"],
                                                          size: 15,
                                                          color: Colors.grey,
                                                        ),
                                                        SmallText(
                                                          text: "seller :" +
                                                              item["createdBy"]
                                                                  ["name"],
                                                          color: Colors.grey,
                                                        ),
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 1,
                                                                  bottom: 1),
                                                          child: Divider(
                                                              thickness: 1.5),
                                                        ),
                                                        SmallText(
                                                          text:
                                                              "\u{20B9}${item["price"]}",
                                                          size: 16,
                                                          color: AppColors
                                                              .mainColor,
                                                        )
                                                      ],
                                                    )),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(_snackBar);
                                              },
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  height: 110,
                                                  width:
                                                      Dimention.screenWidth / 7,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                    ),
                                                    color: AppColors.mainColor,
                                                  ),
                                                  child: const Text(
                                                      "Add To Cart",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        // fontFamily: 'Raleway',
                                                        color: Color.fromARGB(
                                                            255, 253, 255, 253),
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ))),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
                          .toList()),
                ],
              ))),
        ));
  }
}
