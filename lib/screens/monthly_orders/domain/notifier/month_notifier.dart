

import 'package:flutter/material.dart';

class MonthlyProvider with ChangeNotifier{

  double totalIncome = 0.0;

  void setTotalIncome(double total){
    totalIncome = total;
  }
}