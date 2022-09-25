import 'package:intl/intl.dart';

///get date
DateTime formatDate({required String currentDate}) {
  DateTime dateTime;
  dateTime = DateTime.parse(currentDate);

  var _formatter = DateFormat('yyyy-MM-dd');
  var _formatDate = _formatter.format(dateTime);

  dateTime = DateFormat("yyyy-MM-dd").parse(_formatDate);
  return dateTime;
}

String getDayFromDate({required String currentDate}) {
  DateTime date = formatDate(currentDate: currentDate);
  return date.day.toString();
}

///format date
String getPeriod({
  required String currentDate,
  String lang = 'en',
  bool month = true,
}) {
  DateTime dateTime;
  String date;

  dateTime = DateTime.parse(currentDate);

  if (month) {
    var _formatter = DateFormat('yyyy-MM');
    var _formatDate = _formatter.format(dateTime);

    dateTime = DateFormat("yyyy-MM").parse(_formatDate);

    date = DateFormat('MMMM').format(DateTime(0, dateTime.month));

    if (lang == 'ar') {
      date = getMonthName(date);
    }
  } else {
    var _formatter = DateFormat("yyyy-MM-dd");
    var _formatDate = _formatter.format(dateTime);
    dateTime = DateFormat("yyyy-MM-dd").parse(_formatDate);

    date = DateFormat('EEEE').format(dateTime);

    if (lang == 'ar') {
      date = getDayName(date);
    }
  }
  return date;
}

///day to arabic
String getDayName(String day) {
  String dayAr = '';
  switch (day) {
    case 'Monday':
      dayAr = 'الإثنين';
      break;
    case 'Tuesday':
      dayAr = 'الثلاثاء';
      break;
    case 'Wednesday':
      dayAr = 'الأربعاء';
      break;
    case 'Thursday':
      dayAr = 'الخميس';
      break;
    case 'Friday':
      dayAr = 'الجمعة';
      break;
    case 'Saturday':
      dayAr = 'السبت';
      break;
    case 'Sunday':
      dayAr = 'الأحد';
  }
  return dayAr;
}

///month to arabic
String getMonthName(String month) {
  String monthAr = '';
  switch (month) {
    case 'January':
      monthAr = 'يناير';
      break;
    case 'February':
      monthAr = 'فبراير';
      break;
    case 'March':
      monthAr = 'مارس';
      break;
    case 'April':
      monthAr = 'أبريل';
      break;
    case 'May':
      monthAr = 'مايو';
      break;
    case 'June':
      monthAr = 'يونيو';
      break;
    case 'July':
      monthAr = 'يوليو';
      break;
    case 'August':
      monthAr = 'أغسطس';
      break;
    case 'September':
      monthAr = 'سبتمبر';
      break;
    case 'October':
      monthAr = 'أكتوبر';
      break;
    case 'November':
      monthAr = 'نوفمبر';
      break;
    case 'December':
      monthAr = 'ديسمبر';
      break;
  }
  return monthAr;
}

///change format from date to orders date key
///format date
String getFormattedDate({required String currentDate, bool endDate = false}) {
  DateTime dateTime;
  String date = currentDate;

  if (currentDate.length == 10) {
    dateTime = DateFormat("yyyy-MM-dd").parse(currentDate);
    var day = dateTime.day.toString().length == 1
        ? '0${dateTime.day.toString()}'
        : dateTime.day.toString();
    var month = dateTime.month.toString().length == 1
        ? '0${dateTime.month.toString()}'
        : dateTime.month.toString();
    // date = day + '/' + month + '/' + dateTime.year.toString();
    date = dateTime.year.toString() + month + day;
  } else if (currentDate.length == 4) {
    dateTime = DateFormat("yyyy").parse(currentDate);
    var day = '01';
    var month = '01';

    date = dateTime.year.toString() + month + day;
  } else {
    dateTime = DateFormat("yyyy-MM").parse(currentDate);
    DateTime dateT = dateTime.month < 12
        ? DateTime(dateTime.year, dateTime.month + 1, 0)
        : DateTime(dateTime.year + 1, 1, 0);

    var day = endDate
        ? dateT.day.toString().length == 1
            ? '0${dateT.day.toString()}'
            : dateT.day.toString()
        : '01';

    var month = dateTime.month.toString().length == 1
        ? '0${dateTime.month.toString()}'
        : dateTime.month.toString();

    date = dateTime.year.toString() + month + day;
  }
  return date;
}

String formattedStartEndDate({required String currentDate, endDate = false}) {
  DateTime dateTime;
  String date;

  dateTime = DateTime.parse(currentDate);
  var _formatter = DateFormat('yyyy-MM');
  var _formatDate = _formatter.format(dateTime);

  dateTime = DateFormat("yyyy-MM").parse(_formatDate);

  DateTime dateT = dateTime.month < 12
      ? DateTime(dateTime.year, dateTime.month + 1, 0)
      : DateTime(dateTime.year + 1, 1, 0);

  var day = endDate
      ? dateT.day.toString().length == 1
          ? '0${dateT.day.toString()}'
          : dateT.day.toString()
      : '01';

  var month = dateTime.month.toString().length == 1
      ? '0${dateTime.month.toString()}'
      : dateTime.month.toString();

  date = dateTime.year.toString() + month + day;
  return date;
}

String getTimeByLang(String time, String lang) {
  String endTime =
      time.substring(time.length - 2, time.length).toUpperCase() == 'PM'
          ? 'مساء'
          : 'صباحا';
  if (lang == 'ar') {
    time = '${time.substring(0, time.length - 2)} $endTime';
  }
  return time;
}

///get extracting year from date
List<String> getYearFromDate(Map<dynamic, dynamic> json) {
  List<String> dates = [];

  dates.add(json.keys.first.toString().substring(0, 4));

  json.forEach((key, value) {
    String year = key.toString().substring(0, 4);
    if (dates.where((element) => element.substring(0, 4) == year).isEmpty) {
      dates.add(year);
    }
  });

  dates.sort((b, a) => b.compareTo(a));

  return dates;
}

///get months name by number
List<String> getMonthFromDate(Map<dynamic, dynamic> json) {
  List<String> dates = [];

  ///TODO update changes here in month order

  json.forEach((key, value) {
    if (dates.isNotEmpty) {
      List<String> foundList = dates
          .where((element) =>
              getPeriod(currentDate: element) == getPeriod(currentDate: key))
          .toList();

      if (foundList.isEmpty) {
        dates.add(key);
      }
    } else {
      dates.add(key);
    }
  });

  dates.sort((b, a) => b.compareTo(a));

  return dates;
}
