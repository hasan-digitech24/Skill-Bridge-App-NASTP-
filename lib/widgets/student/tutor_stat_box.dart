import 'package:flutter/material.dart';
import 'package:my_app/theme/app_colors.dart';

class TutorStatBox extends StatelessWidget {
  final String value;
  final String label;
  final IconData? icon; // optional icon before the value (the star)
  final Color? iconColor;

  const TutorStatBox({
    super.key,
    required this.value,
    required this.label,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(vertical: w * 0.035),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: w * 0.045, color: iconColor),
                SizedBox(width: w * 0.01),
              ],
              Text(
                value,
                style: TextStyle(
                  fontSize: w * 0.042,
                  fontWeight: FontWeight.w700,
                  color: AppColors.navy,
                ),
              ),
            ],
          ),
          SizedBox(height: w * 0.008),
          Text(
            label,
            style: TextStyle(fontSize: w * 0.026, color: AppColors.textGrey),
          ),
        ],
      ),
    );
  }
}