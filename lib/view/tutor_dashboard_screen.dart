import 'package:flutter/material.dart';

import '../../../controllers/tutor_dashboard_controller.dart';
import '../../../theme/app_colors.dart';
import '../../../utils/date_helper.dart';
import '../../../widgets/tutor/booking_request_card.dart';
import '../../../widgets/tutor/empty_state.dart';
import '../../../widgets/tutor/statistics_card.dart';

class TutorDashboardScreen extends StatefulWidget {
  final VoidCallback? onOpenSchedule;

  const TutorDashboardScreen({super.key, this.onOpenSchedule});

  @override
  State<TutorDashboardScreen> createState() => _TutorDashboardScreenState();
}

class _TutorDashboardScreenState extends State<TutorDashboardScreen> {
  late final TutorDashboardController controller;

  @override
  void initState() {
    super.initState();
    controller = TutorDashboardController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _showMessage(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final topPadding = MediaQuery.of(context).padding.top;
        return ColoredBox(
          color: AppColors.background,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildHeader(topPadding),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 22, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'NEW REQUESTS',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _buildSectionTitle(),
                    const SizedBox(height: 14),
                    _buildRequests(),
                    _buildNextClass(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(double topPadding) {
    final earningsChange = controller.earningsChangePercent;
    Color noteColor = AppColors.textMuted;
    if (earningsChange != null) {
      noteColor = earningsChange >= 0 ? AppColors.green : AppColors.red;
    }

    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: topPadding + 112,
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16, topPadding + 18, 16, 0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.dateLabel,
                          style: const TextStyle(
                            fontSize: 10,
                            letterSpacing: 0.5,
                            color: Color(0xCCFFFFFF),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${controller.greeting}, ${controller.tutorFirstName}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showMessage(controller.notificationMessage),
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: const Color(0x33FFFFFF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Icon(
                            Icons.notifications_none_rounded,
                            color: AppColors.white,
                            size: 22,
                          ),
                          if (controller.pendingCount > 0)
                            Positioned(
                              top: 10,
                              right: 11,
                              child: Container(
                                width: 7,
                                height: 7,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFF6B6B),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: StatisticsCard(
                        icon: Icons.star_border_rounded,
                        iconColor: AppColors.amber,
                        iconBackground: AppColors.amberLight,
                        label: 'Earnings',
                        value:
                            '\$${DateHelper.withCommas(controller.totalEarnings)}',
                        note: controller.earningsNote,
                        noteColor: noteColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: StatisticsCard(
                        icon: Icons.access_time_rounded,
                        iconColor: AppColors.primary,
                        iconBackground: AppColors.lightBlue,
                        label: 'Pending',
                        value: '${controller.pendingCount}',
                        note: 'Requests',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: StatisticsCard(
                        icon: Icons.calendar_today_outlined,
                        iconColor: AppColors.primary,
                        iconBackground: AppColors.lightBlue,
                        label: 'Upcoming',
                        value: '${controller.upcomingCount}',
                        note: 'This week',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'Waiting for you',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColors.navy,
          ),
        ),
        if (controller.canToggleViewAll)
          GestureDetector(
            onTap: controller.toggleViewAll,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                controller.showAll ? 'Show less' : 'View all',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildRequests() {
    final requests = controller.visibleRequests;
    if (requests.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(bottom: 12),
        child: EmptyState(
          icon: Icons.inbox_outlined,
          title: 'No new requests',
          message: 'New booking requests from students will appear here.',
        ),
      );
    }
    return Column(
      children: [
        for (final request in requests)
          BookingRequestCard(
            key: ValueKey(request.id),
            request: request,
            onAccept: () {
              controller.acceptRequest(request.id);
              _showMessage('Request accepted. Added to your schedule.');
            },
            onDecline: () {
              controller.declineRequest(request.id);
              _showMessage('Request declined.');
            },
          ),
      ],
    );
  }

  Widget _buildNextClass() {
    if (controller.nextClass == null) return const SizedBox.shrink();
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.fromLTRB(16, 14, 14, 14),
      decoration: BoxDecoration(
        color: AppColors.navy,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'TODAY',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                    color: Color(0xFF6B93FF),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  controller.nextClassTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  controller.nextClassSubtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: widget.onOpenSchedule,
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: AppColors.navyLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.white,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
