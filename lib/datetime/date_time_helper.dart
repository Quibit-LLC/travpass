//convert DateTime object to a string yyyymmdd

String convertDateTimeToString(DateTime dateTime) {
  // year in the format -> yyyy

  String year = dateTime.year.toString();

  // month in the format -> mm

  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }
  // dat in the format -> dd

  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  String hour = dateTime.hour.toString();
  if (hour.length == 1) {
    hour = '0$hour';
  }

  String minute = dateTime.minute.toString();
  if (minute.length == 1) {
    minute = '0$minute';
  }
  String yyyymmdd = year + month + day;

  return yyyymmdd;
}
