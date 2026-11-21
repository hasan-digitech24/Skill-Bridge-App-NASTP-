import 'package:flutter/foundation.dart';

import '../data/tutor_repository.dart';
import '../models/availability_model.dart';
import '../models/subject_model.dart';
import '../models/tutor_model.dart';
import '../utils/date_helper.dart';

class TutorProfileController extends ChangeNotifier {
  final TutorRepository _repo = TutorRepository.instance;

  // Editable copy. It is only written to the repository when save() succeeds.
  late TutorModel draft;
  String rateText = '';
  bool isEditingAbout = false;
  int selectedWeekday = DateTime.now().weekday;

  TutorProfileController() {
    draft = _repo.tutor.copy();
    rateText = _formatRate(draft.hourlyRate);
  }

  String _formatRate(double rate) {
    if (rate == 0) return '';
    return rate == rate.roundToDouble()
        ? rate.round().toString()
        : rate.toString();
  }

  // ---------- Basic info ----------

  void updateBasicInfo(String name, String designation) {
    if (name.trim().isNotEmpty) draft.name = name.trim();
    draft.designation = designation.trim();
    notifyListeners();
  }

  void toggleAboutEditing() {
    isEditingAbout = !isEditingAbout;
    notifyListeners();
  }

  void setAbout(String text) {
    draft.about = text;
  }

  // ---------- Subjects ----------

  // Returns false when the subject is empty or already added.
  bool addSubject(String name) {
    final clean = name.trim();
    if (clean.isEmpty) return false;
    final exists =
        draft.subjects.any((s) => s.name.toLowerCase() == clean.toLowerCase());
    if (exists) return false;
    draft.subjects.add(SubjectModel(clean));
    notifyListeners();
    return true;
  }

  void removeSubject(String name) {
    draft.subjects.removeWhere((s) => s.name == name);
    notifyListeners();
  }

  // ---------- Rate & modes ----------

  void setRate(String text) {
    rateText = text;
  }

  void setOnline(bool value) {
    draft.teachesOnline = value;
    notifyListeners();
  }

  void setHomeVisit(bool value) {
    draft.teachesAtHome = value;
    notifyListeners();
  }

  // ---------- Availability ----------

  AvailabilityModel get availability => draft.availability;

  DateTime get selectedWeekdayDate {
    final monday = DateHelper.startOfWeek(DateTime.now());
    return DateTime(monday.year, monday.month, monday.day + selectedWeekday - 1);
  }

  void nextDay() {
    selectedWeekday = selectedWeekday == 7 ? 1 : selectedWeekday + 1;
    notifyListeners();
  }

  bool isSlotOn(int hour) => availability.isSlotOn(selectedWeekday, hour);

  void toggleSlot(int hour) {
    availability.toggleSlot(selectedWeekday, hour);
    notifyListeners();
  }

  void toggleAvailability() {
    availability.isOn = !availability.isOn;
    notifyListeners();
  }

  // ---------- Save ----------

  // Returns an error message, or null when saved.
  String? save() {
    final rate = rateText.trim().isEmpty ? 0.0 : double.tryParse(rateText.trim());
    if (rate == null || rate < 0) return 'Enter a valid hourly rate';
    if (!draft.teachesOnline && !draft.teachesAtHome) {
      return 'Select at least one teaching mode';
    }
    draft.hourlyRate = rate;
    _repo.updateTutor(draft.copy());
    return null;
  }
}
