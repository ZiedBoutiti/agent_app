import 'package:agent/config/utils.dart';
import 'package:agent/resources/colors.dart';
import 'package:agent/resources/constants.dart';
import 'package:agent/resources/styles.dart';
import 'package:agent/screens/common_widgets/service_widget.dart';
import 'package:agent/screens/tasks/data/models/agent_order.dart';
import 'package:agent/screens/tasks/data/models/order.dart';
import 'package:agent/screens/tasks/data/repository/tasks_repository.dart';
import 'package:agent/screens/tasks/domain/notifier/task_notifier.dart';
import 'package:agent/screens/tasks/domain/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TaskTable extends StatelessWidget {
  //final List<Order> orders;
  final List<Map<String, AgentOrder>> orders;
  //final List<String> listKeys;
  const TaskTable({
    Key? key,
    required this.orders, //required this.listKeys
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasksRead = context.read<TaskProvider>();

    ///get language
    var local = getAppLang(context);

    TasksRepository tasksRepository = TasksRepository();

    return orders.isNotEmpty
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                showCheckboxColumn: false,
                showBottomBorder: true,
                dividerThickness: 2.0,

                // border: TableBorder.all(
                //  width: 5.0,
                //  color: selectedRowColor,),
                columns: <DataColumn>[
                  DataColumn(
                    //tooltip
                    label: Text(
                      local.order,
                      style: serviceItem,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      local.service,
                      style: serviceItem,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      local.status,
                      style: serviceItem,
                    ),
                  ),
                ],
                rows: List<DataRow>.generate(orders.length, (int index) {
                  OrderItem order = orders[index].values.single.orderItem;
                  final tasksWatch = context.watch<TaskProvider>();

                  // tasksRead.setButtonColor(order.status);
                  // tasksRead.setTitle(order.status);

                  return DataRow(
                      color: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (tasksWatch.clickedRow != -1) {
                            if (tasksWatch.clickedRow == index) {
                              return selectedRowColor;
                            }
                          }
                          return secondColor;
                        },
                      ),
                      onSelectChanged: (selected) async {
                        ///TODO

                        // if(tasksWatch.clickedRow != -1) {
                        //   print('yes');
                        //   if (index != tasksWatch.clickedRow &&
                        //       tasksWatch.orderItem.status ==
                        //           Status.started.name
                        //
                        //   ) {
                        //     print('yeahhhh');
                        //  await   tasksRepository.updateOrderPeriod(
                        //         id: tasksWatch.orderKey,
                        //         itemId: tasksWatch.orderItemKey,
                        //         period: tasksWatch.periodOrder
                        //     );
                        //   }
                        // }

                        //   tasksRead.resetTimer();

                        tasksRead.setClickedRow(
                          row: index,
                          selectedOrder: order,
                          key: orders[index].keys.single,
                          itemKey: orders[index].values.single.orderItemKey,
                          context: context,
                          customId: orders[index].values.single.customerID,
                          invoice: orders[index]
                              .values
                              .single
                              .invoiceNumber
                              .toString(),

                          //index.toString()//listKeys[index]
                        );
                      },
                      // onLongPress: (){
                      //   print(index);
                      // },
                      cells: <DataCell>[
                        DataCell(
                          SizedBox(
                              width: getValueForScreenType<double>(
                                context: context,
                                mobile: 20,
                                tablet: 20,
                                desktop: 20,
                              ),
                              child: Text(
                                orders[index]
                                    .values
                                    .single
                                    .invoiceNumber
                                    .toString(),
                                overflow: TextOverflow.ellipsis,
                              )),
                        ),
                        //${orders[index].customerId}
                        DataCell(
                          //   Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // children: [
                          ///Show Order Services
                          //ServicesList(orderItems: orders[index].orderItems,),
                          SizedBox(
                              width: getValueForScreenType<double>(
                                context: context,
                                mobile: 100,
                                tablet: 100,
                                desktop: 100,
                              ),
                              child: ServiceWidget(
                                id: order.serviceId,
                              )),

                          ///Show Order customer
                          // StreamBuilder<DatabaseEvent>(
                          //     stream: _tasksRepository.getAgentCustomer(
                          //         id: orders[index].customerId),
                          //     builder: (BuildContext context,
                          //         AsyncSnapshot<DatabaseEvent> snapshot) {
                          //       if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                          //         Customer customer;
                          //
                          //         final json = snapshot.data!.snapshot.value
                          //             as Map<dynamic, dynamic>;
                          //         customer =
                          //             Customer.fromJson(json.values.single);
                          //         return Text(customer.name);
                          //       } else {
                          //         return Container();
                          //       }
                          //     }),
                          //   ],
                          // )
                        ),

                        ///Show Order status
                        DataCell(
                          Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 2,
                              ),
                              width: 70,
                              color: getStatusColor(
                                  order.status) //tasksWatch.color,
                              ),
                        )
                      ]);
                })),
          )
        : Container(
            margin: EdgeInsets.only(top: getScreenHeight(context) / 3),
            child: Center(
              child: Text(local.orderNotFound),
            ),
          );
  }
}
