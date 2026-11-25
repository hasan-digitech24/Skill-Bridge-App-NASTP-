import 'package:flutter/material.dart';
import 'package:my_app/theme/app_colors.dart';

class TimeSlotTile extends StatelessWidget {
  final String label;
  final bool isSelected;
  final bool isBooked;
  final VoidCallback onTap;

  const TimeSlotTile({
    super.key,
    required this.label,
    required this.isSelected,
    required this.isBooked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final w = MediaQuery.of(context).size.width;

    Color bgColor = colors.cardBg;
    Color borderColor = colors.border;
    Color textColor = colors.navy;

    if (isBooked) {
      bgColor = colors.divider;
      borderColor = colors.divider;
      textColor = colors.textMuted;
    } else if (isSelected) {
      bgColor = colors.primary;
      borderColor = colors.primary;
      textColor = Colors.white;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: w * 0.105,
        margin: EdgeInsets.all(w * 0.012),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: w * 0.03,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
