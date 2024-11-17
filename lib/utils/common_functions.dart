List<String> convertDateToArray(String date) {
  final dateParts = date.split('-');
  if (dateParts.length != 4) {
    throw const FormatException('Invalid date format');
  }

  final day =
      DateTime.parse('${dateParts[2]}-${dateParts[1]}-${dateParts[0]}').weekday;
  final dayNames = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  final dayName = dayNames[day - 1];

  final monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  final monthName = monthNames[int.parse(dateParts[1]) - 1];

  return [dayName, dateParts[0], monthName, dateParts[2], dateParts[3]];
}
