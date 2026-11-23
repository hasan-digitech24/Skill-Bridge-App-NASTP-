import 'package:flutter/material.dart';

import '../../models/session_model.dart';
import '../../theme/app_colors.dart';
import '../../utils/date_helper.dart';
import 'initials_avatar.dart';

class SessionCard extends StatelessWidget {
  final SessionModel session;
  final VoidCallback onMarkCompleted;

  const SessionCard({
    super.key,
    required this.session,
    required this.onMarkCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final badgeBackground =
        session.isOnline ? AppColors.lightBlue : AppColors.orangeLight;
    final badgeColor = session.isOnline ? AppColors.primary : AppColors.orange;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        children: [
          Row(
            children: [
              InitialsAvatar(name: session.studentName, size: 36, radius: 10),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session.studentName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.navy),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      session.subject,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 10, color: AppColors.textGrey),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeBackground,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  session.isOnline ? 'Online' : 'Home',
                  style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: badgeColor),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(height: 1, color: AppColors.divider),
          ),
          Row(
            children: [
              const Icon(Icons.access_time, size: 14, color: AppColors.primary),
              const SizedBox(width: 6),
              Text(
                DateHelper.durationLong(session.durationMinutes),
                style: const TextStyle(fontSize: 10, color: AppColors.textGrey),
              ),
              const SizedBox(width: 16),
              Icon(
                session.isOnline
                    ? Icons.videocam_outlined
                    : Icons.location_on_outlined,
                size: 14,
                color: AppColors.primary,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  session.placeText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                      const TextStyle(fontSize: 10, color: AppColors.textGrey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 36,
            child: session.isCompleted
                ? Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.greenLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle,
                            size: 14, color: AppColors.greenDark),
                        SizedBox(width: 6),
                        Text('Completed',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.greenDark)),
                      ],
                    ),
                  )
                : TextButton(
                    onPressed: onMarkCompleted,
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.lightBlue,
                      foregroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Mark Completed',
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w600)),
                  ),
          ),
        ],
      ),
    );
  }
}
