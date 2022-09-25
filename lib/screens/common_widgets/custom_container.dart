
import 'package:agent/config/utils.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget widget;
  const CustomContainer({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(
          left: getScreenWidth(context) / 2 * .1,
          right: getScreenWidth(context) / 2 * .1,
        //  bottom: 5,
         // top: getScreenHeight(context) * .1),
      ),


      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: const Color(0xffffffff),
      ),
      child: widget,
    );
  }
}
