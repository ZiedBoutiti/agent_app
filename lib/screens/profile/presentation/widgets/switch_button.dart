import 'package:agent/config/utils.dart';
import 'package:agent/resources/colors.dart';
import 'package:agent/resources/styles.dart';
import 'package:agent/screens/profile/domain/notifier/profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SwitchButton extends StatelessWidget {
  const SwitchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final profileWatch = context.watch<ProfileProvider>();
    final profileRead = context.read<ProfileProvider>();

    ///get language
    var local = getAppLang(context);

    return Row(
      children: [
        Text(
          local.yearly,
          style: serviceItem.copyWith(color: nameColor),
        ),
        Transform.scale(
            scale: 1,
            child: Switch(
              onChanged: profileRead.toggleSwitch,
              value: profileWatch.isSwitched,
              activeColor: secColor,
              activeTrackColor: secColor.withOpacity(0.5),
              inactiveThumbColor: nameColor,
              inactiveTrackColor: disableColor,
            )),
      ],
    );
  }
}