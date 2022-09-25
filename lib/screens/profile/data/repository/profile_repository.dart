import 'package:agent/screens/profile/data/repository/repository.dart';
import 'package:agent/screens/profile/domain/service/profile_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class ProfileRepository extends Repository {
  final ProfileService _profileService = ProfileService();

  @override
  Future<DatabaseEvent> getAgentInfoById() {
    final data = _profileService.getAgentInfoByIdDao();
    return data;
  }

  @override
  Stream<DatabaseEvent> getAgentPic() {
    final data = _profileService.getAgentPic();
    return data;
  }

  @override
  Future<firebase_storage.UploadTask?> uploadFileToFirebase({XFile? file}) {
    final _task = _profileService.uploadFile(file);
    return _task;
  }

  @override
  Future<DatabaseEvent> getAllOrders() {
    late Future<DatabaseEvent> _futureOrders;
    _futureOrders = _profileService.getAllOrders();
    return _futureOrders;
  }

  @override
  Future<DatabaseEvent> getTodayOrders() {
    late Future<DatabaseEvent> _futureOrders;
    _futureOrders = _profileService.getTodayOrders();
    return _futureOrders;
  }
}
