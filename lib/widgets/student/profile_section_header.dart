import 'package:flutter/material.dart';
import 'package:my_app/theme/app_colors.dart';

class ProfileSectionHeader extends StatelessWidget {
  final String label;
  final String title;

  const ProfileSectionHeader({
    super.key,
    required this.label,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final w = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: w * 0.025,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
            color: colors.primary,
          ),
        ),
        SizedBox(height: w * 0.01),
        Text(
          title,
          style: TextStyle(
            fontSize: w * 0.052,
            fontWeight: FontWeight.w500,
            color: colors.navy,
          ),
        ),
      ],
    );
  }
}
