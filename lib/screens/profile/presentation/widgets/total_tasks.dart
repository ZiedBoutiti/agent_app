import 'package:agent/config/utils.dart';
import 'package:agent/screens/common_widgets/stream_messages.dart';
import 'package:agent/screens/profile/data/repository/profile_repository.dart';
import 'package:agent/screens/profile/domain/notifier/profile_notifier.dart';
import 'package:agent/screens/profile/presentation/widgets/list_orders.dart';
import 'package:agent/screens/profile/presentation/widgets/not_found.dart';
import 'package:agent/screens/tasks/common_utils.dart';
import 'package:agent/screens/tasks/data/models/agent_order.dart';
import 'package:agent/screens/tasks/data/models/order.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TotalTasks extends StatelessWidget {
  final Map<dynamic, dynamic> data;

  const TotalTasks({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, Order>> orders = getAllOrder(data);

    ///fetch order list by agent id
    List<Map<String, AgentOrder>> agentOrders =
        fetchListOrders(orders, context, finished: true);

    return agentOrders.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: ListOrders(
              orders: agentOrders,
            ),
          )
        : const NotFound();
  }
}
