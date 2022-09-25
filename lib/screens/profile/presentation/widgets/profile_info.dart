import 'package:agent/config/utils.dart';
import 'package:agent/resources/colors.dart';
import 'package:agent/resources/styles.dart';
import 'package:agent/screens/common_widgets/services_liste.dart';
import 'package:agent/screens/common_widgets/stream_messages.dart';
import 'package:agent/screens/login/data/models/agent_data.dart';
import 'package:agent/screens/profile/data/repository/profile_repository.dart';
import 'package:agent/screens/profile/domain/notifier/profile_notifier.dart';
import 'package:agent/screens/profile/presentation/widgets/agent_photo.dart';
import 'package:agent/screens/profile/presentation/widgets/all_totals.dart';
import 'package:agent/screens/profile/presentation/widgets/list_task_part.dart';
import 'package:agent/screens/profile/presentation/widgets/space_widget.dart';
import 'package:agent/screens/profile/presentation/widgets/switch_button.dart';
import 'package:agent/screens/profile/presentation/widgets/today_totals.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileWatch = context.watch<ProfileProvider>();

    StreamLoading _streamLoading = StreamLoading();

    final ProfileRepository _profileRepository = ProfileRepository();

    ///get language
    var local = getAppLang(context);

    return Container(
      margin: EdgeInsets.only(
          left: getScreenWidth(context) * .1,
          right: getScreenWidth(context) * .1,
          top: 10),
      child: ListView(
        shrinkWrap: true,
        children: [
          ///Agent picture
          const AgentPhoto(),

          ///Agent data [Name and services]
          FutureBuilder<DatabaseEvent>(
              future: _profileRepository.getAgentInfoById(),
              builder: (context, snapshot) {
                List<Widget> children = [];
                if (snapshot.hasError) {
                  children = _streamLoading.hasError(snapshot);
                } else {
                  if (!snapshot.hasData ||
                      snapshot.data!.snapshot.value == null) {
                    children = <Widget>[Text(local.noInfoFound)];
                  } else {
                    Agent agent;
                    Map<String, Agent> map =
                        getAgentDataInType(snapshot.data!.snapshot.value);
                    agent = map.values.single;

                    children = <Widget>[
                      ///Full name
                      Text(
                        agent.fullName.toUpperCase(),
                        style: nameProfile,
                        textAlign: TextAlign.center,
                      ),

                      ///Services
                      SizedBox(
                          height: 30,
                          child: ServicesList(const [], agent.serviceIds)),
                    ];
                  }
                }
                return Column(
                    // shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    children: children);
              }),

          ///Divider
          Container(
            height: 2,
            margin: EdgeInsets.only(
                top: 5, right: getScreenWidth(context) / 2 * .1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: secColor,
            ),
          ),

          ///TODAY TOTALS
          const TodayTotals(),

          const SizedBox(
            height: 10,
          ),

          ///Spacer
          SpaceWidget(
            height: 1,
            width: getScreenWidth(context) * .4 + 15,
            marginTop: 20,
          ),

          ///ALL TOTALS
          const AllTotals(),

          const SizedBox(
            height: 10,
          ),

          ///Switch button tasks
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                local.tasks,
                style:
                    nameProfile.copyWith(color: fieldTextColor, fontSize: 25),
                textAlign: profileWatch.locale.languageCode == 'en'
                    ? TextAlign.left
                    : TextAlign.right,
              ),
              const SwitchButton()
            ],
          ),

          ///TASKS PART [ALL or YEARLY]
          const ListTasksPart()

          // profileWatch.isSwitched == true
          //     ? const YearlyOrders() //const MonthlyOrders()
          //     : const TotalTasks()
        ],
      ),
    );

    //   ],
    //  );
  }
}
