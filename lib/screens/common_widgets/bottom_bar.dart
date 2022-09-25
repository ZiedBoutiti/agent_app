import 'package:agent/config/route_provider.dart';
import 'package:agent/config/utils.dart';
import 'package:agent/resources/colors.dart';
import 'package:agent/resources/constants.dart';
import 'package:agent/resources/styles.dart';
import 'package:agent/screens/common_widgets/app_bar.dart';
import 'package:agent/screens/profile/presentation/profile.dart';
import 'package:agent/screens/settings/presentation/settings.dart';
import 'package:agent/screens/tasks/presentation/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
//argumentData: ArgumentData(name: 'amina'),
  static final List<BottomBarInfo> _pages = <BottomBarInfo>[
    BottomBarInfo(title: tasks, widget: const Tasks()),
    BottomBarInfo(title: profile, widget: const Profile()),
    BottomBarInfo(title: setting, widget: const Settings()),
  ];

  @override
  Widget build(BuildContext context) {
    ///Hide Bottom Bar (android & ios )

    final route = context.watch<RouteProvider>();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    ///get language
    var local = getAppLang(context);

    String getTile() {
      if (route.currentPageIndex == 0) {
        return local.tasks;
      } else if (route.currentPageIndex == 1) {
        return local.profile;
      } else {
        return local.setting;
      }
    }

    return Scaffold(
      backgroundColor: secondColor,
      appBar: AgentBar(
        // color: route.currentPageIndex != 0 ? Colors.transparent : secondColor,
        title: getTile(), //_pages.elementAt(route.currentPageIndex).title,
        // size: getScreenHeight(context) * .1 +20,
        context: context,
        showBack: false,
      ),
      body: _pages.elementAt(route.currentPageIndex).widget,
      bottomNavigationBar: Container(
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
          )),
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

class BottomBarInfo {
  final String title;
  final Widget widget;
  BottomBarInfo({required this.title, required this.widget});
}
// icon: Icon(Icons.call),
// label: 'Calls',
