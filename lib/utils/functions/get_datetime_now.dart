String getCurrentTime() {
  final now = DateTime.now();
  final hour = now.hour;
  final minute = now.minute.toString().padLeft(2, '0');
  final period = hour < 12 ? '오전' : '오후';
  final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
  return '$period ${displayHour.toString().padLeft(2, '0')}:$minute';
}

String getCurrentDate() {
  final now = DateTime.now();
  final year = now.year;
  final month = now.month.toString().padLeft(2, '0');
  final day = now.day.toString().padLeft(2, '0');
  return '$year.$month.$day';
}