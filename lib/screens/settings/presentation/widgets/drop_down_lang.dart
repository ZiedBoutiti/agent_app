import 'package:agent/config/shared_preference.dart';
import 'package:agent/resources/colors.dart';
import 'package:agent/resources/constants.dart';
import 'package:agent/resources/styles.dart';
import 'package:agent/screens/profile/domain/notifier/profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DropDownLanguage extends StatelessWidget {
  const DropDownLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileRead = context.read<ProfileProvider>();
    final profileWatch = context.watch<ProfileProvider>();

    // ///get current language
    // Locale myLocale = Localizations.localeOf(context);

    List<String> locale = ['EN', 'AR'];

    List<Map<String, String>> languages = [
      {'EN': 'assets/british.svg'},
      {'ع': 'assets/kuwait.svg'},
    ];

    return DropdownButton<String>(
      iconEnabledColor: secColor,
      isExpanded: false,
      value: profileWatch.currentLang,
      underline: Container(),
      onChanged: (String? newValue) async {
        profileRead.setLocale(Locale(newValue!.toLowerCase(), ''), newValue);

        /// save language
        await Prefs.setString(language, profileWatch.locale.languageCode);

        // setState(() {
        //   dropdownValue = newValue;
        // });
      },
      items: locale.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: value == 'EN'
              ? LanguageTile(
                  title: languages[0].keys.single,
                  iconPath: languages[0].values.single,
                  showIcon: false,
                )
              : LanguageTile(
                  title: languages[1].keys.single,
                  iconPath: languages[1].values.single,
                  showIcon: false,
                ),

          // Text(
          //  value,
          //   style:nameProfile.copyWith(color: fieldTextColor, fontSize: 15),
          // ),
        );
      }).toList(),
    );
  }
}

class LanguageTile extends StatelessWidget {
  final String title;
  final String iconPath;
  final bool showIcon;
  const LanguageTile(
      {Key? key,
      required this.title,
      required this.iconPath,
      this.showIcon = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        showIcon
            ? const Icon(
                Icons.arrow_drop_down,
                color: secColor,
              )
            : Container(),
        Text(
          title,
          style: nameProfile.copyWith(color: secColor, fontSize: 15),
        ),
        const SizedBox(
          width: 5,
        ),
        SvgPicture.asset(
          iconPath,
          height: 20,
          //   width: 20,
        ),
      ],
    );
  }
}
