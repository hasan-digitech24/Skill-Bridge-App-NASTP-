import 'package:flutter/material.dart';
import 'package:my_app/theme/app_colors.dart';
import 'package:my_app/utils/date_helper.dart';

class DateTile extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final VoidCallback onTap;

  const DateTile({
    super.key,
    required this.date,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: w * 0.17,
        margin: EdgeInsets.symmetric(horizontal: w * 0.006),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
          ),
          boxShadow: isSelected
              ? const [
                  BoxShadow(
                    color: Color(0x4D2863F0),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateHelper.weekdayShort(date).toUpperCase(),
              style: TextStyle(
                fontSize: w * 0.022,
                fontWeight: FontWeight.w500,
                color: isSelected ? AppColors.white : AppColors.textGrey,
              ),
            ),
            SizedBox(height: w * 0.012),
            Text(
              '${date.day}',
              style: TextStyle(
                fontSize: w * 0.045,
                fontWeight: FontWeight.w700,
                color: isSelected ? AppColors.white : AppColors.navy,
              ),
            ),
          ],
        ),
      ),
    );
  }
}