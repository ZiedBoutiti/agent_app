import 'package:agent/config/shared_preference.dart';
import 'package:agent/resources/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileProvider with ChangeNotifier{
  XFile? file;

  void setFile(XFile? newFile){
    file = newFile;
    notifyListeners();
  }

  bool wait = false;

  void setWaiting(bool waiting){
    wait = waiting;
    notifyListeners();
  }

  int totalTasks =0;
  void setTotalTasks(int total)async{
    totalTasks = total;
    notifyListeners();
  }

  bool waitingTasks = false;

  void setTasksWaiting(bool waiting){
    waitingTasks = waiting;
    notifyListeners();
  }


  double totalPrice = 0;
  void setTotalPrices(double prices){
    totalPrice = prices;
  }


  double totalTodayPrice = 0;
  void setTotalTodayPrices(double prices){
    totalTodayPrice = prices;

  }


  final lang = Prefs.getString(language);
  late Locale locale;
  late String currentLang = 'EN';
  ProfileProvider(){
    locale  = lang == '' || lang == null ? const Locale('en', '') : Locale(lang!, '');
    currentLang =  lang == '' || lang == null ? 'EN' : lang!.toUpperCase();
  }


void setLocale(Locale value,String lang) {
    locale = value;
    currentLang = lang;
    notifyListeners();
}


  bool isSwitched = false;
  var textValue = 'Switch is OFF';

  void toggleSwitch(bool value) {
    isSwitched = value;
    notifyListeners();
  }
}