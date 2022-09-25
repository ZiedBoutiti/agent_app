import 'package:agent/config/utils.dart';
import 'package:agent/resources/colors.dart';
import 'package:agent/resources/styles.dart';
import 'package:agent/screens/profile/data/repository/profile_repository.dart';
import 'package:agent/screens/profile/domain/notifier/profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class PickPhoto {

  final ProfileRepository _profileRepository = ProfileRepository();

  Future<void> _displayPickImageDialog(BuildContext context) async {
    XFile? value;
    final profileRead  = Provider.of<ProfileProvider>(context, listen: false);
    final profileWatch  = Provider.of<ProfileProvider>(context, listen: false);

     showDialog(context: context, builder: (context) {
       ///get language
       var local = getAppLang(context);

          return AlertDialog(
            title: Text(local.pick),
            content: SizedBox(
              height: getScreenHeight(context) *.1,
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(onTap: () async {

                        value =    await getFromGallery();
                        profileRead.setWaiting(true);
                        await uploadImageToFirebase(value);
                       // file.setFile(value);
                        profileRead.setWaiting(false);
                       Navigator.of(context).pop(true);
                      },
                          child: Column(
                            children: [
                              Image.asset('assets/gallery.png',
                              height: 40,
                                width:40
                              ),
                              Text(local.gallery),
                            ],
                          )
                      ),
                      InkWell(onTap: () async {

                        value =    await getFromCamera();
                        profileRead.setWaiting(true);
                        await uploadImageToFirebase(value);
                        profileRead.setWaiting(false);
                       // file.setFile(value);
                        Navigator.of(context).pop(true);
                      },
                          child: Column(
                            children: [
                              Image.asset('assets/camera.png',
                                  height: 40,
                                  width:40
                              ),
                              Text(local.camera),
                            ],
                          ))
                    ],
                  ),


                  profileWatch.wait == true ?
                      const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                    ) : Container()
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child:  Text(local.cancel,
                  style: bottomBarText.copyWith(color: fieldTextColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }


  final ImagePicker _picker = ImagePicker();

  Future<void> onImageButtonPressed({BuildContext? context, bool isMultiImage = false}) async {
       await _displayPickImageDialog(context!);
  }

  /// Get from gallery
  // Future<XFile?> getFromGallery() async {
  //   XFile? pickedFile = await _picker.pickImage(
  //     source: ImageSource.gallery,
  //     maxWidth: 70,
  //     maxHeight: 70,
  //   );
  //   if (pickedFile != null) {
  //     return pickedFile;
  //   }
  // }

  Future getFromGallery() async {
    XFile? pickedFile;
    try {
      pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 50,
        maxHeight: 71,
      );
      //if (pickedFile != null) {
      return pickedFile;
    } catch (e) {
      return;
    }
  }


  /// Get from Camera
  Future getFromCamera() async {
    XFile? pickedFile;
    try {
      pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 50,
        maxHeight: 71,
      );
      return pickedFile;
    } catch (e) {
      return;
    }

    // if (pickedFile != null) {
    //   return pickedFile;
    // }
  }

  // /// Get from Camera
  // Future<XFile?> getFromCamera() async {
  //   XFile? pickedFile = await _picker.pickImage(
  //     source: ImageSource.camera,
  //     maxWidth: 1800,
  //     maxHeight: 1800,
  //   );
  //   if (pickedFile != null) {
  //     return pickedFile;
  //   }
  // }

  ///save agent photo in firebase storage
  Future<firebase_storage.UploadTask?>  uploadImageToFirebase(XFile? file) async{
 final task =  await  _profileRepository.uploadFileToFirebase(file: file);
    //print(task?.storage.ref().fullPath);
    return task;
    // final fss = FirebaseStorageService();
    // await fss.uploadImagesToCloudStorage().then((List urls) => imageURLs = urls);
  }

}
