import 'dart:async';

import 'package:agent/config/utils.dart';
import 'package:agent/resources/colors.dart';
import 'package:agent/resources/constants.dart';
import 'package:agent/screens/tasks/data/models/order.dart';
import 'package:agent/screens/tasks/data/repository/tasks_repository.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskProvider with ChangeNotifier {
  ///add to order detail box
  // void setToOrderDetail(Order selectedOrder) {
  //   listCurrentOrder.add(orderDetail);
  //   notifyListeners();
  // }
  final TasksRepository _tasksRepository = TasksRepository();

  late Stream<DatabaseEvent> stream;

  void setStream() {
    stream = _tasksRepository.getTodayOrders();
    notifyListeners();
  }

  /// Button setting
  late Color color = Colors.green;
  void setButtonColor(String status) {
    if (status == Status.created.name) {
      color = startTask;
    } else if (status == Status.started.name) {
      color = busyTask;
    } else {
      color = endTaskButton;
    }
    // notifyListeners();
  }

  late String title = '';
  void setTitle(String status, BuildContext context) {
    ///get language
    var local = getAppLang(context);

    if (status == Status.created.name) {
      title = local.start;
    } else if (status == Status.started.name) {
      title = local.processing;
    } else {
      title = local.finished;
    }
    // notifyListeners();
  }

  ///change button color & text
  void changeButtonState(String status, BuildContext context) {
    setTitle(status, context);
    setButtonColor(status);
    // stream = _tasksRepository.getTodayOrders();
    wait = false;

    if (status == Status.started.name) {
      changeTimer();
    } else {
      _resetTimer();
    }

    notifyListeners();
  }

  ///add clicked row index in order table
  late int clickedRow = -1;
  // late  Order order = Order(totalPrice: 0,//paymentMethodeId: '',
  //   customerId: '', date: '', orderItems: [],cashierId: '');
  late OrderItem orderItem = OrderItem(
      agentId: '',
      status: '',
      serviceId: '',
      discountPercentage: 0,
      price: 0.0,
      qte: 0,
  finalPrice: 0
  );

  late String orderKey = '';
  late String orderItemKey = '';

  late String customerId = '';
  late String invoiceNumber = '';
  late String time = '';

  ///Counter variables
  Timer? _timer = Timer(const Duration(seconds: 0), () {});
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  late String periodOrder = '';

  ///set selected order
  void setClickedRow(
      {required int row,
      required OrderItem selectedOrder,
      required String key,
      required String itemKey,
      required BuildContext context,
      required dynamic invoice,
      required String customId}) {
    clickedRow = row;
    // order = selectedOrder;
    orderItem = selectedOrder;
    orderKey = key;
    orderItemKey = itemKey;
    invoiceNumber = invoice;
    customerId = customId;

    setTitle(orderItem.status, context);

    setButtonColor(orderItem.status);

    ///get order Started At
    time = orderItem.startAt;

    ///reset Timer
    _resetTimer();

    ///start counter if it's already started
    if (time != '') {
      changeTimer();
    }

    notifyListeners();
  }

  bool wait = false;
  void setWaiting(bool waiting) {
    wait = waiting;
    notifyListeners();
  }

  ///start Timer
  void changeTimer() {
    if (time != '') {
      DateTime dateStart;

      ///switch time string to date time
      /////DateFormat('dd-MM-yyyy hh:mm:ss a')
      dateStart = DateFormat('yyyy-MM-dd hh:mm:ss a').parse(time);

      ///get date time now to do the difference
      DateTime now = DateTime.now();
      var _formatter = DateFormat('yyyy-MM-dd hh:mm:ss a');
      String _formatterDate = _formatter.format(now);

      DateTime dateNow = _formatter.parse(_formatterDate);

      Duration diffTime = dateNow.difference(dateStart);

      hours = diffTime.inHours.remainder(60);
      minutes = diffTime.inMinutes.remainder(60);
      seconds = diffTime.inSeconds.remainder(60);

      notifyListeners();
    }
    const oneSec = Duration(seconds: 1);

    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (seconds < 0) {
        timer.cancel();
      } else {
        seconds = seconds + 1;
        if (seconds > 59) {
          minutes += 1;
          seconds = 0;
          if (minutes > 59) {
            hours += 1;
            minutes = 0;
          }
        }
      }

      periodOrder = '$hours:$minutes:$seconds';
      notifyListeners();
    });
  }

  void _resetTimer() {
    if (_timer!.isActive) {
      seconds = 0;
      minutes = 0;
      hours = 0;
      periodOrder = '';
      _timer!.cancel();
    }
  }
}
