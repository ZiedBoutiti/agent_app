import 'package:agent/resources/colors.dart';
import 'package:flutter/material.dart';

///Show message
void showMessage(String message,
    {Color color = primaryColor, Color snackColor = secondColor , required BuildContext context}) {
  ScaffoldMessenger.of(context)
      .showSnackBar(
      SnackBar(
        backgroundColor: snackColor,
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: color),),
      )
  );
}