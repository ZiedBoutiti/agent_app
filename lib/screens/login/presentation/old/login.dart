import 'package:agent/screens/login/presentation/old/mob_login.dart';
import 'package:agent/screens/login/presentation/old/tab_login.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
          return const TabLogin();
        }
        return const MobLogin();
      },
    );
  }
}
