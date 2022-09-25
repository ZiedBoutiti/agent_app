

import 'package:firebase_database/firebase_database.dart';

abstract class Repository {

  late Stream<DatabaseEvent> _streamOrders;
  Stream<DatabaseEvent> getTodayOrders() {
    return _streamOrders;
  }

  late Future<DatabaseEvent> _futureServices;
  Future<DatabaseEvent> getAgentService({String? id}) {
    return _futureServices;
  }


  late Future<DatabaseEvent> _futureCustomers;
  Future<DatabaseEvent> getAgentCustomer({String? id}) {
    return _futureCustomers;
  }

///Update Order status
  Future<void> updateOrderStatus({String? status,String? id,String? itemId,String? period,
  String? startAt
  }) async {}

  ///update Period
  Future<void> updateOrderPeriod({String? id,String? itemId,String? period}) async {}


  ///get Order status
  late Future<DatabaseEvent> _future;
  Future<DatabaseEvent> getOrder({String? id,String? itemId}) async {
    return _future;

  }
}