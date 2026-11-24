import 'package:flutter/material.dart';
import 'package:my_app/theme/app_colors.dart';

class ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final Widget? trailing; // default is an arrow
  final Widget? extra; // optional widget under the subtitle
  final bool showDivider;
  final VoidCallback? onTap;

  const ProfileMenuTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.extra,
    this.showDivider = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.04,
              vertical: w * 0.035,
            ),
            child: Row(
              children: [
                Container(
                  width: w * 0.11,
                  height: w * 0.11,
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, size: w * 0.055, color: iconColor),
                ),
                SizedBox(width: w * 0.035),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: w * 0.033,
                          fontWeight: FontWeight.w600,
                          color: AppColors.navy,
                        ),
                      ),
                      SizedBox(height: w * 0.008),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: w * 0.026,
                          color: AppColors.textMuted,
                        ),
                      ),
                      if (extra != null) ...[
                        SizedBox(height: w * 0.02),
                        extra!,
                      ],
                    ],
                  ),
                ),
                SizedBox(width: w * 0.02),
                trailing ??
                    Icon(
                      Icons.chevron_right_rounded,
                      size: w * 0.06,
                      color: AppColors.textMuted,
                    ),
              ],
            ),
          ),
          if (showDivider)
            Container(height: 1, color: AppColors.divider),
        ],
      ),
    );
  }
}