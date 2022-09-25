import 'package:agent/config/utils.dart';
import 'package:agent/screens/common_widgets/stream_messages.dart';
import 'package:agent/screens/monthly_orders/presentation/yearly_orders.dart';
import 'package:agent/screens/profile/data/repository/profile_repository.dart';
import 'package:agent/screens/profile/domain/notifier/profile_notifier.dart';
import 'package:agent/screens/profile/presentation/widgets/not_found.dart';
import 'package:agent/screens/profile/presentation/widgets/total_tasks.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final ProfileRepository _profileRepository = ProfileRepository();

class ListTasksPart extends StatelessWidget {
  const ListTasksPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileWatch = context.watch<ProfileProvider>();

    StreamLoading _streamLoading = StreamLoading();

    ///get language
    var local = getAppLang(context);

    return FutureBuilder<DatabaseEvent>(
        future: _profileRepository.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
          List<Widget> children = [];
          if (snapshot.hasError) {
            children = _streamLoading.hasError(snapshot);
          } else {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                children =
                    _streamLoading.connectionStateNone(local.noConnection);

                break;
              case ConnectionState.waiting:
                children = _streamLoading.connectionStateWaiting(local.wait);

                break;

              case ConnectionState.done:
                if (snapshot.data!.snapshot.value == null) {
                  children = <Widget>[const NotFound()];
                } else {
                  final json =
                      snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

                  children = <Widget>[
                    ///SHOW data as list or filter by Yearly
                    profileWatch.isSwitched == true
                        ? YearlyOrders(
                            data: json,
                          )
                        : TotalTasks(
                            data: json,
                          )
                  ];
                }
                break;
              case ConnectionState.active:
                // TODO: Handle this case.
                break;
            }
          }
          return Stack(
            children: children,
          );
        });
  }
}
