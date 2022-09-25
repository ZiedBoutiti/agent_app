import 'package:agent/config/utils.dart';
import 'package:agent/screens/common_widgets/stream_messages.dart';
import 'package:agent/screens/tasks/common_utils.dart';
import 'package:agent/screens/tasks/data/models/agent_order.dart';
import 'package:agent/screens/tasks/data/models/order.dart';
import 'package:agent/screens/tasks/data/repository/tasks_repository.dart';
import 'package:agent/screens/tasks/presentation/widgets/order_details.dart';
import 'package:agent/screens/tasks/domain/notifier/task_notifier.dart';
import 'package:agent/screens/tasks/presentation/widgets/task_table.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tasks extends StatelessWidget {
  const Tasks({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final TasksRepository _taskRepository = TasksRepository();

    final tasksRead = context.read<TaskProvider>();

    ///get language
    var local = getAppLang(context);

    StreamLoading _streamLoading = StreamLoading();

    return StreamBuilder<DatabaseEvent>(
        stream: _taskRepository.getTodayOrders(), //tasksWatch.stream
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
              case ConnectionState.active:
                if (snapshot.data!.snapshot.value == null) {
                  children = <Widget>[
                    Container(
                        margin: EdgeInsets.symmetric(
                          vertical: getScreenHeight(context) / 3,
                        ),
                        alignment: Alignment.bottomCenter,
                        child: Text(local.orderNotFound)),
                  ];
                } else {
                  List<Map<String, Order>> orders = [];

                  final json =
                      snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

                  json.forEach((key, value) {
                    Map<String, Order> map = {};
                    Order order = Order.fromJson(value);
                    map.putIfAbsent(key, () => order);
                    orders.add(map);
                  });

                  final List<Map<String, AgentOrder>> agentOrders;
                  agentOrders = fetchListOrders(orders, context);

                  if (agentOrders.isEmpty) {
                    ///remove from detail
                    Future.delayed(Duration.zero, () async {
                      tasksRead.setClickedRow(
                          row: -1,
                          selectedOrder: OrderItem(
                              agentId: '',
                              status: '',
                              serviceId: '',
                              discountPercentage: 0,
                              price: 0.0,
                              qte: 0,
                              finalPrice: 0),
                          context: context,
                          customId: '',
                          invoice: '',
                          key: '',
                          itemKey: '');
                    });
                  }

                  children = <Widget>[
                    const OrderDetail(),
                    const SizedBox(
                      height: 30,
                    ),
                    TaskTable(orders: agentOrders //fetchListOrders(orders),
                        // listKeys: listKeys,
                        )
                  ];
                }
                break;
              case ConnectionState.done:
                children = <Widget>[
                  const SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(local.wait),
                  )
                ];
                break;
            }
          }
          return SingleChildScrollView(
            child: Column(
              children: children,
            ),
          );
        });
  }
}
