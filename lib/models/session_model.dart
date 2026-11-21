enum SessionStatus { scheduled, completed }

class SessionModel {
  final String id;
  final String studentName;
  final String subject;
  final DateTime start;
  final int durationMinutes;
  final bool isOnline;
  final double price;
  SessionStatus status;

  SessionModel({
    required this.id,
    required this.studentName,
    required this.subject,
    required this.start,
    required this.durationMinutes,
    required this.isOnline,
    required this.price,
    this.status = SessionStatus.scheduled,
  });

  DateTime get end => start.add(Duration(minutes: durationMinutes));

  bool get isCompleted => status == SessionStatus.completed;

  String get placeText => isOnline ? 'Video call' : 'Student home';
}
