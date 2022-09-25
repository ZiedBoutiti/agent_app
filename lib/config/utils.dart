import 'package:agent/screens/login/data/models/agent_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

AppLocalizations getAppLang(BuildContext context) {
  return AppLocalizations.of(context)!;
}

SnackBar snackBar(String text) {
  var snackBar = SnackBar(
    content: Text(text),
  );
  return snackBar;
}

dynamic getAgentDataInType(dynamic value) {
  Map<String, Agent> map = {};
  // Type type = value.runtimeType;

  //var json;
  String key = '';

  Agent agent = Agent(
      fullName: '', password: -1, picture: '', serviceIds: [], status: '');

  final json = value as Map<dynamic, dynamic>;

  key = json.keys.first;
  agent = Agent.fromJson(json.values.first);

  ///add to map
  map.putIfAbsent(key, () => agent);
  return map;
}

String getServiceName(String lang, String serviceEn, String serviceAr) {
  String service = '';

  if (lang == 'en') {
    if (serviceEn.trim().isEmpty) {
      service = serviceAr;
    } else {
      service = serviceEn.toUpperCase();
    }
  } else {
    if (serviceAr.trim().isEmpty) {
      service = serviceEn;
    } else {
      service = serviceAr;
    }
  }
  return service;
}

void closeKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

String getToday() {
  var now = DateTime.now();
  var _formatter = DateFormat('yyyy-MM-dd');
  var _formatterDate = _formatter.format(now);
  return _formatterDate;
}
