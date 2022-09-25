import 'package:agent/resources/colors.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;
  final Color color;
  const ButtonWidget(
      {Key? key,
      required this.title,
      required this.onPressed,
      required this.color})
      : super(key: key);

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  bool load = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return widget.color;
              }
              return widget.color.withOpacity(0.8);
            },
          ),
        ),
        onPressed: () {
          load = true;
          setState(() {});
           widget.onPressed();
            load = false;
            setState(() {});
        },
        child: load
            ? Container(
                padding: const EdgeInsets.all(2.0),
                width: 20,
                height: 20,
                child: const CircularProgressIndicator(
                  color: secondWhite,
                  strokeWidth: 2,
                ),
              )
            : Text(widget.title));
  }
}
