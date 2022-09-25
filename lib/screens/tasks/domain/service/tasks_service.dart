import 'dart:core';

import 'package:agent/config/shared_preference.dart';
import 'package:agent/resources/constants.dart';
import 'package:agent/screens/tasks/domain/utils/common.dart';
import 'package:firebase_database/firebase_database.dart';

class TasksService {
  ///get TODAY ORDERS
  Stream<DatabaseEvent> getTodayOrders() {
    String date = getFormattedDate();

    final compId = Prefs.getString(companyId);
    Stream<DatabaseEvent> stream;
    try {
      DatabaseReference orderRef =
          FirebaseDatabase.instance.ref("company/$compId/order/$date");
      stream = orderRef.orderByValue().onValue;
    } catch (e) {
      throw Exception(e);
    }
    return stream;
  }

  Future<DatabaseEvent> getServiceByIdDao(String id) {
    final compId = Prefs.getString(companyId);
    late Future<DatabaseEvent> future;
    try {
      // Get the Stream
      late DatabaseReference serviceRef =
          FirebaseDatabase.instance.ref("company/$compId/service");

      future = serviceRef.orderByKey().equalTo(id).once();
    } catch (e) {
      throw Exception(e);
    }
    return future;
  }

  Future<DatabaseEvent> getCustomerByIdDao(String id) {
    final compId = Prefs.getString(companyId);
    late Future<DatabaseEvent> future;
    try {
      // Get the Stream
      late DatabaseReference customerRef =
          FirebaseDatabase.instance.ref("company/$compId/customer");

      future = customerRef.orderByKey().equalTo(id).once();
    } catch (e) {
      throw Exception(e);
    }
    return future;
  }

  ///update status
  Future<void> updateOrderStatusDao(
      {required String status,
      required String orderID,
      required String orderItemID,
      String period = '',
      String startAt = ''}) async {
    final compId = Prefs.getString(companyId);
    String date = getFormattedDate();

    try {
      late DatabaseReference orderRef;
      orderRef = FirebaseDatabase.instance
          .ref("company/$compId/order/$date/$orderID/orderItem/$orderItemID");

      if (status == Status.started.name) {
        await orderRef.update({
          "status": status,
          "start_at": startAt,
        });
      } else {
        await orderRef.update({
          "status": status,
          "period": period,
        });
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  ///update period
  Future<void> updateOrderPeriodDao(
      {required String orderID,
      required String orderItemID,
      required String period}) async {
    try {
      final compId = Prefs.getString(companyId);
      String date = getFormattedDate();
//01032022
      late DatabaseReference orderRef;
      orderRef = FirebaseDatabase.instance
          .ref("company/$compId/order/$date/$orderID/orderItem/$orderItemID");

      await orderRef.update({
        "period": period,
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  ///get status
  Future<DatabaseEvent> getOrderDao(
      {required String orderID, required String orderItemID}) async {
    try {
      final compId = Prefs.getString(companyId);
      String date = getFormattedDate();
//01032022
      late DatabaseReference orderRef;
      orderRef = FirebaseDatabase.instance
          .ref("company/$compId/order/$date/$orderID/orderItem/$orderItemID");

      Future<DatabaseEvent> event;
      event = orderRef.once();
      return event;
    } catch (e) {
      throw Exception(e);
    }
  }
}
