import 'availability_model.dart';
import 'subject_model.dart';

class TutorModel {
  String id;
  String name;
  String designation;
  String about;
  double hourlyRate;
  String currencySymbol;
  List<SubjectModel> subjects;
  bool teachesOnline;
  bool teachesAtHome;
  bool isVerified;
  AvailabilityModel availability;

  TutorModel({
    this.id = '',
    this.name = 'Tutor',
    this.designation = '',
    this.about = '',
    this.hourlyRate = 0,
    this.currencySymbol = '\$',
    List<SubjectModel>? subjects,
    this.teachesOnline = true,
    this.teachesAtHome = false,
    this.isVerified = false,
    AvailabilityModel? availability,
  })  : subjects = subjects ?? [],
        availability = availability ?? AvailabilityModel();

  String get firstName {
    final parts = name.trim().split(' ');
    return parts.first.isEmpty ? 'Tutor' : parts.first;
  }

  TutorModel copy() {
    return TutorModel(
      id: id,
      name: name,
      designation: designation,
      about: about,
      hourlyRate: hourlyRate,
      currencySymbol: currencySymbol,
      subjects: List<SubjectModel>.from(subjects),
      teachesOnline: teachesOnline,
      teachesAtHome: teachesAtHome,
      isVerified: isVerified,
      availability: availability.copy(),
    );
  }
}
