import 'dart:math';

import 'package:flutter/foundation.dart';

import '../data/tutor_repository.dart';
import '../models/session_model.dart';
import '../utils/date_helper.dart';

class ScheduleController extends ChangeNotifier {
  final TutorRepository _repo = TutorRepository.instance;

  DateTime selectedDate = DateHelper.dateOnly(DateTime.now());

  ScheduleController() {
    _repo.addListener(notifyListeners);
  }

  @override
  void dispose() {
    _repo.removeListener(notifyListeners);
    super.dispose();
  }

  // ---------- Calendar ----------

  String get monthLabel =>
      '${DateHelper.monthFull(selectedDate)} ${selectedDate.year}';

  List<DateTime> get weekDates {
    final start = DateHelper.startOfWeek(selectedDate);
    return List.generate(
        7, (i) => DateTime(start.year, start.month, start.day + i));
  }

  bool isSelected(DateTime date) => DateHelper.isSameDay(date, selectedDate);

  bool isToday(DateTime date) => DateHelper.isSameDay(date, DateTime.now());

  void selectDate(DateTime date) {
    selectedDate = DateHelper.dateOnly(date);
    notifyListeners();
  }

  void goToToday() => selectDate(DateTime.now());

  void previousMonth() => _moveMonth(-1);

  void nextMonth() => _moveMonth(1);

  void _moveMonth(int delta) {
    final firstOfTarget = DateTime(selectedDate.year, selectedDate.month + delta, 1);
    final daysInTarget =
        DateTime(firstOfTarget.year, firstOfTarget.month + 1, 0).day;
    selectedDate = DateTime(firstOfTarget.year, firstOfTarget.month,
        min(selectedDate.day, daysInTarget));
    notifyListeners();
  }

  // ---------- Sessions ----------

  String get selectedDayLabel =>
      '${DateHelper.weekdayFull(selectedDate)}, ${DateHelper.monthShort(selectedDate)} ${selectedDate.day}';

  List<SessionModel> get sessionsForSelectedDate {
    final list = _repo.sessions
        .where((s) => DateHelper.isSameDay(s.start, selectedDate))
        .toList();
    list.sort((a, b) => a.start.compareTo(b.start));
    return list;
  }

  String get classCountLabel {
    final count = sessionsForSelectedDate.length;
    if (count == 0) return 'No classes';
    return count == 1 ? '1 class' : '$count classes';
  }

  void markCompleted(String sessionId) => _repo.completeSession(sessionId);
}
