import 'package:agent/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:transparent_image/transparent_image.dart';

class RoundImage extends StatelessWidget {
  final String pictureUrl;
  final double sizeMob;
  final double sizeTab;
  final Color borderColor;
  const RoundImage({Key? key, required this.pictureUrl, required this.sizeMob,required this.sizeTab,  required this.borderColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
        decoration: BoxDecoration(
            shape:
            BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(
                color:
                borderColor)
        ),
        child: Padding(
          padding:  EdgeInsets.all(borderColor == primaryColor ? 1.0 : 0.0),
          child: ClipRRect(
            borderRadius:
            BorderRadius
                .circular(
                70.0),
            child:
            pictureUrl != ""?
            FadeInImage.memoryNetwork(
              height: getValueForScreenType<double>(
                context: context,
                mobile: sizeMob,
                tablet: sizeTab,
              ),
              width:  getValueForScreenType<double>(
                context: context,
                mobile: sizeMob,
                tablet: sizeTab,
              ),
              fit: BoxFit.fill,
              placeholder: kTransparentImage,
              imageErrorBuilder: (context, object, stacktrace) {
                return Image.asset(
                  'assets/girl.png',
                );
              },
              image: pictureUrl,
            ): Image.asset(
              'assets/girl.png',
              height: getValueForScreenType<double>(
                context: context,
                mobile: sizeMob,
                tablet: sizeTab,
              ),
              width:  getValueForScreenType<double>(
                context: context,
                mobile: sizeMob,
                tablet: sizeTab,
              ),

            ),
          ),
        )
    );
  }
}
