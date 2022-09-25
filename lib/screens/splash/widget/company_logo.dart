

import 'package:agent/screens/splash/model/config.dart';
import 'package:agent/screens/splash/service/splash_service.dart';
import 'package:agent/screens/splash/widget/round_logo.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CompanyLogo extends StatelessWidget {
  final double size;
  const CompanyLogo({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SplashService splashService = SplashService();

    return      FutureBuilder<DatabaseEvent>(
        future: splashService.getCompanyConfig(),
        builder: (context, snapshot) {

          if (snapshot.hasData) {

            if(snapshot.data!.snapshot.value != null) {

              Config config;

              final json = snapshot.data!.snapshot.value
              as Map<dynamic, dynamic>;


              // print(json.values.first);
              //  config = Config.fromJson(json.values.single);

              // json.forEach((key, value) {
              //  config = Config.fromJson(json.keys.single);
              //  print(config.name);
              // });

              return Center(
                  child: SizedBox(
                    height: size,
                    width: size,
                    child: RoundLogo(
                        pictureUrl: json['logo'],
                        borderColor: Colors.transparent),

                  ));
            }else{
              return Container();
            }


          }
          return Container();

        });
  }
}