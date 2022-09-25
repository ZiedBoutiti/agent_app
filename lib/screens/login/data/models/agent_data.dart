class Agent {
  final String fullName;
  final int password;
  final String picture;
  final List<String> serviceIds;
  final String status;

  Agent({
    required this.fullName,
    required this.password,
    required this.picture,
    required this.serviceIds,
    required this.status,
  });

  factory Agent.fromJson(Map<dynamic, dynamic> json) {

    var servicesListFromJson = json['service_id'];
    List<String> servicesList =  List<String>.from(servicesListFromJson);

    return Agent(
        fullName: json['full_name'],
        password: json['password'],
        picture: json['picture'],
        status: json['status'],
        serviceIds: servicesList
    );
  }

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        // List<AgentService> servicesList = list.map((i) => AgentService.toJson(i)).toList();
        'full_name': fullName,
        'password': password,
        'picture': picture,
         'service_id': serviceIds,
        'status': status
      };
}


