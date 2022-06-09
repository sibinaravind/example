import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shopping_app/utilities/dimention.dart';

import '../Widgets/widgets.dart';
import '../networkHandler.Dart';
import '../utilities/colors.dart';

class ItemDisplay extends StatefulWidget {
  const ItemDisplay({Key? key, required this.cat}) : super(key: key);
  final dynamic cat;
  @override
  State<ItemDisplay> createState() => _ItemDisplayState();
}

class _ItemDisplayState extends State<ItemDisplay> {
  NetworkHandler networkHandler = NetworkHandler();

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
  }

  void fetchdata() async {
    print(widget.cat);
    var response =
        await networkHandler.get("https://api.storerestapi.com/products");
    int i = 0;
    if (widget.cat == "Recommended") {
      setState(() {
        datas = response["data"];
      });
    } else {
      response["data"]
          .map((item) => {
                if (item["category"]["slug"] == widget.cat) {datas.add(item)}
              })
          .toList();
      setState(() {
        datas;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                                BoxShadow(color: Colors.grey, blurRadius: 2.0)
                              ],
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: Color.fromARGB(255, 255, 255, 255)),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                      onTap: () {
                                        print("Hello");
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        textDirection: TextDirection.rtl,
                                        children: [
                                          BigText(
                                            text: item["title"],
                                            size: 17,
                                          ),
                                          SmallText(
                                            text: item["category"]["name"],
                                            size: 15,
                                            color: Colors.grey,
                                          ),
                                          SmallText(
                                            text: "seller :" +
                                                item["createdBy"]["name"],
                                            color: Colors.grey,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: 1, bottom: 1),
                                            child: Divider(thickness: 1.5),
                                          ),
                                          SmallText(
                                            text: "\u{20B9}${item["price"]}",
                                            size: 16,
                                            color: AppColors.mainColor,
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
                                    width: Dimention.screenWidth / 7,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                      color: AppColors.mainColor,
                                    ),
                                    child: const Text("Add To Cart",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          // fontFamily: 'Raleway',
                                          color: Color.fromARGB(
                                              255, 253, 255, 253),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                        ))),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ))
            .toList());
  }
}
