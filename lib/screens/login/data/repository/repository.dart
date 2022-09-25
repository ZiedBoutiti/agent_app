

import 'package:firebase_database/firebase_database.dart';

abstract class Repository {

  // late Stream<DatabaseEvent> _stream;
  // Stream<DatabaseEvent> getAgentInfoByPassword({int? password}){
  //   return _stream;
  // }

  late Future<DatabaseEvent> _futureAgent;
  Future<DatabaseEvent> getAgentInfoByPassword({int? password}){
    return _futureAgent;
  }

  late Future<List<DatabaseEvent>> _futureAgents;
  Future<List<DatabaseEvent>> getAgentAllInfoByPasswords()  {
    return _futureAgents;
  }



  late Future<DatabaseEvent> _futureCompany;
  Future<DatabaseEvent> getCompanyInfoByCode({int? code}) {
    return _futureCompany;
  }

  Future<void> addLoginHistory({String? type,String? agentID}) async {}

  late Future<DatabaseEvent> _future;
  Future<DatabaseEvent> verifyCode({int? password}) async {
    return _future;
  }
}