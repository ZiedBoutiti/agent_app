

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

abstract class Repository {

  late Future<DatabaseEvent> _future;
  Future<DatabaseEvent> getAgentInfoById(){
    return _future;
  }


  late Stream<DatabaseEvent> _stream;
  Stream<DatabaseEvent> getAgentPic(){
    return _stream;
  }

  late Future<firebase_storage.UploadTask?> _task;
  Future<firebase_storage.UploadTask?> uploadFileToFirebase({XFile? file}){
    return _task;
  }

  // late Stream<DatabaseEvent> _streamOrders;
  // Stream<DatabaseEvent> getAllOrders() {
  //   return _streamOrders;
  // }

  late Future<DatabaseEvent> _futureOrders;
  Future<DatabaseEvent> getAllOrders() {
    return _futureOrders;
  }

  late Future<DatabaseEvent> _futureTodayOrders;
  Future<DatabaseEvent> getTodayOrders() {
    return _futureTodayOrders;
  }

}