import 'package:flutter/material.dart';

import '../../widgets/tutor/tutor_bottom_nav.dart';
import 'dashboard/tutor_dashboard_screen.dart';
import 'profile/tutor_profile_screen.dart';
import 'schedule/schedule_screen.dart';

class TutorShell extends StatefulWidget {
  final VoidCallback? onLogout;

  const TutorShell({super.key, this.onLogout});

  @override
  State<TutorShell> createState() => _TutorShellState();
}

class _TutorShellState extends State<TutorShell> {
  int currentIndex = 0;

  void _selectTab(int index) => setState(() => currentIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          TutorDashboardScreen(onOpenSchedule: () => _selectTab(1)),
          const ScheduleScreen(),
          TutorProfileScreen(onLogout: widget.onLogout),
        ],
      ),
      bottomNavigationBar: TutorBottomNav(
        currentIndex: currentIndex,
        onTap: _selectTab,
      ),
    );
  }
}
