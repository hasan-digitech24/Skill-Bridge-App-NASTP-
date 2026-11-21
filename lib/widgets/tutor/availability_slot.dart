import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../utils/date_helper.dart';

class AvailabilitySlot extends StatelessWidget {
  final int hour;
  final bool isOn;
  final VoidCallback onTap;

  const AvailabilitySlot({
    super.key,
    required this.hour,
    required this.isOn,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: isOn ? AppColors.greenLight : AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: isOn ? AppColors.greenBorder : AppColors.border),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateHelper.hour24(hour),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: isOn ? AppColors.greenDark : AppColors.textGrey,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              isOn ? 'ON' : 'OFF',
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w600,
                color: isOn ? AppColors.greenDark : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
