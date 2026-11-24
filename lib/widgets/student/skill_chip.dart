import 'package:flutter/material.dart';
import 'package:my_app/theme/app_colors.dart';

class SkillChip extends StatelessWidget {
  final String text;

  const SkillChip({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: w * 0.015),
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: w * 0.028,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
    );
  }
}