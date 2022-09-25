import 'package:agent/config/route_provider.dart';
import 'package:agent/config/utils.dart';
import 'package:agent/resources/colors.dart';
import 'package:agent/resources/constants.dart';
import 'package:agent/resources/styles.dart';
import 'package:agent/screens/login/domain/notifier/login_notifier.dart';
import 'package:agent/screens/settings/presentation/widgets/drop_down_lang.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AgentBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool showBack;
  final Color color;
  //final double size;
  final BuildContext context;
  AgentBar(
      {Key? key,
      required this.title,
      required this.showBack,
      this.color = secColor,
      required this.context
      //required this.size,
      })
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(getValueForScreenType<double>(
        context: context,
        mobile: getScreenHeight(context) * .1 + 10,
        tablet: getScreenHeight(context) * .1 + 20,
        desktop: getScreenHeight(context) * .1 + 30,
      ));

  @override
  Widget build(BuildContext context) {
    ///get language
    var local = getAppLang(context);

    // 1.0 means normal animation speed.
    //control app animation
    //  timeDilation = 0.5;
    var agentOnline = AppLocalizations.of(context)?.agentOnline;

    final route = context.watch<RouteProvider>();
    final login = context.watch<LoginProvider>();

    return
        //title == local.companyCode || title == local.agentCode || title == local.agentOnline
        title != local.tasks && title != local.profile && title != local.setting
            ? Container(

                // color: Colors.green,
                // margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: AppBar(
                    backgroundColor: primaryColor,
                    elevation: 0,
                    // centerTitle: true,
                    title: Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: Text(
                        title,
                        style: sAppBarTitle.copyWith(
                          fontSize: getValueForScreenType<double>(
                            context: context,
                            mobile: 30,
                            tablet: 40,
                            desktop: 50,
                          ),
                        ),
                      ),
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: const DropDownLanguage(),
                      )
                    ],
                    leading: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: showBack
                          ? IconButton(
                              color: secColor,
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                // color: //route.currentPageIndex == 0 ?
                                //     primaryColor,
                                //    : secondColor,
                              ))
                          : Container(),
                    )))
            : Container(
                // margin: const EdgeInsets.only(top: 40, left: 10, right: 10),
                child: AppBar(
                  backgroundColor: primaryColor,
                  elevation: 0,
                  // centerTitle: true,
                  title: Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Text(
                      title,
                      style: route.currentPageIndex != 0
                          ? sAppBarTitle.copyWith(color: secColor)
                          : sAppBarTitle,
                    ),
                  ),
                  leading: route.currentPageIndex == 0 || showBack
                      ? IconButton(
                          onPressed: () {
                            if (route.currentPageIndex == 0) {
                              ///navigate to Tasks Screen
                              Navigator.pushReplacementNamed(
                                  context, agentOnlineRoute);
                            } else {
                              Navigator.of(context).pop(true);
                            }
                          },
                          icon: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: secColor,
                              // color: //route.currentPageIndex == 0 ?
                              //     primaryColor,
                              //    : secondColor,
                            ),
                          ))
                      : Container(),

                  ///////////////Floating Button///////////////
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: const DropDownLanguage(),
                    ),
                  ],
                ),
              ); // Your custom widget implementation.
  }
}
