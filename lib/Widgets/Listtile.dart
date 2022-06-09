import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:shopping_app/utilities/dimention.dart';

import '../utilities/colors.dart';

class Listtile extends StatelessWidget {
  final String name;
  IconData icon;
  Listtile({
    Key? key,
    required this.icon,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(name,
            style: TextStyle(
              fontFamily: 'Roboto',
              color: AppColors.textColor,
              fontSize: Dimention.Bigtextsize,
              fontWeight: FontWeight.w500,
            )),
        trailing: Icon(
          icon,
          color: AppColors.textColor,
          size: Dimention.iconsize,
        ));
  }
}
