import 'package:get/get.dart';
import 'package:my_app/models/student_session_model.dart';

class SessionsController extends GetxController {
  final tabs = ['Pending', 'Confirmed', 'Completed'];

  final selectedTab = 1.obs;

  final sessions = <StudentSessionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDemoData();
  }

  void _loadDemoData() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    sessions.addAll([
      StudentSessionModel(
        id: 's1',
        tutorName: 'Maya Chen',
        subject: 'Flutter Development',
        image: 'assets/png/maya.png',
        start: today.add(const Duration(days: 1, hours: 11, minutes: 30)),
        durationMinutes: 60,
        isOnline: true,
        fee: 34.50,
        status: StudentSessionStatus.confirmed,
      ),
      StudentSessionModel(
        id: 's2',
        tutorName: 'Alex Morgan',
        subject: 'Mathematics',
        image: 'assets/png/alex.png',
        start: today.add(const Duration(days: 1, hours: 14, minutes: 30)),
        durationMinutes: 60,
        isOnline: false,
        fee: 40.00,
        status: StudentSessionStatus.confirmed,
      ),
      StudentSessionModel(
        id: 's3',
        tutorName: 'Sarah Williams',
        subject: 'Physics & Science',
        image: 'assets/png/sarah.png',
        start: today.add(const Duration(days: 3, hours: 10)),
        durationMinutes: 90,
        isOnline: true,
        fee: 42.00,
        status: StudentSessionStatus.pending,
      ),
      StudentSessionModel(
        id: 's4',
        tutorName: 'Daniel Brown',
        subject: 'English Literature',
        image: 'assets/png/daniel.png',
        start: today.subtract(const Duration(days: 3)).add(const Duration(hours: 16)),
        durationMinutes: 60,
        isOnline: true,
        fee: 25.00,
        status: StudentSessionStatus.completed,
      ),
    ]);
  }


  StudentSessionStatus get _currentStatus {
    if (selectedTab.value == 0) return StudentSessionStatus.pending;
    if (selectedTab.value == 1) return StudentSessionStatus.confirmed;
    return StudentSessionStatus.completed;
  }

  void selectTab(int index) => selectedTab.value = index;

  List<StudentSessionModel> get currentSessions {
    final list = sessions.where((s) => s.status == _currentStatus).toList();
    list.sort((a, b) => a.start.compareTo(b.start));
    return list;
  }

  int get confirmedCount =>
      sessions.where((s) => s.status == StudentSessionStatus.confirmed).length;

  String get sectionLabel => selectedTab.value == 2 ? 'PAST SESSIONS' : 'UPCOMING';


  void cancelSession(String id) {
    sessions.removeWhere((s) => s.id == id);
    Get.snackbar('Cancelled', 'Your session was cancelled.');
  }

  void joinSession(StudentSessionModel session) {
    Get.snackbar('Joining', 'Opening session with ${session.tutorName}...');
  }

  void viewDetails(StudentSessionModel session) {
    Get.snackbar('Details', '${session.subject} with ${session.tutorName}');
  }

  void bookAgain(StudentSessionModel session) {
    Get.snackbar('Book again', 'Booking ${session.tutorName} again...');
  }
    void addSession(StudentSessionModel session) {
    sessions.add(session);
  }
}