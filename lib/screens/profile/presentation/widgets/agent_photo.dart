import 'package:agent/config/utils.dart';
import 'package:agent/screens/common_widgets/stream_messages.dart';
import 'package:agent/screens/profile/data/repository/profile_repository.dart';
import 'package:agent/screens/profile/presentation/widgets/photo_worker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AgentPhoto extends StatelessWidget {
  const AgentPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileRepository _profileRepository = ProfileRepository();

    StreamLoading _streamLoading = StreamLoading();

    ///get language
    var local = getAppLang(context);

    return StreamBuilder<DatabaseEvent>(
        stream: _profileRepository.getAgentPic(),
        builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
          List<Widget> children;
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
              case ConnectionState.active:
                children = <Widget>[
                  Center(
                      child: PhotoWorker(
                        picture: snapshot.data!.snapshot
                            .child('picture')
                            .value
                            .toString(),
                      )),
                ];
                break;
              case ConnectionState.done:
                children = <Widget>[
                  Center(
                      child: PhotoWorker(
                        picture: snapshot.data!.snapshot
                            .child('picture')
                            .value
                            .toString(),
                      )),
                ];
                break;
            }
          }
          return Stack(
            children: children,
          );
        });
  }
}