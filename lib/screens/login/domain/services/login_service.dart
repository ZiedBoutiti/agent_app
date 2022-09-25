import 'dart:collection';

import 'package:agent/config/shared_preference.dart';
import 'package:agent/resources/constants.dart';
import 'package:firebase_database/firebase_database.dart';

class LoginService {
  FirebaseDatabase database = FirebaseDatabase.instance;

  ///subscription company
  DatabaseReference ref2 =
      FirebaseDatabase.instance.ref("Subscription/subscribers");

// Access a child of the current reference
//   late DatabaseReference child;
//
//   Stream<DatabaseEvent> getAgentInfoByPasswordDao(int password) {
//     final compId = Prefs.getString(companyId);
//
//     late DatabaseReference ref;
//     ref =  FirebaseDatabase.instance
//         .ref("company/$compId/users/agent");
//
//     // Get the Stream
//     Stream<DatabaseEvent> stream = ref.orderByChild('password').equalTo(password).onValue;
//     return stream;
//   }

  late DatabaseReference future;

  Future<DatabaseEvent> getAgentInfoByPasswordDaoFuture(int password) {
    final compId = Prefs.getString(companyId);
    Future<DatabaseEvent> future;
    try {
      late DatabaseReference ref;
      ref = FirebaseDatabase.instance.ref("company/$compId/users/agent");

      // Get the Stream
      future = ref.orderByChild('password').equalTo(password).once();
    } catch (e) {
      throw Exception(e);
    }
    return future;
  }


  Future<List<DatabaseEvent>> getAgentAllInfoByPasswordDaoFuture() async{
    final compId = Prefs.getString(companyId);
   // DatabaseEvent databaseEvent;
    List<DatabaseEvent> listDatabaseEvent = [];

    final listCodes = Prefs.getStringList(listAgentsCode);

    try {
      late DatabaseReference ref;
      ref = FirebaseDatabase.instance.ref("company/$compId/users/agent");
      for(int i =0; i<listCodes!.length; i++){
        DatabaseEvent databaseEvent = await ref.orderByChild('password').equalTo(int.parse(listCodes[i])).once();

       if(databaseEvent.snapshot.value != null) {
         print(databaseEvent);
         // Get the Stream
         listDatabaseEvent.add(databaseEvent);
       }
        // Agent agent;
        // Map<String, Agent> map =
        // getAgentDataInType(
        //   );
      }


    } catch (e) {
      throw Exception(e);
    }
    return listDatabaseEvent;
  }


//verification code company
  Future<DatabaseEvent> getCompanyInfoByCodeDao(int code) {
    Future<DatabaseEvent> future;
    try {
      future = ref2.orderByChild('code').equalTo(code).once();
    } catch (e) {
      throw Exception(e);
    }
    return future;
  }

  ///add login history
  Future<void> addLoginHistory(String type, String agentID) async {
    //set timestamp and retrieve it
    //https://stackoverflow.com/questions/43584244/how-to-save-the-current-date-time-when-i-add-new-value-to-firebase-realtime-data#:~:text=TIMESTAMP%20is%20just%20a%20token,after%20the%20write%20operation%20completes.&text=You%20can%20host%20this%20in,server%20timestamp%20without%20user%20interaction.
    final compId = Prefs.getString(companyId);
    try {
      late DatabaseReference ref;
      ref = FirebaseDatabase.instance.ref("company/$compId/users/agent");

      Map map = HashMap();
      map.putIfAbsent("date", () => ServerValue.timestamp);
      map.putIfAbsent("type", () => type);

      await ref.child(agentID).child('login_history').push().set(map);
    } catch (e) {
      throw Exception(e);
    }
  }

  ///Verification code
  Future<DatabaseEvent> codeVerification(int password) async {
    final compId = Prefs.getString(companyId);
    Future<DatabaseEvent> future;
    try {
      late DatabaseReference ref;
      ref = FirebaseDatabase.instance.ref("company/$compId/users/agent");

// Get the Future
      future = ref.orderByChild('password').equalTo(password).once();
    } catch (e) {
      throw Exception(e);
    }
    return future;
  }
}
