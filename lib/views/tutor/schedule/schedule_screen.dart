import 'package:flutter/material.dart';

import '../../../controllers/schedule_controller.dart';
import '../../../models/session_model.dart';
import '../../../theme/app_colors.dart';
import '../../../utils/date_helper.dart';
import '../../../widgets/tutor/empty_state.dart';
import '../../../widgets/tutor/session_card.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late final ScheduleController controller;

  @override
  void initState() {
    super.initState();
    controller = ScheduleController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final topPadding = MediaQuery.of(context).padding.top;
        final sessions = controller.sessionsForSelectedDate;

        return ColoredBox(
          color: AppColors.background,
          child: Column(
            children: [
              _buildTopCard(topPadding),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            controller.selectedDayLabel,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: AppColors.navy),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.lightBlue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            controller.classCountLabel,
                            style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    if (sessions.isEmpty)
                      const EmptyState(
                        icon: Icons.event_available_outlined,
                        title: 'No classes scheduled',
                        message:
                            'Accepted sessions will appear here on their date.',
                      )
                    else
                      for (int i = 0; i < sessions.length; i++)
                        _TimelineRow(
                          key: ValueKey(sessions[i].id),
                          session: sessions[i],
                          isLast: i == sessions.length - 1,
                          onMarkCompleted: () =>
                              controller.markCompleted(sessions[i].id),
                        ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTopCard(double topPadding) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, topPadding + 16, 16, 16),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('MY CALENDAR',
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                            color: AppColors.primary)),
                    SizedBox(height: 4),
                    Text('Schedule',
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                            color: AppColors.navy)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: controller.goToToday,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                  decoration: BoxDecoration(
                    color: AppColors.lightBlue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text('Today',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ArrowButton(
                  icon: Icons.chevron_left_rounded,
                  onTap: controller.previousMonth),
              Text(controller.monthLabel,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.navy)),
              _ArrowButton(
                  icon: Icons.chevron_right_rounded,
                  onTap: controller.nextMonth),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              for (final date in controller.weekDates)
                Expanded(child: _buildDayTile(date)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDayTile(DateTime date) {
    final selected = controller.isSelected(date);
    final today = controller.isToday(date);

    Color borderColor = AppColors.border;
    if (today) borderColor = AppColors.primary;

    return GestureDetector(
      onTap: () => controller.selectDate(date),
      child: Container(
        height: 58,
        margin: const EdgeInsets.symmetric(horizontal: 2.5),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: selected ? AppColors.primary : borderColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                DateHelper.weekdayShort(date).toUpperCase(),
                style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    color: selected
                        ? const Color(0xCCFFFFFF)
                        : AppColors.textGrey),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${date.day}',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: selected
                      ? AppColors.white
                      : (today ? AppColors.primary : AppColors.navy)),
            ),
          ],
        ),
      ),
    );
  }
}

class _ArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ArrowButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(icon, size: 22, color: AppColors.textGrey),
      ),
    );
  }
}

class _TimelineRow extends StatelessWidget {
  final SessionModel session;
  final bool isLast;
  final VoidCallback onMarkCompleted;

  const _TimelineRow({
    super.key,
    required this.session,
    required this.isLast,
    required this.onMarkCompleted,
  });

  @override
  Widget build(BuildContext context) {
    Color dotColor = session.isOnline ? AppColors.primary : AppColors.orange;
    Color ringColor =
        session.isOnline ? AppColors.lightBlue : AppColors.orangeLight;
    if (session.isCompleted) {
      dotColor = AppColors.green;
      ringColor = AppColors.greenLight;
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 44,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DateHelper.time24(session.start),
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.navy)),
                  const SizedBox(height: 2),
                  Text(DateHelper.time24(session.end),
                      style: const TextStyle(
                          fontSize: 10, color: AppColors.textMuted)),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 22,
            child: Column(
              children: [
                const SizedBox(height: 14),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: ringColor, spreadRadius: 3),
                    ],
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1.5,
                      margin: const EdgeInsets.only(top: 6),
                      color: AppColors.border,
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SessionCard(
                session: session,
                onMarkCompleted: onMarkCompleted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
