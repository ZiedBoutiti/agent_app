class Order {
  final String customerId;
  // final String date;
  final List<OrderItem> orderItems;
  final String cashierId;
  final dynamic invoiceNumber;
  // final String paymentMethodeId;
  final String time;
  final dynamic totalPrice;
   String date;

  Order({
    required this.customerId, //required this.date,
    required this.orderItems,
    required this.cashierId,
    required this.invoiceNumber,
    required this.time,
    required this.totalPrice,
    required this.date,
  });

  factory Order.fromJson(Map<dynamic, dynamic> parsedJson) {
    List<OrderItem> ordersItemList = [];
    if (parsedJson['orderItem'] != null) {
      var list = parsedJson['orderItem'] as List;

      ordersItemList = list.map((i) => OrderItem.fromJson(i)).toList();
    }

    return Order(
        customerId: parsedJson['customer_id'],
        orderItems: ordersItemList,
        cashierId: parsedJson['cashier_id'],
        totalPrice: parsedJson['totalPrice'],
        invoiceNumber: parsedJson['invoiceNumber'],
        time: parsedJson['timeOrder'],
        date: parsedJson['dateOrder'] ?? '');
  }

  ///set Date order
  set setDateOrder(String dateOrder) {
    date = dateOrder;
  }
}

class OrderItem {
  final String serviceId;
  final dynamic discountPercentage;
  final dynamic price;
  final dynamic finalPrice;
  final int qte;
  final String status;
  final String agentId;
  final String period;
  final String startAt;

  OrderItem({
    required this.agentId,
    required this.status,
    required this.serviceId,
    required this.discountPercentage,
    required this.price,
    required this.finalPrice,
    required this.qte,
    this.period = '',
    this.startAt = '',
  });

  String get startedTime {
    return startAt.substring(11, startAt.length);
  }

  factory OrderItem.fromJson(Map<dynamic, dynamic> parsedJson) {
    return OrderItem(
      serviceId: parsedJson["service_id"],
      discountPercentage: parsedJson['discount'],
      price: parsedJson['price'],
      finalPrice: parsedJson['final_price'] ?? 0,
      qte: parsedJson['qte'],
      status: parsedJson['status'] ?? '',
      agentId: parsedJson['agent_id'],
      period: parsedJson['period'] ?? '',
      startAt: parsedJson['start_at'] ?? '',
    );
  }
}
