import 'package:agent/config/shared_preference.dart';
import 'package:agent/resources/constants.dart';
import 'package:agent/screens/monthly_orders/domain/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class MonthlyService {
  ///get years in orders
  Future<DatabaseEvent> getYearsOrders() {
    final compId = Prefs.getString(companyId);
    Future<DatabaseEvent> future;
    try {
      DatabaseReference orderRef =
          FirebaseDatabase.instance.ref("company/$compId/order/");

      future = orderRef.orderByKey().once();
    } catch (e) {
      throw Exception(e);
    }
    return future;
  }

  ///get current Year Orders
  Future<DatabaseEvent> getMonthsOfYearOrdersKey(String year) {
    final compId = Prefs.getString(companyId);

    Future<DatabaseEvent> future;
    try {
      ///Next year
      DateTime dateTime = DateFormat("yyyy").parse(year);
      var date = DateTime(dateTime.year + 1);
      var _format = DateFormat('yyyy');
      var _nextFormatDate = _format.format(date);

      var startDate = getFormattedDate(currentDate: year);
      var endDate =
          getFormattedDate(currentDate: _nextFormatDate, endDate: true);

      DatabaseReference orderRef =
          FirebaseDatabase.instance.ref("company/$compId/order/");

      future = orderRef.orderByKey().startAt(startDate).endAt(endDate).once();
    } catch (e) {
      throw Exception(e);
    }
    return future;
  }

  ///Get orders by every Month
  Future<DatabaseEvent> getOrdersByMonthStream({required String date}) {
    final compId = Prefs.getString(companyId);
    
    ///get start month and end month
    Future<DatabaseEvent> future;
    try {
      var startDate = formattedStartEndDate(currentDate: date);
      var endDate = formattedStartEndDate(currentDate: date, endDate: true);

      ///Get Orders Path
      final _orderRef = FirebaseDatabase.instance
          .ref("company/$compId/order")
          .orderByKey()
          .startAt(startDate)
          .endAt(endDate);

      future = _orderRef.once();
    } catch (e) {
      throw Exception(e);
    }
    return future;
  }

  ///get Cashier name
  Future<DatabaseEvent> getCashierInfo(String cashierId) async {
    var companyID = Prefs.getString(companyId) ?? '';
    late DatabaseReference ref;
    ref = FirebaseDatabase.instance
        .ref("company/$companyID/users/cashier/$cashierId");
    Future<DatabaseEvent> future;
    try {
      future = ref.once();
    } catch (e) {
      throw Exception(e);
    }
    return future;
  }



  ///get current Year Orders
  Future<DatabaseEvent> getTotalIncomeInYear(String year) {
    final compId = Prefs.getString(companyId);

    Future<DatabaseEvent> future;
    try {
      ///Next year
      DateTime dateTime = DateFormat("yyyy").parse(year);
      var date = DateTime(dateTime.year + 1);
      var _format = DateFormat('yyyy');
      var _nextFormatDate = _format.format(date);

      var startDate = getFormattedDate(currentDate: year);
      var endDate =
      getFormattedDate(currentDate: _nextFormatDate, endDate: true);

      ///get total price value
      DatabaseReference orderRef =
      FirebaseDatabase.instance.ref("company/$compId/order/");
      future = orderRef.orderByChild('totalPrice').startAt(startDate).endAt(endDate).once();

    } catch (e) {
      throw Exception(e);
    }
    return future;
  }
}
