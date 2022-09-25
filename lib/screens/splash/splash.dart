

import 'dart:async';

import 'package:agent/config/shared_preference.dart';
import 'package:agent/config/utils.dart';
import 'package:agent/resources/colors.dart';
import 'package:agent/resources/constants.dart';
import 'package:agent/resources/styles.dart';
import 'package:agent/screens/splash/widget/company_logo.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController rotationController;

  @override
  void initState() {

    rotationController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    rotationController.forward(from: 0.0);
    startTimer();

    super.initState();
  }

  startTimer() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, route);
  }

  route() {
    final compId = Prefs.getString(companyId) ?? '';

    if(compId == ''){
      Navigator.pushReplacementNamed(context, companyRoute );
    }else{
      Navigator.pushReplacementNamed(context, agentOnlineRoute );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool lightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    final compId = Prefs.getString(companyId) ?? '';

    return Scaffold(
      backgroundColor: secondWhite,
    //  lightMode ? const Color(0xffe1f5fe) : const Color(0xff042a49),
      body: Container(
        margin: EdgeInsets.only(top: getScreenHeight(context) * .4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //company logo

            compId != '' ?   CompanyLogo(
              size: getScreenWidth(context) * .4,
            ): Container(),
            //footer
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(bottom: 20),
              child: Text('Next Evolution © 2022',
                  style: companyText.copyWith(
                    //getAdaptiveTextSize(context, 25)
                    //aspectRatio * 35,
                  )),
            ),

          ],
        ),
      ),
    );
  }
}


