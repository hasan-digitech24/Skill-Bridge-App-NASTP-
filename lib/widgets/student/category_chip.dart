import 'package:flutter/material.dart';
import 'package:my_app/theme/app_colors.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: w * 0.025),
        padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: w * 0.025),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: w * 0.034,
            fontWeight: FontWeight.w600,
            color: isSelected ? AppColors.white : AppColors.navy,
          ),
        ),
      ),
    );
  }
}