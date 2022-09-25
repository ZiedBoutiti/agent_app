import 'package:agent/config/shared_preference.dart';
import 'package:agent/resources/constants.dart';
import 'package:agent/screens/monthly_orders/domain/notifier/month_notifier.dart';
import 'package:agent/screens/monthly_orders/domain/utils.dart';
import 'package:agent/screens/profile/domain/notifier/profile_notifier.dart';
import 'package:agent/screens/tasks/data/models/agent_order.dart';
import 'package:agent/screens/tasks/data/models/order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const String loginTitle = 'Login';

String setCapitalize(String name) {
  name = name[0].toUpperCase() + name.substring(1).toLowerCase();
  return name;
}

///TODO get orders here [one month order,monthly order,yearly]
///All orders
List<Map<String, Order>> getAllOrder(Map<dynamic, dynamic> json) {
  List<Map<String, Order>> orders = [];

  json.forEach((globalKey, value) {
    final val = value as Map<dynamic, dynamic>;
    val.forEach((key, value) {
      Map<String, Order> map = {};
      Order order = Order.fromJson(value);

      if (order.date == '') {
        order.setDateOrder = getValidFormatDate(globalKey);
      }

      map.putIfAbsent(key, () => order);
      orders.add(map);
    });
  });

  return orders;
}

///get valid format date
String getValidFormatDate(String date) {
  String year = date.substring(0, 4);
  String month = date.substring(4, 6);
  String day = date.substring(6, date.length);

  // print('$month/$day/$year');

  return '$month/$day/$year';
}

///Orders per day
List<Map<String, List<Map<String, Order>>>> getDayOrders(
    Map<dynamic, dynamic> json) {
  ///Orders [key,values] (key = root)
  List<Map<String, List<Map<String, Order>>>> dayOrders = [];

  json.forEach((key, value) {
    ///Orders [values]
    List<Map<String, Order>> orders = [];

    ///get Orders [values]
    final val = value as Map<dynamic, dynamic>;

    ///set Orders [values] list
    val.forEach((key, value) {
      Map<String, Order> map = {};
      map.putIfAbsent(key, () => Order.fromJson(value));
      orders.add(map);
    });

    Map<String, List<Map<String, Order>>> map = {};

    map.putIfAbsent(key, () => orders);

    ///set Orders [key,values] (key = root) list
    dayOrders.add(map);
  });
  return dayOrders;
}

///Orders per month
List<String> getMonthOrders(
    {required Map<dynamic, dynamic> json, required BuildContext context}) {
  ///get orders list
  List<Map<String, Order>> orders = [];
  orders.addAll(getAllOrder(json));

  ///get agent orders
  List<Map<String, AgentOrder>> agentOrders =
      fetchListOrders(orders, context, finished: true);

  ///get list of months name
  List<String> months = [];
  months = getMonthFromDate(json);

  ///list of months has orders
  List<String> workedOrders = [];

  ///months with orders
  List<Map<String, List<Map<String, AgentOrder>>>> monthsOrders = [];

  if (agentOrders.isNotEmpty) {
    ///get first date time to compare the difference
    String first = agentOrders[0].values.first.date;

    for (String month in months) {
      List<Map<String, AgentOrder>> list = [];

      Map<String, List<Map<String, AgentOrder>>> map = {};

      String key = month.substring(4, 6);

      for (Map<String, AgentOrder> agentOrder in agentOrders) {

        String date = agentOrder.values.first.date
                    .substring(0, agentOrder.values.first.date.indexOf('/'))
                    .length ==
                1
            ? '0${agentOrder.values.first.date.substring(0, agentOrder.values.first.date.indexOf('/'))}'
            : agentOrder.values.first.date.substring(0, agentOrder.values.first.date.indexOf('/'));

        if (date == month.substring(4, 6)) {
          list.add(agentOrder);
        } else {
          first = agentOrder.values.first.date;
        }
      }

      if (list.isNotEmpty) {
        map.putIfAbsent(key, () => list);
      }
      if (map.isNotEmpty) {
        monthsOrders.add(map);
      }
    }
  }

  ///get only months have agent orders
  for (int i = 0; i < monthsOrders.length; i++) {
    workedOrders.add(months
        .where(
            (element) => element.substring(4, 6) == monthsOrders[i].keys.first)
        .first);
  }

  return workedOrders;
}

