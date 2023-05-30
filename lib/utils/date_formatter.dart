import 'package:intl/intl.dart';

String getDayOfWeek(DateTime date) {
  switch (date.weekday) {
    case 1:
      return 'Senin';
    case 2:
      return 'Selasa';
    case 3:
      return 'Rabu';
    case 4:
      return 'Kamis';
    case 5:
      return 'Jumat';
    case 6:
      return 'Sabtu';
    case 7:
      return 'Minggu';
    default:
      return 'Unknown';
  }
}

String getMonthName(int year, int monthNumber) {
  final monthDateTime = DateTime(year, monthNumber);
  final monthName = DateFormat.MMMM().format(monthDateTime);

  return monthName.substring(0, 3);
}

Future<String> getCurrentDateTime() async {
  DateTime now = DateTime.now();
  String formattedDate =
      '${now.year}-${_twoDigits(now.month)}-${_twoDigits(now.day)}';
  String formattedTime =
      '${_twoDigits(now.hour)}:${_twoDigits(now.minute)}:${_twoDigits(now.second)}';
  return '$formattedDate $formattedTime';
}

String _twoDigits(int n) {
  if (n >= 10) return "$n";
  return "0$n";
}

String formatTime(DateTime? time) {
  final format = DateFormat('h:mm a');
  return format.format(time!);
}
