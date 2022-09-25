

import 'package:agent/config/shared_preference.dart';
import 'package:agent/resources/constants.dart';
import 'package:firebase_database/firebase_database.dart';

class SplashService {
  var companyID = Prefs.getString(companyId) ?? '';

  ///get config method
  Future<DatabaseEvent> getCompanyConfig() async {
    Future<DatabaseEvent> future;
    try {
      ///GEt Config Path
      final _ref = FirebaseDatabase.instance.ref("company/$companyID/config");


      future = _ref.once();
    }catch(e){
      throw Exception(e);
    }

    return future;
  }
}
