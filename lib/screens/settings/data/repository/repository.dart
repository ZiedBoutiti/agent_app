


enum PasswordResult {success, failed , same}

abstract class Repository {
  late Future<PasswordResult> _future;
  Future<PasswordResult> updatePassword({required int oldPassword, required int newPassword}) {
    return _future;
  }
}