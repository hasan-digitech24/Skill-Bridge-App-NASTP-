import 'package:get/get.dart';
import 'package:my_app/controllers/explore_controller.dart';
import 'package:my_app/models/explore_tutor_model.dart';
import 'package:my_app/models/review_model.dart';
import 'package:my_app/routes/app_routes.dart';

class TutorDetailController extends GetxController {
  late final ExploreTutorModel tutor;

  final tabs = ['About', 'Reviews', 'Schedule'];
  final selectedTab = 0.obs;
  final readMore = false.obs;

  final students = '620+';
  final experience = '6 yrs';

  final reviews = const [
    ReviewModel(
      studentName: 'Jamie R.',
      timeAgo: '2 weeks ago',
      rating: 5.0,
      comment: 'Explains everything so clearly. I built my first app in just three sessions!',
    ),
    ReviewModel(
      studentName: 'Omar K.',
      timeAgo: '1 month ago',
      rating: 4.8,
      comment: 'Very patient and well prepared. Highly recommended.',
    ),
    ReviewModel(
      studentName: 'Sana A.',
      timeAgo: '2 months ago',
      rating: 4.9,
      comment: 'Great sessions, practical examples and friendly teaching style.',
    ),
  ];

  final schedule = const [
    ['Monday - Friday', '9:00 AM - 5:00 PM'],
    ['Saturday', '10:00 AM - 2:00 PM'],
    ['Sunday', 'Off'],
  ];

  @override
  void onInit() {
    super.onInit();
    // The tutor comes from the Explore screen
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
  }

  String get designation => 'Senior ${tutor.subject} Tutor';

  String get about =>
      "I'm a ${tutor.subject} tutor and passionate educator who loves making complex "
      'concepts feel simple. My sessions are practical, friendly, and built around your goals. '
      'Together we will set a clear plan, practice with real examples, and track your progress '
      'after every lesson.';

  List<String> get skills =>
      [tutor.category, 'Problem Solving', 'Exam Prep', 'Projects'];

  ExploreController get _explore => Get.find<ExploreController>();

  bool get isFavorite => _explore.favorites.contains(tutor.id);

  void toggleFavorite() => _explore.toggleFavorite(tutor.id);

  void selectTab(int index) => selectedTab.value = index;

  void toggleReadMore() => readMore.value = !readMore.value;

    void bookSession() {
    Get.toNamed(AppRoutes.bookSession, arguments: tutor);
  }
}