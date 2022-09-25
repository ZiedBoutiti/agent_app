import 'package:agent/screens/profile/data/repository/profile_repository.dart';
import 'package:agent/screens/profile/domain/notifier/profile_notifier.dart';
import 'package:agent/screens/profile/presentation/widgets/total_text.dart';
import 'package:agent/screens/tasks/common_utils.dart';
import 'package:agent/screens/tasks/data/models/agent_order.dart';
import 'package:agent/screens/tasks/data/models/order.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///TODAY TOTALS
class TodayTotals extends StatelessWidget {
  const TodayTotals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileRepository = ProfileRepository();
    final profileWatch = context.watch<ProfileProvider>();

    return FutureBuilder<DatabaseEvent>(
        future: profileRepository.getTodayOrders(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return const TotalText(
              price: 0.0,
              count: 0,
              todayTotal: true,
            );
          } else {
            List<Map<String, Order>> orders = [];

            final json = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

            json.forEach((key, value) {
              final val = value as Map<dynamic, dynamic>;
              val.forEach((key, value) {
                Map<String, Order> map = {};
                map.putIfAbsent(key, () => Order.fromJson(value));
                orders.add(map);
              });
            });

            ///fetch order list by agent id
            List<Map<String, AgentOrder>> agentOrders =
            fetchListOrders(orders, context, finished: true, today: true);

            return TotalText(
              price: profileWatch.totalTodayPrice,
              count: agentOrders.length,
              todayTotal: true,
            );
          }
        });
  }
}