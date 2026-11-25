import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/controllers/profile_controller.dart';
import 'package:my_app/theme/app_colors.dart';
import 'package:my_app/widgets/student/explore_tutor_image.dart';
import 'package:my_app/widgets/student/app_toggle.dart';
import 'package:my_app/widgets/student/profile_menu_tile.dart';
import 'package:my_app/widgets/student/profile_section_header.dart';
import 'package:my_app/widgets/student/profile_stat_card.dart';

class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({super.key});

  // Small blue tag like "Flutter"
  Widget _tag(String text, AppColorsExtension colors, double w) {
    return Container(
      margin: EdgeInsets.only(right: w * 0.015),
      padding: EdgeInsets.symmetric(horizontal: w * 0.022, vertical: w * 0.008),
      decoration: BoxDecoration(
        color: colors.lightBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: w * 0.025,
          fontWeight: FontWeight.w600,
          color: colors.primary,
        ),
      ),
    );
  }

  // Rounded box that holds several tiles
  Widget _group(List<Widget> children, AppColorsExtension colors, double w) {
    return Container(
      decoration: BoxDecoration(
        color: colors.cardBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: colors.cardShadow,
      ),
      child: Column(children: children),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ProfileController());
    final colors = context.colors;
    final w = MediaQuery.of(context).size.width;
    final pad = w * 0.05;

    return Scaffold(
      backgroundColor: colors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, c, colors, w, pad),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: pad),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: w * 0.06),

                  // ---------- LEARNING ----------
                  const ProfileSectionHeader(
                    label: 'LEARNING',
                    title: 'Your learning space',
                  ),
                  SizedBox(height: w * 0.035),
                  _group(
                    [
                      ProfileMenuTile(
                        icon: Icons.calendar_today_outlined,
                        iconColor: colors.primary,
                        iconBg: colors.lightBlue,
                        title: 'My sessions',
                        subtitle: 'View upcoming and completed lessons',
                        onTap: () => c.openTab(1),
                      ),
                      ProfileMenuTile(
                        icon: Icons.favorite_border,
                        iconColor: colors.red,
                        iconBg: colors.redLight,
                        title: 'Saved tutors',
                        subtitle: '${c.savedCount} tutors in your shortlist',
                        onTap: () => c.openTab(2),
                      ),
                      ProfileMenuTile(
                        icon: Icons.star_border_rounded,
                        iconColor: colors.orange,
                        iconBg: colors.amberLight,
                        title: 'Learning interests',
                        subtitle: 'Subjects used for recommendations',
                        showDivider: false,
                        trailing: const SizedBox(),
                        extra: Row(
                          children: [
                            for (final item in c.interests)
                              _tag(item, colors, w),
                          ],
                        ),
                      ),
                    ],
                    colors,
                    w,
                  ),
                  SizedBox(height: w * 0.07),

                  // ---------- ACCOUNT ----------
                  const ProfileSectionHeader(
                    label: 'ACCOUNT',
                    title: 'Settings',
                  ),
                  SizedBox(height: w * 0.035),
                  _group(
                    [
                      ProfileMenuTile(
                        icon: Icons.person_outline_rounded,
                        iconColor: colors.greenDark,
                        iconBg: colors.greenLight,
                        title: 'Personal information',
                        subtitle: 'Phone, location and contact details',
                        onTap: () => c.showMessage('Personal information'),
                      ),
                      ProfileMenuTile(
                        icon: Icons.bookmark_border,
                        iconColor: colors.purple,
                        iconBg: colors.purpleLight,
                        title: 'Payment methods',
                        subtitle: 'Visa ending in 4242',
                        onTap: () => c.showMessage('Payment methods'),
                      ),
                      ProfileMenuTile(
                        icon: Icons.notifications_none_rounded,
                        iconColor: colors.primary,
                        iconBg: colors.lightBlue,
                        title: 'Push notifications',
                        subtitle: 'Messages and booking updates',
                        trailing: Obx(
                          () => AppToggle(
                            isOn: c.pushOn.value,
                            onTap: c.togglePush,
                          ),
                        ),
                      ),
                      ProfileMenuTile(
                        icon: Icons.access_time_rounded,
                        iconColor: colors.orange,
                        iconBg: colors.amberLight,
                        title: 'Session reminders',
                        subtitle: 'Remind me 30 minutes before',
                        trailing: Obx(
                          () => AppToggle(
                            isOn: c.remindersOn.value,
                            onTap: c.toggleReminders,
                          ),
                        ),
                      ),
                      ProfileMenuTile(
                        icon: Icons.brightness_4_outlined,
                        iconColor: colors.textGrey,
                        iconBg: colors.lightBlue,
                        title: 'Dark mode',
                        subtitle: 'Reduce brightness in the evening',
                        showDivider: false,
                        trailing: Obx(
                          () => AppToggle(
                            isOn: c.darkOn.value,
                            onTap: c.toggleDark,
                          ),
                        ),
                      ),
                    ],
                    colors,
                    w,
                  ),
                  SizedBox(height: w * 0.08),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    ProfileController c,
    AppColorsExtension colors,
    double w,
    double pad,
  ) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(pad, topPadding + w * 0.04, pad, w * 0.06),
      decoration: BoxDecoration(
        color: colors.headerBg,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          // Top bar: back button, title, edit button
          Row(
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: w * 0.11,
                  height: w * 0.11,
                  decoration: BoxDecoration(
                    color: const Color(0x33FFFFFF),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.chevron_left_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    'My Profile',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => c.showMessage('Edit profile'),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.035,
                    vertical: w * 0.02,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0x33FFFFFF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: w * 0.05),

          // Avatar + name + email
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(w * 0.008),
                decoration: BoxDecoration(
                  color: const Color(0x66FFFFFF),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: TutorImage(
                  path: 'assets/png/jamie.png',
                  width: w * 0.2,
                  height: w * 0.2,
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              SizedBox(width: w * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c.name,
                      style: TextStyle(
                        fontSize: w * 0.055,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: w * 0.01),
                    Text(
                      c.email,
                      style: TextStyle(fontSize: w * 0.03, color: Colors.white),
                    ),
                    SizedBox(height: w * 0.01),
                    Text(
                      c.memberSince,
                      style: TextStyle(
                        fontSize: w * 0.026,
                        color: const Color(0xCCFFFFFF),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: w * 0.05),

          // 3 stat cards
          Row(
            children: [
              Expanded(
                child: ProfileStatCard(
                  icon: Icons.calendar_today_outlined,
                  iconColor: colors.primary,
                  iconBg: colors.lightBlue,
                  value: '${c.sessionsCount}',
                  label: 'Sessions',
                ),
              ),
              SizedBox(width: w * 0.025),
              Expanded(
                child: ProfileStatCard(
                  icon: Icons.access_time_rounded,
                  iconColor: colors.orange,
                  iconBg: colors.amberLight,
                  value: c.learningHours,
                  label: 'Learning',
                ),
              ),
              SizedBox(width: w * 0.025),
              Expanded(
                child: ProfileStatCard(
                  icon: Icons.bookmark_border,
                  iconColor: colors.greenDark,
                  iconBg: colors.greenLight,
                  value: '${c.savedCount}',
                  label: 'Saved tutors',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
