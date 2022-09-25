import 'package:agent/config/utils.dart';
import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  const NotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///get language
    var local = getAppLang(context);

    return Container(
        padding:  EdgeInsets.only(bottom: getScreenWidth(context) * .2,),
        alignment: Alignment.center,
        child: Text(local.noTasksFound));
  }
}