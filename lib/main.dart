import 'dart:async';
import 'package:agent/config/route_provider.dart';
import 'package:agent/config/shared_preference.dart';
import 'package:agent/resources/colors.dart';
import 'package:agent/resources/constants.dart';
import 'package:agent/resources/styles.dart';
import 'package:agent/screens/login/domain/notifier/login_notifier.dart';
import 'package:agent/screens/monthly_orders/domain/notifier/month_notifier.dart';
import 'package:agent/screens/profile/domain/notifier/profile_notifier.dart';
import 'package:agent/screens/tasks/domain/notifier/task_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'config/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Prefs.init();
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
          //   options: DefaultFirebaseOptions.currentPlatform,
          );
    }

    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(
          create: (_) => RouteProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MonthlyProvider(),
        ),
      ],
      child: const MyApp(),
    ));
  }, (error, stack) {
    // var companyID = Prefs.getString(companyId) ?? '';
    // if (companyID != '') {
    //  print(companyID);

    // FirebaseCrashlytics.instance.setUserIdentifier(companyID);
    //}
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    print(879);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ///Hide Bottom Bar (android & ios )
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    final profileWatch = context.watch<ProfileProvider>();
    final lang = Prefs.getString(language);

    return MaterialApp(
      useInheritedMediaQuery: true,
      locale:
          lang == '' || lang == null ? profileWatch.locale : Locale(lang, ''),
      //builder: DevicePreview.appBuilder,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale(profileWatch.locale.languageCode, ''), // Arabic, no country code
      ],

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: profileWatch.locale.languageCode == 'ar'
              ? 'ooredooAr'
              : 'ooredoo',
          primaryColor: secondColor,
          scaffoldBackgroundColor: secondColor,
          appBarTheme: const AppBarTheme(
              backgroundColor: secondColor,
              centerTitle: true,
              titleTextStyle: sAppBarTitle)),
      //appTheme,
      onGenerateRoute: RouterGenerator.generateRoute,
      initialRoute: splashRoute,
    );
  }
}
