import 'package:agent/screens/login/data/models/argument_data.dart';
import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  List<String> listNames = [];
  late ArgumentData   argument;
  void setNewName(String name) {
    listNames.add(name);
    notifyListeners();
  }
  void setClickedName(String newData) {
    argument = ArgumentData(name: newData);
    notifyListeners();
  }


late String picture = '';
  void setAgentPicture(String pic) {
    picture = pic;
    notifyListeners();
  }
}
