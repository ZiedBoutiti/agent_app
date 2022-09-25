

import 'package:flutter/material.dart';

class RouteProvider with ChangeNotifier{

  int currentPageIndex = 0;

  void setCurrentPageIndex(int newCurrentPage){
    currentPageIndex = newCurrentPage;
    notifyListeners();
  }

}