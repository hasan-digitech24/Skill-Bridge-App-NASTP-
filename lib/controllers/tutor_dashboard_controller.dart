import 'package:flutter/foundation.dart';

import '../data/tutor_repository.dart';
import '../models/booking_request_model.dart';
import '../models/session_model.dart';
import '../utils/date_helper.dart';

class TutorDashboardController extends ChangeNotifier {
  final TutorRepository _repo = TutorRepository.instance;

  bool showAll = false;

  TutorDashboardController() {
    _repo.addListener(notifyListeners);
  }

  @override
  void dispose() {
    _repo.removeListener(notifyListeners);
    super.dispose();
  }

  String get tutorFirstName => _repo.tutor.firstName;

  String get greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  String get dateLabel {
    final now = DateTime.now();
    return '${DateHelper.weekdayFull(now)}, ${now.day} ${DateHelper.monthFull(now)}';
  }

  // ---------- Requests ----------

  List<BookingRequestModel> get pendingRequests {
    final list =
        _repo.requests.where((r) => r.status == RequestStatus.pending).toList();
    list.sort((a, b) => a.sessionStart.compareTo(b.sessionStart));
    return list;
  }

  List<BookingRequestModel> get visibleRequests {
    final list = pendingRequests;
    if (showAll || list.length <= 2) return list;
    return list.sublist(0, 2);
  }

  bool get canToggleViewAll => pendingRequests.length > 2;

  void toggleViewAll() {
    showAll = !showAll;
    notifyListeners();
  }

  void acceptRequest(String id) => _repo.respondToRequest(id, accept: true);

  void declineRequest(String id) => _repo.respondToRequest(id, accept: false);

  // ---------- Statistics ----------

  List<SessionModel> get _completedSessions =>
      _repo.sessions.where((s) => s.isCompleted).toList();

  double get totalEarnings =>
      _completedSessions.fold(0.0, (sum, s) => sum + s.price);

  double _earningsForMonth(DateTime month) {
    return _completedSessions
        .where((s) => s.start.year == month.year && s.start.month == month.month)
        .fold(0.0, (sum, s) => sum + s.price);
  }

  // null when there is nothing to compare with last month.
  int? get earningsChangePercent {
    final now = DateTime.now();
    final thisMonth = _earningsForMonth(now);
    final lastMonth = _earningsForMonth(DateTime(now.year, now.month - 1, 1));
    if (lastMonth == 0) return null;
    return ((thisMonth - lastMonth) / lastMonth * 100).round();
  }

  String get earningsNote {
    final change = earningsChangePercent;
    if (change == null) {
      return totalEarnings == 0 ? 'No earnings yet' : 'This month';
    }
    final sign = change >= 0 ? '+' : '';
    return '$sign$change% this month';
  }

  int get pendingCount => pendingRequests.length;

  int get upcomingCount {
    final now = DateTime.now();
    final weekAhead = now.add(const Duration(days: 7));
    return _repo.sessions
        .where((s) =>
            s.status == SessionStatus.scheduled &&
            !s.start.isBefore(now) &&
            s.start.isBefore(weekAhead))
        .length;
  }

  // ---------- Next class ----------

  SessionModel? get nextClass {
    final now = DateTime.now();
    final list = _repo.sessions
        .where((s) =>
            s.status == SessionStatus.scheduled &&
            DateHelper.isSameDay(s.start, now) &&
            s.end.isAfter(now))
        .toList();
    if (list.isEmpty) return null;
    list.sort((a, b) => a.start.compareTo(b.start));
    return list.first;
  }

  String get nextClassTitle {
    final session = nextClass;
    if (session == null) return '';
    final now = DateTime.now();
    if (session.start.isAfter(now)) {
      return 'Next class in ${DateHelper.remaining(session.start.difference(now))}';
    }
    return 'Class in progress';
  }

  String get nextClassSubtitle {
    final session = nextClass;
    if (session == null) return '';
    return '${DateHelper.time12(session.start)} · ${session.studentName}';
  }

  String get notificationMessage {
    if (pendingCount == 0) return 'No new notifications';
    return pendingCount == 1
        ? 'You have 1 pending booking request'
        : 'You have $pendingCount pending booking requests';
  }
}
