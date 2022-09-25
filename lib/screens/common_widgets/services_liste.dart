import 'package:agent/config/utils.dart';
import 'package:agent/resources/colors.dart';
import 'package:agent/screens/tasks/data/models/order.dart';
import 'package:agent/screens/tasks/data/models/service.dart';
import 'package:agent/screens/tasks/data/repository/tasks_repository.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

final TasksRepository _tasksRepository = TasksRepository();

///show finished tasks
class ServicesList extends StatelessWidget {
  final List<OrderItem> orderItems;
  final List<String> services;
  const ServicesList(this.orderItems, this.services, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> getListServicesIds() {
      List<String> listIds = [];
      if (services.isNotEmpty) {
        listIds.addAll(services);
      } else {
        for (OrderItem item in orderItems) {
          listIds.add(item.serviceId);
        }
      }
      return listIds;
    }

    ///get current language
    Locale myLocale = Localizations.localeOf(context);

    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: getListServicesIds().length,
        itemBuilder: (BuildContext context, int index) {
          return FutureBuilder<DatabaseEvent>(
              future: _tasksRepository.getAgentService(
                  id: getListServicesIds()[index]),
              builder: (BuildContext context,
                  AsyncSnapshot<DatabaseEvent> snapshot) {
                if (snapshot.data == null) {
                  return Container();
                } else if (snapshot.data!.snapshot.value != null) {
                  Service service;
                  final json =
                      snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                  service = Service.fromJson(json.values.single);
                  return

                      // profile == false
                      //   ? Text(
                      //       service.nameEn.toUpperCase(),
                      //       style: serviceItem,
                      //       overflow: TextOverflow.ellipsis,
                      //     )
                      //   :

                      Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Chip(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Colors.transparent, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: Text(
                        getServiceName(myLocale.languageCode, service.nameEn,
                            service.nameAr),
                        style: const TextStyle(
                          color: fieldTextColor,
                        ),
                      ),
                      backgroundColor: Colors.grey[80],
                      shadowColor: Colors.grey[60],
                    ),
                  );
                } else {
                  return Container();
                }
              });
        });
  }
}
