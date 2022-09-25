import 'package:agent/config/shared_preference.dart';
import 'package:agent/config/utils.dart';
import 'package:agent/resources/colors.dart';
import 'package:agent/resources/constants.dart';
import 'package:agent/resources/styles.dart';
import 'package:agent/screens/common_widgets/basic_screen.dart';
import 'package:agent/screens/login/data/models/agent_data.dart';
import 'package:agent/screens/login/data/repository/login_repository.dart';
import 'package:agent/screens/profile/domain/notifier/profile_notifier.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class VerificationAgent extends StatelessWidget {
  VerificationAgent({Key? key}) : super(key: key);

  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final LoginRepository _loginRepository = LoginRepository();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    ///get language
    var local = getAppLang(context);

    final profileWatch = context.watch<ProfileProvider>();

    Widget? clearAll;

    return BasicScreen(
      title: local.agentCode,
      showBack: false,
      showIcon: false,
      body: Container(
        margin: EdgeInsets.only(
          top: getScreenHeight(context) * .2,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getScreenWidth(context) * .3 + 30,
            // vertical: getScreenHeight(context) * .1,
          ),
          child: Column(
            children: [
              TextField(
                maxLength: 4,
                cursorColor: primaryColor,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 35.0, color: primaryColor),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                  ),
                ),
                keyboardType: TextInputType.number,
                autofocus: true,
                showCursor: true,
                onChanged: (value) async {
                  if (value.length == 4) {
                    if (num.tryParse(value) != null) {
                      List<String> listAgentCodes = [];

                      ///TODO update agent status (absent/ present)

                      ///Check Code Verification
                      DatabaseEvent databaseEvent = await _loginRepository
                          .verifyCode(password: int.parse(value));

                      ///future data
                      if (databaseEvent.snapshot.value != null) {
                        Agent agent;
                        Map<String, Agent> map =
                            getAgentDataInType(databaseEvent.snapshot.value);
                        agent = map.values.single;

                        String key = map.keys.single;

                        ///set login history
                        _loginRepository.addLoginHistory(
                            type: 'sign in', agentID: key);

                        ///get Saved agents code list
                        final listCodes = Prefs.getStringList(listAgentsCode);

                        if (listCodes != null) {
                          listAgentCodes.addAll(
                              Prefs.getStringList(listAgentsCode)
                                  as List<String>);
                        }

                        ///add new agent code
                        ///check if agent code already saved in list
                        if (!listAgentCodes
                            .contains(agent.password.toString())) {
                          listAgentCodes.add(agent.password.toString());

                          ///save codes agent list
                          Prefs.setStringList(listAgentsCode, listAgentCodes);

                          Navigator.pushNamed(context, agentOnlineRoute);
                        } else {
                          closeKeyboard(context);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar(local.alreadyOnline));
                        }
                      } else {
                        closeKeyboard(context);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar(local.wrongCode));
                      }
                    } else {
                      closeKeyboard(context);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(snackBar(local.numberRequired));
                    }
                  }
                },
                controller: codeController,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GestureDetector(
                  onTap: () {
                    codeController.clear();
                  },
                  child: Text(local.clearAll, style: fieldText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
