import 'package:flutter/material.dart';
import 'package:my_app/theme/app_colors.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const SectionTitle({super.key, required this.title, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final w = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: w * 0.05,
            fontWeight: FontWeight.w600,
            color: colors.navy,
          ),
        ),
        GestureDetector(
          onTap: onSeeAll,
          child: Text(
            'See all',
            style: TextStyle(
              fontSize: w * 0.032,
              fontWeight: FontWeight.w600,
              color: colors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
