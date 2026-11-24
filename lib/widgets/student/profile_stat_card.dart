import 'package:flutter/material.dart';
import 'package:my_app/theme/app_colors.dart';

class ProfileStatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String value;
  final String label;

  const ProfileStatCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(vertical: w * 0.04),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        children: [
          Container(
            width: w * 0.09,
            height: w * 0.09,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: w * 0.05, color: iconColor),
          ),
          SizedBox(height: w * 0.025),
          Text(
            value,
            style: TextStyle(
              fontSize: w * 0.042,
              fontWeight: FontWeight.w700,
              color: AppColors.navy,
            ),
          ),
          SizedBox(height: w * 0.005),
          Text(
            label,
            style: TextStyle(fontSize: w * 0.026, color: AppColors.textGrey),
          ),
        ],
      ),
    );
  }
}