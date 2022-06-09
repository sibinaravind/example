import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

import '../utilities/colors.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overFlow;
  BigText({
    Key? key,
    this.color = Colors.black12,
    required this.text,
    this.overFlow = TextOverflow.ellipsis,
    this.size = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        overflow: overFlow,
        maxLines: 1,
        style: TextStyle(
          fontFamily: 'Roboto',
          color: AppColors.mainColor,
          fontSize: size,
          fontWeight: FontWeight.w600,
        ));
  }
}
