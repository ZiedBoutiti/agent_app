import 'package:agent/config/route_provider.dart';
import 'package:agent/config/utils.dart';
import 'package:agent/resources/colors.dart';
import 'package:agent/resources/styles.dart';
import 'package:agent/screens/common_widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BasicScreen extends StatelessWidget {
  const BasicScreen(
      {Key? key,
      required this.showIcon,
      required this.showBack,
      required this.title,
      required this.body})
      : super(key: key);

  final bool showIcon;
  final bool showBack;
  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final route = context.watch<RouteProvider>();
    var local = getAppLang(context);
    return Scaffold(
      appBar: AgentBar(
        context: context,
        title: title,
        showBack: showBack,
      ),
      // const DropDownLanguage(),

      body: body,
      bottomNavigationBar: showIcon == true
          ? Container(
              height: 90,
              decoration: const BoxDecoration(
                color: primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ///Tasks
                    BottomBarItem(
                      title: local.tasks,
                      activeIcon: Image.asset(
                        'assets/list_1.png',
                        color: secColor,
                      ),
                      disableIcon: Image.asset(
                        'assets/list.png',
                      ),
                      active: route.currentPageIndex == 0 ? true : false,
                      index: 0,
                    ),

                    ///Profile
                    BottomBarItem(
                      title: local.profile,
                      activeIcon: Image.asset(
                        'assets/user_1.png',
                        color: secColor,
                      ),
                      disableIcon: Image.asset('assets/user.png'),
                      active: route.currentPageIndex == 1 ? true : false,
                      index: 1,
                    ),

                    ///Settings
                    BottomBarItem(
                      title: local.setting,
                      activeIcon: Image.asset(
                        'assets/setting_1.png',
                        color: secColor,
                      ),
                      disableIcon: Image.asset('assets/setting.png'),
                      active: route.currentPageIndex == 2 ? true : false,
                      index: 2,
                    ),
                  ],
                ),
              ),
            )
          : Container(
              height: 90,
              decoration: const BoxDecoration(
                color: primaryColor,
              ),
            ),
    );
  }
}

class BottomBarItem extends StatelessWidget {
  final String title;
  final Widget disableIcon;
  final Widget activeIcon;
  final bool active;
  final int index;
  const BottomBarItem(
      {Key? key,
      required this.title,
      required this.active,
      required this.index,
      required this.disableIcon,
      required this.activeIcon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final route = context.read<RouteProvider>();

    return active
        ? Expanded(
            child: Column(
            children: [
              FittedBox(
                fit: BoxFit.contain,
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: Stack(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                            color: primaryColor, shape: BoxShape.circle),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: activeIcon,
                      ),
                    ],
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  title,
                  style: bottomBarText.copyWith(
                      fontWeight: FontWeight.bold, color: secColor),
                ),
              ),
            ],
          ))
        : Expanded(
            child: InkWell(
            onTap: () {
              route.setCurrentPageIndex(index);

              ///set all today orders
              //  tasksRead.setStream();
            },
            child: Column(
              children: [
                FittedBox(
                    fit: BoxFit.contain,
                    child: SizedBox(height: 40, width: 40, child: disableIcon)),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    title,
                    style: bottomBarText,
                  ),
                ),
              ],
            ),
          ));
  }
}
