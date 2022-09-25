import 'package:agent/config/shared_preference.dart';
import 'package:agent/config/string_extensions.dart';
import 'package:agent/config/utils.dart';
import 'package:agent/resources/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class ProfileService {


  Future<DatabaseEvent> getAgentInfoByIdDao() {
    Future<DatabaseEvent> future;
    try {
      var agId = Prefs.getString(agentId)!;
      final compId = Prefs.getString(companyId);
      // Get the Stream
      late DatabaseReference ref;
      ref = FirebaseDatabase.instance.ref("company/$compId/users/agent");
      future = ref.orderByKey().equalTo(agId).once();
    } catch (e) {
      throw Exception(e);
    }
    return future;
  }

  Stream<DatabaseEvent> getAgentPic() {
    Stream<DatabaseEvent> stream;
    try {
      var agId = Prefs.getString(agentId)!;
      final compId = Prefs.getString(companyId);
      // Get the Stream
      late DatabaseReference ref;
      ref = FirebaseDatabase.instance.ref("company/$compId/users/agent/$agId");
      stream = ref.orderByKey().equalTo('picture').onValue;
    } catch (e) {
      throw Exception(e);
    }
    return stream;
  }


  /// The user selects a file, and the task is added to the list.
  Future<firebase_storage.UploadTask?> uploadFile(XFile? file) async {
    ///get agent id from shared preference
    var agId = Prefs.getString(agentId)!;

   // try {
      if (file == null) {
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //   content: Text('No file was selected'),
        // ));
        print('No file was selected');

        return null;
      }

      var bytes = await file.readAsBytes();

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

      firebase_storage.Reference _storage = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('agent')
          .child('/images')
          .child('/photo_agent_$agId.jpg');


     //firebase_storage.UploadTask uploadTaskSnapshot =
          _storage.putData(bytes, metadata).then((p0) async{
            var imageUri = await _storage.getDownloadURL();

            ///Update picture agent url
            await setAgentPhoto(imageUri);

          });

  }

  Future<void> setAgentPhoto(String imageUrl) async {
    try {
      ///get agent id from shared preference
      var agId = Prefs.getString(agentId)!;
      final compId = Prefs.getString(companyId);
      late DatabaseReference ref;
      ref = FirebaseDatabase.instance.ref("company/$compId/users/agent");
      await ref.child(agId).update({
        "picture": imageUrl,
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  //TODO show only finished (2 queries not working)
  Stream<DatabaseEvent> getOrdersByAgentIdDao() {
    final compId = Prefs.getString(companyId);
    var agId = Prefs.getString(agentId)!;
    late Stream<DatabaseEvent> stream;
    try {
      late DatabaseReference orderRef =
          FirebaseDatabase.instance.ref("company/$compId/order");

      // Get the Stream
      stream = orderRef
          .orderByChild('agent_id')
          .equalTo(agId)
          //.orderByChild('status').equalTo('Status.finish.name')
          // .child('status')
          // .equalTo(Status.finish.name)
          .onValue;
    } catch (e) {
      throw Exception(e);
    }
    return stream;
  }

  ///get All ORDERS
  // Stream<DatabaseEvent> getAllOrders() {
  //   final compId = Prefs.getString(companyId);
  //   DatabaseReference orderRef = FirebaseDatabase.instance.ref("company/$compId/order/");
  //   Stream<DatabaseEvent> stream = orderRef.orderByValue().onValue;
  //   return stream;
  // }

  Future<DatabaseEvent> getAllOrders() {
    final compId = Prefs.getString(companyId);

    Future<DatabaseEvent> future;
    try {
      DatabaseReference orderRef =
          FirebaseDatabase.instance.ref("company/$compId/order/");
      future = orderRef.orderByValue().once();
    } catch (e) {
      throw Exception(e);
    }
    return future;
  }

  Future<DatabaseEvent> getTodayOrders() {
    final compId = Prefs.getString(companyId);

    Future<DatabaseEvent> future;

    try {
      future = FirebaseDatabase.instance
          .ref("company/$compId/order")
          .orderByKey()
          .equalTo(getToday().getFormattedDate())
          .once();

      // DatabaseReference orderRef = FirebaseDatabase.instance.ref(
      //     "company/$compId/order/");
      // future = orderRef.orderByValue().once();

    } catch (e) {
      throw Exception(e);
    }
    return future;
  }
}
