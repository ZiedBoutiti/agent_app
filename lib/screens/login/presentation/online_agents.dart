import 'package:agent/config/route_provider.dart';
import 'package:agent/config/shared_preference.dart';
import 'package:agent/config/utils.dart';
import 'package:agent/resources/colors.dart';
import 'package:agent/resources/constants.dart';
import 'package:agent/resources/styles.dart';
import 'package:agent/screens/common_widgets/basic_screen.dart';
import 'package:agent/screens/common_widgets/round_image.dart';
import 'package:agent/screens/common_widgets/stream_messages.dart';
import 'package:agent/screens/login/data/models/agent_data.dart';
import 'package:agent/screens/login/data/repository/login_repository.dart';
import 'package:agent/screens/login/domain/notifier/login_notifier.dart';
import 'package:agent/screens/tasks/data/models/order.dart';
import 'package:agent/screens/tasks/domain/notifier/task_notifier.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

//TODO localization
class AgentsOnline extends StatelessWidget {
  const AgentsOnline({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final LoginRepository _loginRepository = LoginRepository();
    final listCodes = Prefs.getStringList(listAgentsCode) ?? [];
    final login = context.read<LoginProvider>();
    final tasksRead = context.read<TaskProvider>();

    ///get language
    var local = getAppLang(context);

    final route = context.watch<RouteProvider>();

    StreamLoading _streamLoading = StreamLoading();

    // LoginService loginService = LoginService();

    return BasicScreen(
      title: local.agentOnline,
      showBack: false,
      showIcon: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: listCodes.isNotEmpty
            ? FutureBuilder<List<DatabaseEvent>>(
                future: _loginRepository.getAgentAllInfoByPasswords(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<DatabaseEvent>> snapshot) {
                  List<Widget> children = [];
                  if (snapshot.hasError) {
                    children = _streamLoading.hasError(snapshot);
                  } else {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        children = _streamLoading
                            .connectionStateNone(local.noConnection);

                        break;
                      case ConnectionState.waiting:
                        children =
                            _streamLoading.connectionStateWaiting(local.wait);

                        break;
                      case ConnectionState.done:
                        List<Map<String, Agent>> agent = [];
                        for (int i = 0; i < snapshot.data!.length; i++) {
                          Map<String, Agent> map = getAgentDataInType(
                              snapshot.data![i].snapshot.value);
                          agent.add(map);
                        }

                        // String key = map.keys.single;

                        agent.isNotEmpty
                            ? children = [
                                Expanded(
                                  child: GridView.builder(
                                      shrinkWrap: true,
                                      // physics:
                                      //     const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 200,
                                              childAspectRatio: 1,
                                              crossAxisSpacing: 20,
                                              mainAxisSpacing: 20),
                                      itemCount: agent.length + 1,
                                      itemBuilder: (BuildContext ctx, index) =>
                                          index == agent.length
                                              ? const AddNewAgent()
                                              : Container(
                                                  decoration: BoxDecoration(
                                                      color: primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  margin: const EdgeInsets.only(
                                                      left: 8, right: 8),
                                                  height: getValueForScreenType<
                                                      double>(
                                                    context: context,
                                                    mobile: getScreenHeight(
                                                            context) *
                                                        .3,
                                                    tablet: getScreenHeight(
                                                            context) *
                                                        .2,
                                                    desktop: getScreenHeight(
                                                            context) *
                                                        .2,
                                                  ),
                                                  width: getValueForScreenType<
                                                      double>(
                                                    context: context,
                                                    mobile: getScreenWidth(
                                                            context) *
                                                        .3,
                                                    tablet: getScreenWidth(
                                                            context) *
                                                        .2,
                                                    desktop: getScreenWidth(
                                                            context) *
                                                        .2,
                                                  ),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      tasksRead.setClickedRow(
                                                          row: -1,
                                                          selectedOrder: OrderItem(
                                                              agentId: '',
                                                              status: '',
                                                              serviceId: '',
                                                              discountPercentage:
                                                                  0,
                                                              price: 0.0,
                                                              qte: 0,
                                                              finalPrice: 0),
                                                          context: context,
                                                          customId: '',
                                                          invoice: '',
                                                          // Order(totalPrice: 0,//paymentMethodeId: '',
                                                          //  // agentId: '',
                                                          //   cashierId: '',
                                                          //   customerId: '', date: '', orderItems: [],),
                                                          key: '',
                                                          itemKey: '');

                                                      /// save agent ID
                                                      await Prefs.setString(
                                                          agentId,
                                                          agent[index]
                                                              .keys
                                                              .first //json.keys.first
                                                          );

                                                      ///save agent code
                                                      await Prefs.setString(
                                                          agentCodeSave,
                                                          agent[index]
                                                              .values
                                                              .first
                                                              .password
                                                              .toString()
                                                          //  listCodes[index]
                                                          );

                                                      ///set all today orders
                                                      //   tasksRead.setStream();

                                                      ///set app ROUTE
                                                      route.setCurrentPageIndex(
                                                          0);

                                                      ///set agent picture
                                                      login.setAgentPicture(
                                                          agent[index]
                                                              .values
                                                              .first
                                                              .picture);

                                                      ///navigate to Tasks Screen
                                                      Navigator
                                                          .pushReplacementNamed(
                                                              context,
                                                              bottomBarRoute);
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                              flex: 2,
                                                              child: RoundImage(
                                                                pictureUrl:
                                                                    agent[index]
                                                                        .values
                                                                        .first
                                                                        .picture,
                                                                sizeMob: 120,
                                                                sizeTab: 100,
                                                                borderColor: Colors
                                                                    .transparent,
                                                              )),
                                                          Expanded(
                                                              child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 8.0),
                                                            child: Text(
                                                              agent[index]
                                                                  .values
                                                                  .first
                                                                  .fullName
                                                                  .toUpperCase(),
                                                              style: bottomBarText
                                                                  .copyWith(
                                                                      fontSize:
                                                                          15),
                                                            ),
                                                          )),
                                                        ],
                                                      ),
                                                    ),
                                                  ))),
                                )
                              ]
                            : children = [const AddNewAgent()];
                        break;

                      case ConnectionState.active:
                        // TODO: Handle this case.
                        break;
                    }
                  }
                  return Column(
                    children: children,
                  );
                })
            : const AddNewAgent(),
      ),
    );
  }
}

class AddNewAgent extends StatelessWidget {
  const AddNewAgent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///get language
    var local = getAppLang(context);

    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8),
      height: getValueForScreenType<double>(
        context: context,
        mobile: getScreenHeight(context) * .2,
        tablet: getScreenHeight(context) * .2,
        desktop: getScreenHeight(context) * .2,
      ),
      width: getValueForScreenType<double>(
        context: context,
        mobile: getScreenWidth(context) * .3,
        tablet: getScreenWidth(context) * .2,
        desktop: getScreenWidth(context) * .2,
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, agentCodeRoute);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              local.addNewAgent,
              style: getValueForScreenType<TextStyle>(
                context: context,
                mobile: buttonText.copyWith(fontSize: 15),
                tablet: buttonText,
                desktop: buttonText,
              ),
              textAlign: TextAlign.center,
            ),
            Icon(
              Icons.add,
              size: getScreenWidth(context) * .1,
              color: secondColor,
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
          color: primaryColor, borderRadius: BorderRadius.circular(15)),
    );
  }
}
