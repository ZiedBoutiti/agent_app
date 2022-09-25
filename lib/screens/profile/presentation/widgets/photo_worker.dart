import 'package:agent/resources/colors.dart';
import 'package:agent/screens/common_widgets/round_image.dart';
import 'package:agent/screens/profile/domain/utils/pick_photo.dart';
import 'package:flutter/material.dart';

class PhotoWorker extends StatelessWidget {
  final String picture;
  const PhotoWorker({Key? key, required this.picture}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    ///Pick photos
    final PickPhoto _pickPhoto = PickPhoto();

    return GestureDetector(
        onTap: () async {
          await _pickPhoto.onImageButtonPressed(context: context);
        },
        child: RoundImage(
          pictureUrl: picture,
          sizeMob: 100,
          sizeTab: 200,
          borderColor: secondColor,
        ));

    //   Stack(
    //   children: [
    //     GestureDetector(
    //         onTap: () async {
    //           await _pickPhoto.onImageButtonPressed(context: context);
    //         },
    //         child: RoundImage(pictureUrl: picture,sizeMob: 120,sizeTab: 200,borderColor: secondColor,
    //         )),
    //     // Positioned(
    //     //     right: profileWatch.locale.languageCode == 'en' ? getScreenWidth(context) / 2* .1
    //     //     : getScreenWidth(context) / 4 *.1,
    //     //   //  alignment: Alignment.topRight,
    //     //     child: GestureDetector(
    //     //         onTap: () async {
    //     //           await _pickPhoto.onImageButtonPressed(context: context);
    //     //         },
    //     //         child: const Icon(
    //     //           Icons.border_color,
    //     //           color: secondColor,
    //     //         ))),
    //   ],
    // );
  }
}
