import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/controllers/sessions_controller.dart';
import 'package:my_app/models/student_session_model.dart';
import 'package:my_app/theme/app_colors.dart';
import 'package:my_app/widgets/student/session_tab_bar.dart';
import 'package:my_app/widgets/student/student_session_card.dart';

class SessionsScreen extends StatelessWidget {
  const SessionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(SessionsController());
    final colors = context.colors;
    final w = MediaQuery.of(context).size.width;
    final pad = w * 0.05;
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: colors.background,
      body: Obx(() {
        final list = c.currentSessions;

        return Column(
          children: [
            // ---------- Header ----------
            Container(
              width: double.infinity,
              color: colors.cardBg,
              padding: EdgeInsets.fromLTRB(pad, topPadding + w * 0.05, pad, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'MY LEARNING',
                              style: TextStyle(
                                fontSize: w * 0.025,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                                color: colors.primary,
                              ),
                            ),
                            SizedBox(height: w * 0.01),
                            Text(
                              'Sessions',
                              style: TextStyle(
                                fontSize: w * 0.07,
                                fontWeight: FontWeight.w500,
                                color: colors.navy,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: w * 0.12,
                        height: w * 0.12,
                        decoration: BoxDecoration(
                          color: colors.lightBlue,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          Icons.calendar_today_outlined,
                          color: colors.primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: w * 0.03),

                  // Tabs (only "Confirmed" shows a count badge, like the design)
                  SessionTabBar(
                    labels: c.tabs,
                    selectedIndex: c.selectedTab.value,
                    badges: [0, c.confirmedCount, 0],
                    onTap: c.selectTab,
                  ),
                ],
              ),
            ),

            // ---------- List ----------
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(pad, w * 0.05, pad, w * 0.05),
                children: [
                  Text(
                    c.sectionLabel,
                    style: TextStyle(
                      fontSize: w * 0.025,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                      color: colors.textMuted,
                    ),
                  ),
                  SizedBox(height: w * 0.035),

                  if (list.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: w * 0.1),
                      decoration: BoxDecoration(
                        color: colors.cardBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'No sessions here yet',
                          style: TextStyle(
                            fontSize: w * 0.035,
                            color: colors.textGrey,
                          ),
                        ),
                      ),
                    ),

                  for (final session in list)
                    StudentSessionCard(
                      session: session,
                      onCancel: () => c.cancelSession(session.id),
                      onPrimaryTap: () {
                        if (session.status == StudentSessionStatus.completed) {
                          c.bookAgain(session);
                        } else if (session.isOnline &&
                            session.status == StudentSessionStatus.confirmed) {
                          c.joinSession(session);
                        } else {
                          c.viewDetails(session);
                        }
                      },
                    ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
