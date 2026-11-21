enum RequestStatus { pending, accepted, declined }

class BookingRequestModel {
  final String id;
  final String studentName;
  final String subject;
  final DateTime sessionStart;
  final DateTime createdAt;
  final int durationMinutes;
  final bool isOnline;
  final double price;
  RequestStatus status;

  BookingRequestModel({
    required this.id,
    required this.studentName,
    required this.subject,
    required this.sessionStart,
    required this.createdAt,
    required this.durationMinutes,
    required this.isOnline,
    required this.price,
    this.status = RequestStatus.pending,
  });
}
