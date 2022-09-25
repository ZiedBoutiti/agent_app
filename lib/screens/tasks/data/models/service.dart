class Service {
  final String categoryId;
  final String icon;
  final bool isService;
  final String nameAr;
  final String nameEn;
  final dynamic price;
  final int quantity;

  Service(
      {required this.categoryId,
      required this.icon,
      required this.isService,
      required this.nameAr,
      required this.nameEn,
      required this.price,
      required this.quantity});

  factory Service.fromJson(Map<dynamic, dynamic> parsedJson) {
    return Service(
      categoryId: parsedJson['category_id'],
      icon: parsedJson['icon'],
      isService: parsedJson['is_service'],
      nameAr: parsedJson['name_ar'],
      nameEn: parsedJson['name_en'],
      price: parsedJson['price'],
      quantity: parsedJson['quantity'],
    );
  }
}
