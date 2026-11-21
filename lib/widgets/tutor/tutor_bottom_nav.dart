import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class TutorBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const TutorBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const List<IconData> _icons = [
    Icons.grid_view_rounded,
    Icons.calendar_today_rounded,
    Icons.person_rounded,
  ];
  static const List<String> _labels = ['Requests', 'Schedule', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              for (int i = 0; i < _labels.length; i++)
                Expanded(
                  child: InkWell(
                    onTap: () => onTap(i),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _icons[i],
                          size: 22,
                          color: i == currentIndex
                              ? AppColors.primary
                              : AppColors.textMuted,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          _labels[i],
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: i == currentIndex
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: i == currentIndex
                                ? AppColors.primary
                                : AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
