import 'package:flutter/material.dart';
import 'package:my_app/models/student_session_model.dart';
import 'package:my_app/theme/app_colors.dart';
import 'package:my_app/utils/date_helper.dart';
import 'package:my_app/widgets/student/explore_tutor_image.dart';

class StudentSessionCard extends StatelessWidget {
  final StudentSessionModel session;
  final VoidCallback onCancel;
  final VoidCallback onPrimaryTap;

  const StudentSessionCard({
    super.key,
    required this.session,
    required this.onCancel,
    required this.onPrimaryTap,
  });

  String get _buttonText {
    if (session.status == StudentSessionStatus.completed) return 'Book again';
    if (session.status == StudentSessionStatus.confirmed && session.isOnline) {
      return 'Join session';
    }
    return 'View details';
  }

  String get _statusText {
    if (session.status == StudentSessionStatus.pending) return 'Pending';
    if (session.status == StudentSessionStatus.confirmed) return 'Confirmed';
    return 'Completed';
  }

  Color _statusBg(AppColorsExtension colors) {
    if (session.status == StudentSessionStatus.pending)
      return colors.amberLight;
    if (session.status == StudentSessionStatus.confirmed)
      return colors.greenLight;
    return colors.lightBlue;
  }

  Color _statusColor(AppColorsExtension colors) {
    if (session.status == StudentSessionStatus.pending) return colors.amber;
    if (session.status == StudentSessionStatus.confirmed)
      return colors.greenDark;
    return colors.primary;
  }

  Widget _infoItem(
    IconData icon,
    String text,
    AppColorsExtension colors,
    double w,
  ) {
    return Row(
      children: [
        Icon(icon, size: w * 0.045, color: colors.primary),
        SizedBox(width: w * 0.02),
        Text(
          text,
          style: TextStyle(fontSize: w * 0.027, color: colors.textGrey),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final w = MediaQuery.of(context).size.width;
    final start = session.start;

    final dateText =
        '${DateHelper.weekdayShort(start)}, ${DateHelper.monthShort(start)} ${start.day}';
    final timeText =
        '${DateHelper.time12(start)} · ${DateHelper.durationShort(session.durationMinutes)}';

    final canCancel = session.status != StudentSessionStatus.completed;

    return Container(
      margin: EdgeInsets.only(bottom: w * 0.04),
      padding: EdgeInsets.all(w * 0.035),
      decoration: BoxDecoration(
        color: colors.cardBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: colors.cardShadow,
      ),
      child: Column(
        children: [
          Row(
            children: [
              TutorImage(
                path: session.image,
                width: w * 0.12,
                height: w * 0.12,
              ),
              SizedBox(width: w * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session.tutorName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: w * 0.038,
                        fontWeight: FontWeight.w600,
                        color: colors.navy,
                      ),
                    ),
                    SizedBox(height: w * 0.008),
                    Text(
                      session.subject,
                      style: TextStyle(
                        fontSize: w * 0.029,
                        color: colors.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: w * 0.03,
                  vertical: w * 0.012,
                ),
                decoration: BoxDecoration(
                  color: _statusBg(colors),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _statusText,
                  style: TextStyle(
                    fontSize: w * 0.026,
                    fontWeight: FontWeight.w600,
                    color: _statusColor(colors),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: w * 0.035),

          // Info box: date, time, mode
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(w * 0.035),
            decoration: BoxDecoration(
              color: colors.background,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _infoItem(
                        Icons.calendar_today_outlined,
                        dateText,
                        colors,
                        w,
                      ),
                    ),
                    Expanded(
                      child: _infoItem(
                        Icons.access_time_rounded,
                        timeText,
                        colors,
                        w,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: w * 0.03),
                Row(
                  children: [
                    _infoItem(
                      session.isOnline
                          ? Icons.videocam_outlined
                          : Icons.location_on_outlined,
                      session.isOnline ? 'Online session' : 'Home session',
                      colors,
                      w,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: w * 0.035),

          // Bottom: fee, cancel, main button
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Session fee',
                      style: TextStyle(
                        fontSize: w * 0.025,
                        color: colors.textGrey,
                      ),
                    ),
                    SizedBox(height: w * 0.005),
                    Text(
                      '\$${session.fee.round()}',
                      style: TextStyle(
                        fontSize: w * 0.045,
                        fontWeight: FontWeight.w700,
                        color: colors.navy,
                      ),
                    ),
                  ],
                ),
              ),
              if (canCancel) ...[
                GestureDetector(
                  onTap: onCancel,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: w * 0.04,
                      vertical: w * 0.025,
                    ),
                    decoration: BoxDecoration(
                      color: colors.cardBg,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colors.border),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: w * 0.03,
                        fontWeight: FontWeight.w600,
                        color: colors.textGrey,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: w * 0.025),
              ],
              GestureDetector(
                onTap: onPrimaryTap,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.045,
                    vertical: w * 0.025,
                  ),
                  decoration: BoxDecoration(
                    color: colors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _buttonText,
                    style: TextStyle(
                      fontSize: w * 0.03,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
