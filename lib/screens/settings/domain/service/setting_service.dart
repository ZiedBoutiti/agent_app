
import 'package:agent/config/shared_preference.dart';
import 'package:agent/resources/constants.dart';
import 'package:agent/screens/settings/data/repository/repository.dart';
import 'package:firebase_database/firebase_database.dart';

class SettingService {
  Future<PasswordResult> updatePassword(
      {required int oldPassword, required int newPassword}) async {
    final compId = Prefs.getString(companyId);
    final ageId = Prefs.getString(agentId);


    PasswordResult result = PasswordResult.failed;

    late DatabaseEvent checkOldPassword;
    try {
      late DatabaseReference agentRef;

      agentRef =
          FirebaseDatabase.instance.ref("company/$compId/users/agent/$ageId");

      ///Check password
      checkOldPassword = await agentRef.once();

      final json = checkOldPassword.snapshot.value as Map<dynamic, dynamic>;

      if (oldPassword == json['password']) {
        if(oldPassword != newPassword) {
          await agentRef.update({
            "password": newPassword,
          }).then((value) => result = PasswordResult.success);
        }else{
          result = PasswordResult.same;
        }
      }else{

      }
    } catch (e) {
      throw Exception(e);
    }
    return result;
  }
}
