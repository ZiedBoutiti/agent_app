import 'dart:convert';

import 'package:agent/screens/login/data/models/agent_data.dart';
import 'package:agent/screens/login/data/repository/repository.dart';
import 'package:agent/screens/login/domain/services/login_service.dart';
import 'package:firebase_database/firebase_database.dart';

//TODO device token notification
//TODO automatic notification
class LoginRepository extends Repository {

  final LoginService _loginService = LoginService();

  // @override
  // Stream<DatabaseEvent> getAgentInfoByPassword({int? password})  {
  // final data = _loginService.getAgentInfoByPasswordDao(password!);
  //   return data;
  // }

  @override
  Future<DatabaseEvent> getAgentInfoByPassword({int? password})  {
  final data = _loginService.getAgentInfoByPasswordDaoFuture(password!);
    return data;
  }


  @override
  Future<List<DatabaseEvent>> getAgentAllInfoByPasswords()  {
    final data = _loginService.getAgentAllInfoByPasswordDaoFuture();
    return data;
  }



  @override
  Future<DatabaseEvent> getCompanyInfoByCode({int? code})  {
    final data = _loginService.getCompanyInfoByCodeDao(code!);
    return data;
  }

  @override
  Future<void> addLoginHistory({String? type,String? agentID}) async {
    await  _loginService.addLoginHistory( type!,agentID!);
  }

  @override
  Future<DatabaseEvent> verifyCode({int? password}) async {
   final data =  await  _loginService.codeVerification(password!);
    return data;
  }
}