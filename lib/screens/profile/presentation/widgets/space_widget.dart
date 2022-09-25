

import 'package:agent/resources/colors.dart';
import 'package:flutter/material.dart';

class SpaceWidget extends StatelessWidget {
  final double height;
  final double width;
  final double marginTop;
  const SpaceWidget({Key? key, this.height=3,  required this.width, this.marginTop = 20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(

      //   mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // SizedBox(
        //   height: marginTop,
        // ),
        Container(
          margin: const EdgeInsets.only(left: 160),
          height: height,
          color: nameColor,
          width: width,
        ),
        // const SizedBox(
        //   width: 50,
        // ),
        Container(
          margin: const EdgeInsets.only(right: 160),
          height: height,
          color: nameColor,
          width: width,
        ),
        // const SizedBox(
        //   height: 10,
        // ),
      ],
    );
  }
}
