import 'package:flutter/material.dart';

import '../views/tutor/tutor_shell.dart';

class AppRoutes {
  static const String tutorHome = '/tutor';

  static Map<String, WidgetBuilder> get routes => {
    tutorHome: (context) => const TutorShell(),
  };
}
