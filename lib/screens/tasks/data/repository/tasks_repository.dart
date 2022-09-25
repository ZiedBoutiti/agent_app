

import 'package:agent/screens/tasks/data/repository/repository.dart';
import 'package:agent/screens/tasks/domain/service/tasks_service.dart';
import 'package:firebase_database/firebase_database.dart';

class TasksRepository extends Repository{

  final TasksService _tasksService = TasksService();


  @override
  Stream<DatabaseEvent> getTodayOrders() {
    late Stream<DatabaseEvent> _streamOrders;
     _streamOrders = _tasksService.getTodayOrders();
    return _streamOrders;
  }


  @override
  Future<DatabaseEvent> getAgentService({String? id}) {
    late Future<DatabaseEvent> _futureService;
    _futureService = _tasksService.getServiceByIdDao(id!);
    return _futureService;
  }


  @override
  Future<DatabaseEvent> getAgentCustomer({String? id}) {
    late Future<DatabaseEvent> _futureCustomers;
    _futureCustomers = _tasksService.getCustomerByIdDao(id!);
    return _futureCustomers;
  }

  @override
  Future<void> updateOrderStatus({String? status,String? id, String? itemId,String? period,
    String? startAt
  }) async {
    _tasksService.updateOrderStatusDao(status: status!,orderID: id!,orderItemID: itemId!,
    period: period!,
      startAt: startAt!
    );
  }

  @override
  Future<void> updateOrderPeriod({String? id,String? itemId,String? period}) async {
    _tasksService.updateOrderPeriodDao(orderID: id!,orderItemID: itemId!,
        period: period!
    );

  }



  ///get Order
  @override
  Future<DatabaseEvent> getOrder({String? id,String? itemId}) async {
    return _tasksService.getOrderDao(orderID: id!, orderItemID: itemId!);
  }

}