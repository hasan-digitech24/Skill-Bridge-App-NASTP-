import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/constants/app_colors.dart';
import 'package:my_app/constants/app_strings.dart';

class RoleToggleSwitch extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onRoleChanged;

  const RoleToggleSwitch({
    super.key,
    required this.selectedIndex,
    required this.onRoleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: AppColors.toggleBg,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          // Student Option
          Expanded(
            child: _buildRoleButton(
              title: AppStrings.student,
              icon: Icons.person_outline_rounded,
              isSelected: selectedIndex == 0,
              onTap: () => onRoleChanged(0),
            ),
          ),
          SizedBox(width: 4.w),
          // Tutor Option
          Expanded(
            child: _buildRoleButton(
              title: AppStrings.tutor,
              icon: Icons.star_border_rounded,
              isSelected: selectedIndex == 1,
              onTap: () => onRoleChanged(1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleButton({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(9.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18.sp,
              color: isSelected ? AppColors.primary : AppColors.grey,
            ),
            SizedBox(width: 8.w),
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? AppColors.primary : AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
