class Customer {
  final String name;
  final String tel;
  Customer({required this.name, required this.tel});
  factory Customer.fromJson(Map<dynamic, dynamic> parsedJson) {
    return Customer(
      name: parsedJson['name'],
      tel: parsedJson['tel'],
    );
  }
}
