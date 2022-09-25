import 'package:agent/config/utils.dart';
import 'package:agent/resources/colors.dart';
import 'package:flutter/material.dart';

class PasswordFromField extends StatefulWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final VoidCallback onPressed;
  final dynamic validator;
  const PasswordFromField({
    Key? key,
    required this.hintText,
    required this.textEditingController,
    required this.onPressed,
    this.validator,
  }) : super(key: key);

  @override
  State<PasswordFromField> createState() => _PasswordFromFieldState();
}

class _PasswordFromFieldState extends State<PasswordFromField> {
  bool show = true;

  OutlineInputBorder outlineInputBorder(Color color, {double width = 0.0}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16.0, color: primaryColor),
      maxLength: 4,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          hintText: widget.hintText,
          focusedBorder: outlineInputBorder(primaryColor),
          enabledBorder: outlineInputBorder(disableColor, width: 2.0),
          errorBorder: outlineInputBorder(endTaskButton, width: 2.0),
          focusedErrorBorder: outlineInputBorder(endTaskButton, width:  1.0),
          errorStyle: const TextStyle(fontSize: 10),
          suffixIcon: GestureDetector(
            onTap: () {
              show = !show;
              setState(() {});
            },
            child: Icon(
              show ? Icons.visibility_off : Icons.visibility,
              color: primaryColor,
            ),
          )
      ),
      cursorColor: primaryColor,
      //autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.textEditingController,
      obscureText: show,
      validator: widget.validator
    );
  }
}


String? passwordFieldValidator(String? value, BuildContext context) {
  var local = getAppLang(context);
  if (value == null || value.isEmpty) {
    return local.fillFields;
  }else if(value.length < 4){
       return local.fourDigit;
  }else if(num.tryParse(value) == null){
    return local.numberRequired;
  }
  return null;
}
