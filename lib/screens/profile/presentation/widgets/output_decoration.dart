import 'package:agent/resources/colors.dart';
import 'package:flutter/material.dart';

class OutputDecoration extends StatelessWidget {
  final String title;
  final Widget widget;
  final double vertical;
  final double horizontalTitle;
  final double height;
  final Color backTextColor;
  final Color borderColor;
  final double borderWidth;
  const OutputDecoration({
    Key? key,
    required this.title,
    required this.widget,
    this.vertical = 15,
    this.horizontalTitle = 10,
    this.height = 50,
    this.backTextColor = secondColor,
    this.borderColor = primaryColor,
    this.borderWidth = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.passthrough, children: [
      ///decoration box
      Container(
          margin: const EdgeInsets.only(
            top: 10,
          ),
          height: height == 0 ? null : height,
          // height: height,
          // height: vertical,
          // width: 10,
          padding: height == 0
              ? EdgeInsets.symmetric(horizontal: 10, vertical: vertical)
              : null,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: borderColor, width: borderWidth)),
          child: height != 0 ? Center(child: widget) : widget),

      ///title
      horizontalTitle == 0
          ? Center(
              child: Text(
                title,
                //  textAlign: horizontalTitle == 0 ? TextAlign.center : null,
                style: TextStyle(
                    color: primaryColor, backgroundColor: backTextColor),
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalTitle),
              child: Text(
                title,
                //   textAlign: horizontalTitle == 0 ? TextAlign.center : null,
                style: TextStyle(
                    color: primaryColor, backgroundColor: backTextColor),
              ),
            )
    ]);
  }
}
