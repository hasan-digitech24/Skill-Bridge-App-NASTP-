import 'package:flutter/foundation.dart';

import '../models/booking_request_model.dart';
import '../models/session_model.dart';
import '../models/tutor_model.dart';

class TutorRepository extends ChangeNotifier {
  TutorRepository._();
  static final TutorRepository instance = TutorRepository._();

  TutorModel tutor = TutorModel();
  final List<BookingRequestModel> requests = [];
  final List<SessionModel> sessions = [];

  void load({
    TutorModel? tutor,
    List<BookingRequestModel>? requests,
    List<SessionModel>? sessions,
  }) {
    if (tutor != null) this.tutor = tutor;
    if (requests != null) {
      this.requests
        ..clear()
        ..addAll(requests);
    }
    if (sessions != null) {
      this.sessions
        ..clear()
        ..addAll(sessions);
    }
    notifyListeners();
  }

  void updateTutor(TutorModel updated) {
    tutor = updated;
    notifyListeners();
  }

  void respondToRequest(String requestId, {required bool accept}) {
    final index = requests.indexWhere((r) => r.id == requestId);
    if (index == -1) return;
    final request = requests[index];
    if (request.status != RequestStatus.pending) return;

    request.status = accept ? RequestStatus.accepted : RequestStatus.declined;

    if (accept) {
      sessions.add(
        SessionModel(
          id: 'session_${request.id}',
          studentName: request.studentName,
          subject: request.subject,
          start: request.sessionStart,
          durationMinutes: request.durationMinutes,
          isOnline: request.isOnline,
          price: request.price,
        ),
      );
    }
    notifyListeners();
  }

  void completeSession(String sessionId) {
    final index = sessions.indexWhere((s) => s.id == sessionId);
    if (index == -1) return;
    sessions[index].status = SessionStatus.completed;
    notifyListeners();
  }
}
