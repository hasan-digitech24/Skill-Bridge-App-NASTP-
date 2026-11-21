import '../models/availability_model.dart';
import '../models/booking_request_model.dart';
import '../models/session_model.dart';
import '../models/subject_model.dart';
import '../models/tutor_model.dart';
import 'tutor_repository.dart';

void loadTutorDemoData() {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  final availability = AvailabilityModel();
  for (int day = 1; day <= 5; day++) {
    for (final hour in [9, 11, 14, 16]) {
      availability.toggleSlot(day, hour);
    }
  }

  final tutor = TutorModel(
    id: 'demo_tutor',
    name: 'Demo Tutor',
    designation: 'Software Development',
    about: 'Demo profile text. Replace with the real tutor description.',
    hourlyRate: 30,
    subjects: const [SubjectModel('Flutter'), SubjectModel('Dart')],
    teachesOnline: true,
    teachesAtHome: true,
    isVerified: true,
    availability: availability,
  );

  final requests = [
    BookingRequestModel(
      id: 'demo_r1',
      studentName: 'Demo Student A',
      subject: 'Flutter · Widgets',
      sessionStart: today.add(const Duration(hours: 16)),
      createdAt: now.subtract(const Duration(minutes: 2)),
      durationMinutes: 60,
      isOnline: true,
      price: 30,
    ),
    BookingRequestModel(
      id: 'demo_r2',
      studentName: 'Demo Student B',
      subject: 'Flutter · Firebase',
      sessionStart: today.add(const Duration(days: 1, hours: 10)),
      createdAt: now.subtract(const Duration(hours: 1)),
      durationMinutes: 120,
      isOnline: true,
      price: 60,
    ),
    BookingRequestModel(
      id: 'demo_r3',
      studentName: 'Demo Student C',
      subject: 'Dart · Basics',
      sessionStart: today.add(const Duration(days: 2, hours: 15)),
      createdAt: now.subtract(const Duration(hours: 5)),
      durationMinutes: 90,
      isOnline: false,
      price: 45,
    ),
  ];

  final sessions = [
    SessionModel(
      id: 'demo_s1',
      studentName: 'Demo Student D',
      subject: 'Flutter Basics',
      start: today.add(const Duration(hours: 10)),
      durationMinutes: 60,
      isOnline: true,
      price: 30,
    ),
    SessionModel(
      id: 'demo_s2',
      studentName: 'Demo Student E',
      subject: 'State Management',
      start: today.add(const Duration(hours: 13, minutes: 30)),
      durationMinutes: 90,
      isOnline: false,
      price: 45,
    ),
    SessionModel(
      id: 'demo_s3',
      studentName: 'Demo Student F',
      subject: 'Custom Widgets',
      start: today.add(const Duration(hours: 18)),
      durationMinutes: 60,
      isOnline: true,
      price: 30,
    ),
    SessionModel(
      id: 'demo_s4',
      studentName: 'Demo Student D',
      subject: 'Dart Basics',
      start: today
          .subtract(const Duration(days: 40))
          .add(const Duration(hours: 11)),
      durationMinutes: 60,
      isOnline: true,
      price: 100,
      status: SessionStatus.completed,
    ),
    SessionModel(
      id: 'demo_s5',
      studentName: 'Demo Student E',
      subject: 'Flutter Basics',
      start: today
          .subtract(const Duration(days: 2))
          .add(const Duration(hours: 9)),
      durationMinutes: 60,
      isOnline: true,
      price: 120,
      status: SessionStatus.completed,
    ),
  ];

  TutorRepository.instance.load(
    tutor: tutor,
    requests: requests,
    sessions: sessions,
  );
}
