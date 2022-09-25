
import 'package:agent/resources/colors.dart';
import 'package:agent/resources/styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final bool isWaiting;
  final Color color;
  final VoidCallback onPressed;
  final double fontSizeTitle;
  final double radius;
  const CustomButton({Key? key,required this.isWaiting  ,required this.title, required this.color, required this.onPressed, required this.fontSizeTitle, required this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TextButton(
      style: ButtonStyle(
        backgroundColor:
        MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return color;
            }
            return color;
          },
        ),
        shape: MaterialStateProperty.resolveWith<
            RoundedRectangleBorder>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(radius),
                  topLeft: Radius.circular(radius),
                ),
              );
            }
            return RoundedRectangleBorder(
              borderRadius:  BorderRadius.only(
                topRight: Radius.circular(radius),
                topLeft: Radius.circular(radius),
              ),

            );
          },
        ),
      ),
      onPressed: onPressed,
        // if (_formKey.currentState!.validate()) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //       const SnackBar(
        //           content: Text("Processing Data")));
        //   login.setNewName(userNameController.text.toString());
        //
        // }

      child: isWaiting == false  ?
      Text(
       title,
        style: buttonText.copyWith(
          fontSize: fontSizeTitle
        ),
      ) : const CircularProgressIndicator(
        color: secondColor,
      )
    );
  }
}

