class DateHelper {
  static const List<String> weekdayNames = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday',
  ];
  static const List<String> monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  static String weekdayFull(DateTime d) => weekdayNames[d.weekday - 1];
  static String weekdayShort(DateTime d) => weekdayFull(d).substring(0, 3);
  static String monthFull(DateTime d) => monthNames[d.month - 1];
  static String monthShort(DateTime d) => monthFull(d).substring(0, 3);

  static DateTime dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  // Monday of the week that contains [d].
  static DateTime startOfWeek(DateTime d) {
    return DateTime(d.year, d.month, d.day - (d.weekday - 1));
  }

  // "4:00 PM"
  static String time12(DateTime d) {
    final hour = d.hour % 12 == 0 ? 12 : d.hour % 12;
    final minute = d.minute.toString().padLeft(2, '0');
    final suffix = d.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $suffix';
  }

  // "16:00"
  static String time24(DateTime d) {
    return '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
  }

  static String hour24(int hour) => '${hour.toString().padLeft(2, '0')}:00';

  // "Today, 4:00 PM" / "Tomorrow, 10:00 AM" / "May 14, 4:00 PM"
  static String dayAndTime(DateTime d, DateTime now) {
    final today = dateOnly(now);
    final diff = dateOnly(d).difference(today).inDays;
    String day;
    if (diff == 0) {
      day = 'Today';
    } else if (diff == 1) {
      day = 'Tomorrow';
    } else {
      day = '${monthShort(d)} ${d.day}';
    }
    return '$day, ${time12(d)}';
  }

  static String timeAgo(DateTime past, DateTime now) {
    final diff = now.difference(past);
    if (diff.inMinutes < 1) return 'now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  // "1 hour", "1.5 hours", "2 hours"
  static String durationLong(int minutes) {
    if (minutes % 60 == 0) {
      final h = minutes ~/ 60;
      return h == 1 ? '1 hour' : '$h hours';
    }
    return '${(minutes / 60).toStringAsFixed(1)} hours';
  }

  // "1hr", "2hr", "90min"
  static String durationShort(int minutes) {
    if (minutes % 60 == 0) return '${minutes ~/ 60}hr';
    return '${minutes}min';
  }

  // "2h 30m"
  static String remaining(Duration d) {
    final hours = d.inHours;
    final mins = d.inMinutes % 60;
    if (hours > 0 && mins > 0) return '${hours}h ${mins}m';
    if (hours > 0) return '${hours}h';
    return '${mins < 1 ? 1 : mins}m';
  }

  // 1240 -> "1,240"
  static String withCommas(double amount) {
    final text = amount.round().toString();
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && (text.length - i) % 3 == 0) buffer.write(',');
      buffer.write(text[i]);
    }
    return buffer.toString();
  }
}
