

import 'package:agent/screens/settings/data/repository/repository.dart';
import 'package:agent/screens/settings/domain/service/setting_service.dart';

class SettingsRepository extends Repository {

  final SettingService _settingService = SettingService();

  @override
  Future<PasswordResult> updatePassword({required int oldPassword, required int newPassword})  {
         return _settingService.updatePassword(oldPassword: oldPassword, newPassword: newPassword);
  }


}