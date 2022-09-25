import 'package:agent/config/utils.dart';
import 'package:agent/screens/tasks/data/models/service.dart';
import 'package:agent/screens/tasks/data/repository/tasks_repository.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ServiceWidget extends StatelessWidget {
  final String id;
  const ServiceWidget({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TasksRepository _tasksRepository = TasksRepository();
    Locale myLocale = Localizations.localeOf(context);

    return FutureBuilder<DatabaseEvent>(
        future: _tasksRepository.getAgentService(id: id),
        builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.hasData) {
            if(snapshot.data!.snapshot.value  != null) {
              Service service;

              final json = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
              service = Service.fromJson(json.values.single);
              return Text(
                getServiceName(myLocale.languageCode,
                    service.nameEn.toUpperCase(), service.nameAr),
                overflow: TextOverflow.ellipsis,
              );
            }else{
              return Container();
            }
          } else {
            return Container();
          }
        });
  }
}
