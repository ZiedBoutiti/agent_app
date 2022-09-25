import 'package:agent/config/utils.dart';
import 'package:agent/resources/colors.dart';
import 'package:agent/resources/constants.dart';
import 'package:agent/resources/styles.dart';
import 'package:agent/screens/common_widgets/custom_button.dart';
import 'package:agent/screens/profile/domain/notifier/profile_notifier.dart';
import 'package:agent/screens/settings/domain/utils.dart';
import 'package:agent/screens/tasks/data/models/customer.dart';
import 'package:agent/screens/tasks/data/models/order.dart';
import 'package:agent/screens/tasks/data/models/service.dart';
import 'package:agent/screens/tasks/data/repository/tasks_repository.dart';
import 'package:agent/screens/tasks/domain/notifier/task_notifier.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

final TasksRepository _tasksRepository = TasksRepository();

class OrderDetail extends StatelessWidget {
  const OrderDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Locale myLocale = Localizations.localeOf(context);



    return Consumer<TaskProvider>(builder: (context, task, child) {
      if (task.clickedRow != -1) {
        return Container(
          height: getScreenHeight(context) * .3,
          margin: EdgeInsets.symmetric(
              horizontal: getValueForScreenType<double>(
            context: context,
            mobile: 8,
            tablet: 8,
            desktop: 8,
          )),
          decoration: BoxDecoration(border: Border.all(color: primaryColor)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      '#${task.invoiceNumber}',
                      style: fieldText,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),

              ///Counter
              const Counter(),

              const SizedBox(
                height: 20,
              ),

              ///service
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Center(
                      child: FutureBuilder<DatabaseEvent>(
                          future: _tasksRepository.getAgentService(
                              id: task.orderItem.serviceId),
                          builder: (BuildContext context,
                              AsyncSnapshot<DatabaseEvent> snapshot) {
                            if (snapshot.hasData) {
                              Service service;

                              final json = snapshot.data!.snapshot.value
                                  as Map<dynamic, dynamic>;
                              service = Service.fromJson(json.values.single);
                              return Text(
                                getServiceName(myLocale.languageCode,
                                    service.nameEn, service.nameAr),
                                overflow: TextOverflow.ellipsis,
                                style: fieldText,
                              );
                            } else {
                              return Container();
                            }
                          }),
                    )

                    //ServicesList(tasksWatch.orderItem,const [],true),
                    ),
              ),

              ///Customer
              task.customerId != ''
                  ? Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        //padding: const EdgeInsets.all(2.0),
                        child: FutureBuilder<DatabaseEvent>(
                            future: _tasksRepository.getAgentCustomer(
                                id: task.customerId),
                            builder: (BuildContext context,
                                AsyncSnapshot<DatabaseEvent> snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.data!.snapshot.value != null) {
                                Customer customer;
                                final json = snapshot.data!.snapshot.value
                                    as Map<dynamic, dynamic>;
                                customer =
                                    Customer.fromJson(json.values.single);
                                return Text(
                                  customer.name.toUpperCase(),
                                  style: bottomBarText.copyWith(
                                      color: fieldTextColor),
                                );
                              } else {
                                return Container();
                              }
                            }),
                      ),
                    )
                  : Container(),

              const Expanded(child: StatusButton()),
            ],
          ),
        );
      } else {
        return Container();
      }
    });
    // : Container();
  }
}

class Counter extends StatelessWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);

    return Consumer<TaskProvider>(builder: (context, task, child) {
      return Container(
        alignment: Alignment.center,
        margin: myLocale.languageCode == 'en'
            ? EdgeInsets.only(
                left: getScreenWidth(context) * .3 + 20,
              )
            : EdgeInsets.only(
                right: getScreenWidth(context) * .3 + 20,
              ),
        child: Row(
          children: [
            const Icon(Icons.alarm),
            //timelapse
            Text(
              ' ${task.hours}:${task.minutes}:${task.seconds}',
              style: fieldText,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
    });
  }
}

class StatusButton extends StatelessWidget {
  const StatusButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    final profileRead = context.read<ProfileProvider>();


    ///get language
    var local = getAppLang(context);


    return Consumer<TaskProvider>(builder: (context, task, child) {
      return SizedBox(
        height: 45,
        width: getScreenWidth(context) / 2 * .1,
        child: CustomButton(
          color: task.color,
          onPressed: () async {
            ///update task to started
            task.setWaiting(true);

            DatabaseEvent event = await _tasksRepository.getOrder(
                itemId: task.orderItemKey, id: task.orderKey);

            var json = event.snapshot.value as Map<dynamic, dynamic>;

            late OrderItem item;

            item = OrderItem.fromJson(json);
            if (item.status == Status.finished.name) {
              ///update task to started
              task.setWaiting(false);
            } else if (item.status == Status.created.name) {

              DateTime now = DateTime.now();
              String formattedDate =
                  DateFormat('yyyy-MM-dd hh:mm:ss a').format(now);

              final time = formattedDate;

              await _tasksRepository.updateOrderStatus(
                  status: Status.started.name,
                  id: task.orderKey,
                  itemId: task.orderItemKey,
                  period: '',
                  startAt: time);
              ///get stream again
              task.changeButtonState(Status.started.name, context);

              ///Show messages
              showMessage(
                local.startedMsg,
                context: context,
                  snackColor: primaryColor,
                  color: secondColor
              );
            }
            else if (item.status == Status.started.name) {
            ///switch to off list
              profileRead.toggleSwitch(false);

              await _tasksRepository.updateOrderStatus(
                  status: Status.finished.name,
                  id: task.orderKey,
                  itemId: task.orderItemKey,
                  period: task.periodOrder,
                  startAt: '');

              task.changeButtonState(Status.finished.name, context);

              ///Show messages
              showMessage(
                local.finishedMsg,
                context: context,
                snackColor: primaryColor,
                color: secondColor
              );
            }
          },
          isWaiting: task.wait,
          title: task.title,
          fontSizeTitle: 15,
          radius: 4.0,
        ),
      );
    });
  }
}
