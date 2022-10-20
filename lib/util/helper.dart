import 'package:intl/intl.dart';

DateTime todayTime = DateTime.now();
String onlyTimeFormat(String time) {
  if (time == '') {
    return '';
  }
  return DateFormat('KK:mm a').format(parseTime(time));
}

DateTime parseTime(time) => DateTime.parse(time);
String formatTimeWithZ(time) =>
    DateFormat("yyyy-MM-ddTHH:mm:ss").format(time) + '.000Z';
String formatYYYYMMDD(time) => DateFormat('yyyy-MM-dd').format(time);
