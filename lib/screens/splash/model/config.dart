


class Config{
  final String address;
  final String currency;
  final String logo;
  final String name;

  Config({required this.address, required this.currency, required this.logo, required this.name});

  factory Config.fromJson(Map<dynamic, dynamic> json) {
    return Config(
      address: json['address'],
      currency: json['currency'] ,
      logo: json['logo'],
      name: json['name'],
    );
  }

}