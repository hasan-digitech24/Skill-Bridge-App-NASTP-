import 'package:get/get.dart';
import 'package:my_app/routes/app_routes.dart';
import 'package:my_app/view/create_account_screen.dart';
import 'package:my_app/view/login_screen.dart';
import 'package:my_app/view/onboarding_screen.dart';
import 'package:my_app/view/create_account_screen.dart';
import 'package:my_app/view/login_screen.dart';
import 'package:my_app/view/onboarding_screen.dart';
import 'package:my_app/view/splash_screen.dart';
import 'package:my_app/view/tutor_bottom_nav.dart';
import 'package:my_app/view/student_bottom_nav.dart';
import 'package:my_app/view/student_profile_screen.dart';
import 'package:my_app/view/tutor_detail_screen.dart';
import 'package:my_app/view/book_session_screen.dart';

class AppPages {
  static const String initial = AppRoutes.splash;

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => const CreateAccountView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.tutorBottomNav,
      page: () => const TutorShell(),
      transition: Transition.rightToLeft,
    ),
        GetPage(
      name: AppRoutes.studentHome,
      page: () => const StudentShell(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.studentProfile,
      page: () => const StudentProfileScreen(),
      transition: Transition.rightToLeft,
    ),
        GetPage(
      name: AppRoutes.tutorDetail,
      page: () => const TutorDetailScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.bookSession,
      page: () => const BookSessionScreen(),
      transition: Transition.rightToLeft,
    ),
    
  ];
}
