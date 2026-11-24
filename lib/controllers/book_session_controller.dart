import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/controllers/sessions_controller.dart';
import 'package:my_app/controllers/student_nav_controller.dart';
import 'package:my_app/models/explore_tutor_model.dart';
import 'package:my_app/models/student_session_model.dart';
import 'package:my_app/routes/app_routes.dart';
import 'package:my_app/utils/date_helper.dart';

class BookSessionController extends GetxController {
  late final ExploreTutorModel tutor;
  late final List<DateTime> dates; // next 7 days

  // Time slots shown in the grid
  final slots = const [
    TimeOfDay(hour: 9, minute: 0),
    TimeOfDay(hour: 10, minute: 0),
    TimeOfDay(hour: 11, minute: 30),
    TimeOfDay(hour: 13, minute: 0),
    TimeOfDay(hour: 14, minute: 30),
    TimeOfDay(hour: 16, minute: 0),
    TimeOfDay(hour: 18, minute: 30),
    TimeOfDay(hour: 19, minute: 0),
    TimeOfDay(hour: 20, minute: 0),
  ];

  // Demo "already booked" slots. Key = weekday (1 = Mon), value = slot indexes.
  final _booked = const {
    1: [1, 6],
    2: [0, 4],
    3: [1, 6],
    4: [2, 5],
    5: [3, 7],
    6: [0],
    7: <int>[],
  };

  // ---------- Selected values ----------
  final selectedDateIndex = 0.obs;
  final selectedSlot = (-1).obs; // -1 = nothing selected yet
  final isOnline = true.obs;
  final hours = 1.0.obs;

  final serviceFee = 2.5;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    if (args is ExploreTutorModel) {
      tutor = args;
    } else {
      tutor = const ExploreTutorModel(
        id: 'demo',
        name: 'Maya Chen',
        subject: 'Flutter Development',
        category: 'Flutter',
        image: 'assets/png/maya.png',
        rating: 4.9,
        reviews: 128,
        price: 32,
      );
    }

    final today = DateHelper.dateOnly(DateTime.now());
    dates = List.generate(
      7,
      (i) => DateTime(today.year, today.month, today.day + i),
    );
  }

  // ---------- Date ----------
  DateTime get selectedDate => dates[selectedDateIndex.value];

  String get monthLabel =>
      '${DateHelper.monthFull(selectedDate)} ${selectedDate.year}';

  void selectDate(int index) {
    selectedDateIndex.value = index;
    selectedSlot.value = -1; // times are different on every day
  }

  // ---------- Time ----------
  String slotLabel(int index) {
    final t = slots[index];
    return DateHelper.time12(DateTime(2000, 1, 1, t.hour, t.minute));
  }

  bool isBooked(int index) {
    final date = selectedDate;

    // already booked by someone else
    final bookedIndexes = _booked[date.weekday] ?? <int>[];
    if (bookedIndexes.contains(index)) return true;

    // time already passed today
    final slot = slots[index];
    final slotTime = DateTime(date.year, date.month, date.day, slot.hour, slot.minute);
    return slotTime.isBefore(DateTime.now());
  }

  void selectSlot(int index) {
    if (isBooked(index)) return;
    selectedSlot.value = index;
  }

  String get timezoneLabel {
    final offset = DateTime.now().timeZoneOffset;
    final sign = offset.isNegative ? '-' : '+';
    return 'GMT$sign${offset.inHours.abs()}';
  }

  // ---------- Mode & duration ----------
  void setMode(int index) => isOnline.value = index == 0;

  void increaseHours() {
    if (hours.value < 4) hours.value += 0.5;
  }

  void decreaseHours() {
    if (hours.value > 1) hours.value -= 0.5;
  }

  String get hoursNumber => hours.value == hours.value.roundToDouble()
      ? '${hours.value.round()}'
      : '${hours.value}';

  String get durationText => '$hoursNumber hr';

  // ---------- Fees ----------
  double get sessionFee => tutor.price * hours.value;

  double get total => sessionFee + serviceFee;

  String get feeLabel =>
      '\$${tutor.price.round()} x $hoursNumber ${hours.value == 1 ? 'hour' : 'hours'}';

  // ---------- Confirm ----------
  void confirmBooking() {
    if (selectedSlot.value == -1) {
      Get.snackbar('Pick a time', 'Please choose a time slot first.');
      return;
    }

    final date = selectedDate;
    final slot = slots[selectedSlot.value];
    final start = DateTime(date.year, date.month, date.day, slot.hour, slot.minute);

    final session = StudentSessionModel(
      id: 'booking_${DateTime.now().millisecondsSinceEpoch}',
      tutorName: tutor.name,
      subject: tutor.subject,
      image: tutor.image,
      start: start,
      durationMinutes: (hours.value * 60).round(),
      isOnline: isOnline.value,
      fee: total,
      status: StudentSessionStatus.pending,
    );

    // Add it to the Sessions page (create the controller if it isn't open yet)
    final sessionsController = Get.isRegistered<SessionsController>()
        ? Get.find<SessionsController>()
        : Get.put(SessionsController());
    sessionsController.addSession(session);
    sessionsController.selectTab(0); // show the Pending tab

    // Go back to the student home and open the Sessions tab
    Get.until((route) => route.settings.name == AppRoutes.studentHome);
    Get.find<StudentShellController>().changeTab(1);

    Get.snackbar('Request sent', 'Waiting for ${tutor.name} to confirm.');
  }
}