///get agent list orders
List<Map<String, AgentOrder>> fetchListOrders(
    List<Map<String, Order>> orders, BuildContext context,
    {bool finished = false, bool today = false}) {
  ///get agent ID
  String agId = Prefs.getString(agentId)!;
  final profileWatch = context.watch<ProfileProvider>();

  double prices = 0.0;

  List<Map<String, AgentOrder>> agentOrders = [];

  for (Map<String, Order> order in orders) {
    order.forEach((key, value) {
      for (int i = 0; i < value.orderItems.length; i++) {
        var item = value.orderItems[i];

        ///get all agent finished orders
        if (finished) {
          if (item.agentId == agId && item.status == Status.finished.name) {
            if (item.finalPrice == 0) {
              prices = prices + item.price;
            } else {
              prices = prices + item.finalPrice;
            }

            Map<String, AgentOrder> map = {};

            map.putIfAbsent(
                key,
                () => AgentOrder(
                    orderItem: item,
                    orderItemKey: i.toString(),
                    customerID: value.customerId,
                    invoiceNumber: value.invoiceNumber,
                    time: value.time,
                    date: value.date,
                    cashierId: value.cashierId));
            agentOrders.add(map);
          }
        }

        ///get all active agent orders
        else {
          if (item.agentId == agId && item.status != 'finished') {
            Map<String, AgentOrder> map = {};
            map.putIfAbsent(
                key,
                () => AgentOrder(
                    orderItem: item,
                    orderItemKey: i.toString(),
                    customerID: value.customerId,
                    invoiceNumber: value.invoiceNumber,
                    time: value.time,
                    date: value.date,
                    cashierId: value.cashierId));
            agentOrders.add(map);
          }
        }
      }
    });
  }

  if (finished) {
    ///order list by invoice number ascending
    agentOrders.sort((a, b) =>
        b.values.single.invoiceNumber.compareTo(a.values.single.invoiceNumber));

    ///set total order prices

    if (today) {
      profileWatch.setTotalTodayPrices(prices);
    } else {
      profileWatch.setTotalPrices(prices);
    }
  } else {
    ///order list by invoice number descending
    agentOrders.sort((b, a) =>
        b.values.single.invoiceNumber.compareTo(a.values.single.invoiceNumber));
  }

  return agentOrders;
}

///get agent list orders IN MONTH
List<Map<String, List<Map<String, AgentOrder>>>> fetchListOrdersInMonth(
    List<Map<String, List<Map<String, Order>>>> dayOrders,
    BuildContext context) {
  ///get agent ID
  String agId = Prefs.getString(agentId)!;

  final monthlyProvider = context.watch<MonthlyProvider>();

  ///Result
  List<Map<String, List<Map<String, AgentOrder>>>> agentDayOrders = [];

  double totalIncome = 0.0;

  ///Root [day order]
  for (Map<String, List<Map<String, Order>>> dayOrder in dayOrders) {
    ///Agent orders
    List<Map<String, AgentOrder>> _agentOrders = [];

    ///Orders [value day order]
    List<Map<String, Order>> orders = dayOrder.values.first;

    for (Map<String, Order> order in orders) {
      String key = order.keys.first;

      Order value = order.values.first;

      ///Each order [Map]
      //  print(key);
      // print(value.orderItems.length);

      ///Order items
      for (int i = 0; i < value.orderItems.length; i++) {
        var item = value.orderItems[i];

        ///get all agent finished orders
        if (item.agentId == agId && item.status == Status.finished.name) {
          if (item.finalPrice == 0) {
            totalIncome = totalIncome + item.price;
          } else {
            totalIncome = totalIncome + item.finalPrice;
          }

          Map<String, AgentOrder> map = {};

          map.putIfAbsent(
              key,
              () => AgentOrder(
                  orderItem: item,
                  orderItemKey: i.toString(),
                  customerID: value.customerId,
                  invoiceNumber: value.invoiceNumber,
                  time: value.time,
                  date: value.date,
                  cashierId: value.cashierId));

          ///add agent order in one day
          _agentOrders.add(map);
        }
      }
    }

    if (_agentOrders.isNotEmpty) {
      _agentOrders.sort((a, b) =>
          b.values.first.invoiceNumber.compareTo(a.values.first.invoiceNumber));

      Map<String, List<Map<String, AgentOrder>>> map = {};

      map.putIfAbsent(dayOrder.keys.first, () => _agentOrders);

      agentDayOrders.add(map);
    }
  }

  monthlyProvider.setTotalIncome(totalIncome);

  agentDayOrders.sort((a, b) => b.keys.first.compareTo(a.keys.first));

  return agentDayOrders;
}
