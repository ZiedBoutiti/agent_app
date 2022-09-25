import 'package:agent/config/shared_preference.dart';
import 'package:agent/resources/colors.dart';
import 'package:agent/resources/constants.dart';
import 'package:agent/screens/tasks/data/models/agent_order.dart';
import 'package:agent/screens/tasks/data/models/order.dart';
import 'package:agent/screens/tasks/domain/notifier/task_notifier.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

bool searchForStartTasks(
    {required int taskId, required List<int> listStartOrder}) {
  int i = 0;
  bool found = false;
  if (listStartOrder.isNotEmpty) {
    while (i < listStartOrder.length && found == false) {
      if (listStartOrder[i] == taskId) {
        found = true;
      }
      i++;
    }
  }
  return found;
}


///get color by status
Color getStatusColor(String status){
  Color color;
  if(status == Status.created.name){
    color =  startTask;
  }else if(status == Status.started.name){
    color =  busyTask;
  }else{
    color = endTaskButton;
  }

  return color;

}


///format date
String getFormattedDate() {
  final now = DateTime.now();
  var _formatter = DateFormat('yyyy-MM-dd');
 String  _formatterDate = _formatter.format(now);

  DateTime dateTime;
  String date;

  dateTime = DateFormat("yyyy-MM-dd").parse(_formatterDate);
  //print((dateTime.toString().split('').reversed.join()));
  // dateTime = DateFormat("yyyy-MM-dd").parse(_formatterDate);
  //
  var day = dateTime.day.toString().length == 1 ? '0${dateTime.day.toString()}' : dateTime.day.toString();
  var month = dateTime.month.toString().length == 1 ? '0${dateTime.month.toString()}' : dateTime.month.toString();

  date =dateTime.year.toString()+month+day;
  return date;
}