

import 'package:agent/screens/tasks/data/models/order.dart';

class AgentOrder{
  final OrderItem orderItem;
  final String orderItemKey;
  final String customerID;
  final dynamic invoiceNumber;
  final String time;
  final String date;
  final String cashierId;

  AgentOrder( {required this.orderItem, required this.orderItemKey,required this.customerID,required this.invoiceNumber,
    required this.time,
    required this.date,
    required this.cashierId,
  });
}