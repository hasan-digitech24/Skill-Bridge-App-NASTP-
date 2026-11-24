import 'package:get/get.dart';
import 'package:my_app/routes/app_routes.dart';
import 'package:my_app/view/create_account_screen.dart';
import 'package:my_app/view/login_screen.dart';
import 'package:my_app/view/onboarding_screen.dart';
import 'package:my_app/view/splash_screen.dart';
import 'package:my_app/view/tutor_bottom_nav.dart';

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
  ];
}
