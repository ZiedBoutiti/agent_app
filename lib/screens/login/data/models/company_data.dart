class Company {
  final int code;
  final String companyId;

  Company({
    required this.code,
    required this.companyId,
  });

  factory Company.fromJson(Map<dynamic, dynamic> json) {
    return Company(
     code: json['code'],
      companyId: json['company_id'] ,
    );
  }

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'code': code,
        'company_id': companyId,
      };
}
