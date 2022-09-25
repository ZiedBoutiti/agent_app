

import 'package:agent/config/utils.dart';
import 'package:agent/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class RoundLogo extends StatelessWidget {
  final String pictureUrl;
  final Color borderColor;
  const RoundLogo(
      {Key? key, required this.pictureUrl, required this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(color: borderColor)
        ),
        child: Padding(
          padding: EdgeInsets.all(borderColor == primaryColor ? 1.0 : 0.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(80.0), //70.0
            child: pictureUrl != ""
                ? FadeInImage.memoryNetwork(
              height:getScreenWidth(context) * .1 + 10,
              width: getScreenWidth(context) * .1 + 10,
              fit: BoxFit.fill,
              placeholder: kTransparentImage,
              imageErrorBuilder: (context, object, stacktrace) {
                return Image.asset(
                  'assets/images/girl.png',
                  height: getScreenWidth(context) * .1 + 10,
                  width: getScreenWidth(context) * .1 + 10,
                );
              },
              image: pictureUrl,
            )
                : Image.asset(
              'assets/images/girl.png',
              height: getScreenWidth(context) * .1 + 10,
              width: getScreenWidth(context) * .1 + 10,
            ),
          ),
        ));
  }
}