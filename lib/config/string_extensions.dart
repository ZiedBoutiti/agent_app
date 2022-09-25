

import 'package:intl/intl.dart';

extension StringExtensions on String {
  ///format date
  String getFormattedDate({bool endDate = false}) {
    DateTime dateTime;
    String date = this;

    if (length == 10) {
      dateTime = DateFormat("yyyy-MM-dd").parse(this);
      var day = dateTime.day
          .toString()
          .length == 1
          ? '0${dateTime.day.toString()}'
          : dateTime.day.toString();
      var month = dateTime.month
          .toString()
          .length == 1
          ? '0${dateTime.month.toString()}'
          : dateTime.month.toString();
      // date = day + '/' + month + '/' + dateTime.year.toString();
      date = dateTime.year.toString() + month + day;
    } else if (length == 4) {
      dateTime = DateFormat("yyyy").parse(this);
      var day = '01';
      var month = '01';

      date = dateTime.year.toString() + month + day;
    } else {
      dateTime = DateFormat("yyyy-MM").parse(this);
      DateTime dateT = dateTime.month < 12
          ? DateTime(dateTime.year, dateTime.month + 1, 0)
          : DateTime(dateTime.year + 1, 1, 0);

      var day = endDate
          ? dateT.day
          .toString()
          .length == 1
          ? '0${dateT.day.toString()}'
          : dateT.day.toString()
          : '01';

      var month = dateTime.month
          .toString()
          .length == 1
          ? '0${dateTime.month.toString()}'
          : dateTime.month.toString();

      date = dateTime.year.toString() + month + day;
    }
    return date;
  }
}