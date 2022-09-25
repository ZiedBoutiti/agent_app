import 'package:agent/config/utils.dart';
import 'package:agent/resources/colors.dart';
import 'package:agent/screens/monthly_orders/domain/monthly_service.dart';
import 'package:agent/screens/monthly_orders/domain/utils.dart';
import 'package:agent/screens/profile/domain/notifier/profile_notifier.dart';
import 'package:agent/screens/profile/presentation/widgets/output_decoration.dart';
import 'package:agent/screens/tasks/data/models/agent_order.dart';
import 'package:agent/screens/tasks/data/models/customer.dart';
import 'package:agent/screens/tasks/data/models/service.dart';
import 'package:agent/screens/tasks/data/repository/tasks_repository.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DayPanelWidget extends StatefulWidget {
  final List<Map<String, List<Map<String, AgentOrder>>>> orders;

  final String lang;

  const DayPanelWidget({Key? key, required this.orders, required this.lang})
      : super(key: key);

  @override
  State<DayPanelWidget> createState() => _DayPanelWidgetState();
}

class _DayPanelWidgetState extends State<DayPanelWidget> {
  List<Item> _data = [];

  @override
  void initState() {
    _data = generateItems(widget.orders, lang: widget.lang);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: PanelWidget(item: _data,),
    );
  }

  Widget data({
    required String title,
    required String info,
  }) {
    return OutputDecoration(
      horizontalTitle: 0,
      widget: Text(
        info,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
      title: title,
      borderWidth: 1,
    );
  }

  // Widget _buildPanel(BuildContext context) {
  //   ///get language
  //   var local = getAppLang(context);
  //
  //   final profileWatch = context.watch<ProfileProvider>();
  //
  //   TasksRepository _taskRepository = TasksRepository();
  //
  //   MonthlyService monthlyService = MonthlyService();
  //
  //   return ExpansionPanelList(
  //     expansionCallback: (int index, bool isExpanded) {
  //       setState(() {
  //         _data[index].isExpanded = !isExpanded;
  //       });
  //     },
  //     children: _data.map<ExpansionPanel>((Item item) {
  //       return
  //
  //
  //         ExpansionPanel(
  //         canTapOnHeader: true,
  //         headerBuilder: (BuildContext context, bool isExpanded) {
  //           return ListTile(
  //             title: Text(
  //               item.headerValueSec,
  //             ),
  //             subtitle: Text(
  //               item.headerValueFirst,
  //             ),
  //           );
  //         },
  //         body: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //           child: ListView.separated(
  //               shrinkWrap: true,
  //               itemCount: item.expandedValue.length,
  //               physics: const NeverScrollableScrollPhysics(),
  //               separatorBuilder: (context, index) {
  //                 return const Padding(
  //                   padding: EdgeInsets.symmetric(vertical: 8.0),
  //                   child: Divider(
  //                     color: disableColor,
  //                     thickness: 3,
  //                   ),
  //                 );
  //               },
  //               itemBuilder: (BuildContext context, int index) {
  //                 AgentOrder value = item.expandedValue[index].values.first;
  //
  //                 return Column(
  //                   children: [
  //                     ///INVOICE NUMBER
  //                     data(
  //                       title: local.invoiceNum,
  //                       info: value.invoiceNumber.toString(),
  //                     ),
  //                     const SizedBox(
  //                       width: 10,
  //                     ),
  //
  //                     ///ORDER TIME && WORK TIME && WORK PERIOD
  //                     Row(
  //                       children: [
  //                         Expanded(
  //                           child: data(
  //                               title: local.orderTime,
  //                               info: getTimeByLang(value.time,
  //                                   profileWatch.locale.languageCode)),
  //                         ),
  //                         const SizedBox(
  //                           width: 10,
  //                         ),
  //                         Expanded(
  //                           child: data(
  //                               title: local.initialWork,
  //                               info: getTimeByLang(value.orderItem.startedTime,
  //                                   profileWatch.locale.languageCode)),
  //                         ),
  //                         const SizedBox(
  //                           width: 10,
  //                         ),
  //                         Expanded(
  //                           child: data(
  //                             title: local.workPeriod,
  //                             info: value.orderItem.period.toString(),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //
  //                     ///Cashier && Customer
  //                     Row(
  //                       children: [
  //                         ///CASHIER
  //                         FutureBuilder<DatabaseEvent>(
  //                             future: monthlyService
  //                                 .getCashierInfo(value.cashierId),
  //                             builder: (context, snapshot) {
  //                               if (snapshot.hasData &&
  //                                   snapshot.data!.snapshot.value != null) {
  //                                 String name =
  //                                     '${snapshot.data!.snapshot.child('firstName').value.toString()} ${snapshot.data!.snapshot.child('lastName').value.toString()}';
  //
  //                                 return Expanded(
  //                                   child: data(
  //                                     title: local.cashierName,
  //                                     info: name.toUpperCase() == ''
  //                                         ? local.notFound.toUpperCase()
  //                                         : name.toUpperCase(),
  //                                   ),
  //                                 );
  //                               } else {
  //                                 return Expanded(
  //                                     child: data(
  //                                   title: local.cashierName,
  //                                   info: local.notFound.toUpperCase(),
  //                                 ));
  //                               }
  //                             }),
  //
  //                         const SizedBox(
  //                           width: 10,
  //                         ),
  //
  //                         ///CUSTOMER
  //                         FutureBuilder<DatabaseEvent>(
  //                             future: _taskRepository.getAgentCustomer(
  //                                 id: value.customerID),
  //                             builder: (context, snapshot) {
  //                               if (snapshot.hasData &&
  //                                   snapshot.data!.snapshot.value != null) {
  //                                 Customer customer;
  //
  //                                 final json = snapshot.data!.snapshot.value
  //                                     as Map<dynamic, dynamic>;
  //                                 customer =
  //                                     Customer.fromJson(json.values.single);
  //
  //                                 return Expanded(
  //                                   child: data(
  //                                     title: local.customerName,
  //                                     info: customer.name.toUpperCase() == ''
  //                                         ? local.notFound.toUpperCase()
  //                                         : customer.name.toUpperCase(),
  //                                   ),
  //                                 );
  //                               } else {
  //                                 return Expanded(
  //                                   child: data(
  //                                     title: local.customerName,
  //                                     info: local.notFound.toUpperCase(),
  //                                   ),
  //                                 );
  //                               }
  //                             }),
  //                       ],
  //                     ),
  //
  //                     /// Work
  //                     FutureBuilder<DatabaseEvent>(
  //                         future: _taskRepository.getAgentService(
  //                             id: value.orderItem.serviceId),
  //                         builder: (context, snapshot) {
  //                           if (snapshot.hasData &&
  //                               snapshot.data!.snapshot.value != null) {
  //                             Service service;
  //
  //                             final json = snapshot.data!.snapshot.value
  //                                 as Map<dynamic, dynamic>;
  //                             service = Service.fromJson(json.values.single);
  //
  //                             return data(
  //                               title: local.work,
  //                               info: getServiceName(
  //                                   profileWatch.locale.languageCode,
  //                                   service.nameEn.toUpperCase(),
  //                                   service.nameAr),
  //                             );
  //                           } else {
  //                             return data(
  //                               title: local.work,
  //                               info: local.notFound,
  //                             );
  //                           }
  //                         }),
  //
  //                     ///PRICE && DISCOUNT && FINAL PRICE
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Expanded(
  //                           child: data(
  //                             title: local.price,
  //                             info: value.orderItem.price
  //                                 .toStringAsFixed(1)
  //                                 .toString(),
  //                           ),
  //                         ),
  //                         const SizedBox(
  //                           width: 10,
  //                         ),
  //                         Expanded(
  //                           child: data(
  //                             title: local.discount,
  //                             info:
  //                                 value.orderItem.discountPercentage.toString(),
  //                           ),
  //                         ),
  //                         value.orderItem.finalPrice != 0
  //                             ? const SizedBox(
  //                                 width: 10,
  //                               )
  //                             : Container(),
  //                         value.orderItem.finalPrice != 0
  //                             ? Expanded(
  //                                 child: data(
  //                                   title: local.finalPrice,
  //                                   info: value.orderItem.finalPrice
  //                                       .toStringAsFixed(1)
  //                                       .toString(),
  //                                 ),
  //                               )
  //                             : Container()
  //                       ],
  //                     ),
  //                   ],
  //                 );
  //               }),
  //         ),
  //         isExpanded: item.isExpanded,
  //       );
  //     }).toList(),
  //   );
  //}
}

// stores ExpansionPanel state information
class Item {
  Item({
    required this.expandedValue,
    required this.headerValueFirst,
    required this.headerValueSec,
    this.isExpanded = false,
  });

  List<Map<String, AgentOrder>> expandedValue;
  String headerValueFirst;
  String headerValueSec;
  bool isExpanded;
}




///Item data
List<Item> generateItems(
    List<Map<String, List<Map<String, AgentOrder>>>> orders,
    {String lang = 'en'}) {
  return List<Item>.generate(orders.length, (int index) {
    return Item(
      headerValueFirst: getPeriod(
          currentDate: orders[index].keys.first, lang: lang, month: false),
      headerValueSec: getDayFromDate(currentDate: orders[index].keys.first),
      expandedValue: orders[index].values.first,
    );
  });
}


class PanelWidget extends StatefulWidget {
  final  List<Item> item;
  const PanelWidget({Key? key, required this.item}) : super(key: key);

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {

  final TasksRepository _taskRepository = TasksRepository();

  MonthlyService monthlyService = MonthlyService();

  Widget data({
    required String title,
    required String info,
  }) {
    return OutputDecoration(
      horizontalTitle: 0,
      widget: Text(
        info,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
      title: title,
      borderWidth: 1,
    );
  }

  @override
  Widget build(BuildContext context) {

    ///get language
    var local = getAppLang(context);

    final profileWatch = context.watch<ProfileProvider>();



    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          widget.item[index].isExpanded = !isExpanded;
        });
      },
      children: widget.item.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(
                item.headerValueSec,
              ),
              subtitle: Text(
                item.headerValueFirst,
              ),
            );
          },
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView.separated(
                shrinkWrap: true,
                itemCount: item.expandedValue.length,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Divider(
                      color: disableColor,
                      thickness: 3,
                    ),
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  AgentOrder value = item.expandedValue[index].values.first;

                  return Column(
                    children: [
                      ///INVOICE NUMBER
                     data(
                        title: local.invoiceNum,
                        info: value.invoiceNumber.toString(),
                      ),
                      const SizedBox(
                        width: 10,
                      ),

                      ///ORDER TIME && WORK TIME && WORK PERIOD
                      Row(
                        children: [
                          Expanded(
                            child: data(
                                title: local.orderTime,
                                info: getTimeByLang(value.time,
                                    profileWatch.locale.languageCode)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: data(
                                title: local.initialWork,
                                info: getTimeByLang(value.orderItem.startedTime,
                                    profileWatch.locale.languageCode)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: data(
                              title: local.workPeriod,
                              info: value.orderItem.period.toString(),
                            ),
                          ),
                        ],
                      ),

                      ///Cashier && Customer
                      Row(
                        children: [
                          ///CASHIER
                          FutureBuilder<DatabaseEvent>(
                              future: monthlyService
                                  .getCashierInfo(value.cashierId),
                              builder: (context, snapshot) {
                                if (snapshot.hasData &&
                                    snapshot.data!.snapshot.value != null) {
                                  String name =
                                      '${snapshot.data!.snapshot.child('firstName').value.toString()} ${snapshot.data!.snapshot.child('lastName').value.toString()}';

                                  return Expanded(
                                    child: data(
                                      title: local.cashierName,
                                      info: name.toUpperCase() == ''
                                          ? local.notFound.toUpperCase()
                                          : name.toUpperCase(),
                                    ),
                                  );
                                } else {
                                  return Expanded(
                                      child: data(
                                        title: local.cashierName,
                                        info: local.notFound.toUpperCase(),
                                      ));
                                }
                              }),

                          const SizedBox(
                            width: 10,
                          ),

                          ///CUSTOMER
                          FutureBuilder<DatabaseEvent>(
                              future: _taskRepository.getAgentCustomer(
                                  id: value.customerID),
                              builder: (context, snapshot) {
                                if (snapshot.hasData &&
                                    snapshot.data!.snapshot.value != null) {
                                  Customer customer;

                                  final json = snapshot.data!.snapshot.value
                                  as Map<dynamic, dynamic>;
                                  customer =
                                      Customer.fromJson(json.values.single);

                                  return Expanded(
                                    child: data(
                                      title: local.customerName,
                                      info: customer.name.toUpperCase() == ''
                                          ? local.notFound.toUpperCase()
                                          : customer.name.toUpperCase(),
                                    ),
                                  );
                                } else {
                                  return Expanded(
                                    child: data(
                                      title: local.customerName,
                                      info: local.notFound.toUpperCase(),
                                    ),
                                  );
                                }
                              }),
                        ],
                      ),

                      /// Work
                      FutureBuilder<DatabaseEvent>(
                          future: _taskRepository.getAgentService(
                              id: value.orderItem.serviceId),
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                snapshot.data!.snapshot.value != null) {
                              Service service;

                              final json = snapshot.data!.snapshot.value
                              as Map<dynamic, dynamic>;
                              service = Service.fromJson(json.values.single);

                              return data(
                                title: local.work,
                                info: getServiceName(
                                    profileWatch.locale.languageCode,
                                    service.nameEn.toUpperCase(),
                                    service.nameAr),
                              );
                            } else {
                              return data(
                                title: local.work,
                                info: local.notFound,
                              );
                            }
                          }),

                      ///PRICE && DISCOUNT && FINAL PRICE
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: data(
                              title: local.price,
                              info: value.orderItem.price
                                  .toStringAsFixed(1)
                                  .toString(),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: data(
                              title: local.discount,
                              info:
                              value.orderItem.discountPercentage.toString(),
                            ),
                          ),
                          value.orderItem.finalPrice != 0
                              ? const SizedBox(
                            width: 10,
                          )
                              : Container(),
                          value.orderItem.finalPrice != 0
                              ? Expanded(
                            child: data(
                              title: local.finalPrice,
                              info: value.orderItem.finalPrice
                                  .toStringAsFixed(1)
                                  .toString(),
                            ),
                          )
                              : Container()
                        ],
                      ),
                    ],
                  );
                }),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
