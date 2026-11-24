enum StudentSessionStatus { pending, confirmed, completed }

class StudentSessionModel {
  final String id;
  final String tutorName;
  final String subject;
  final String image; 
  final DateTime start;
  final int durationMinutes;
  final bool isOnline;
  final double fee;
  final StudentSessionStatus status;

  const StudentSessionModel({
    required this.id,
    required this.tutorName,
    required this.subject,
    required this.image,
    required this.start,
    required this.durationMinutes,
    required this.isOnline,
    required this.fee,
    required this.status,
  });
}