import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 48.h,
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          // Student Option
          Expanded(
            child: _buildRoleButton(
              context: context,
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
              context: context,
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
    required BuildContext context,
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final selectedBg = isDark ? const Color(0xFF18181A) : Colors.white;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? selectedBg : Colors.transparent,
          borderRadius: BorderRadius.circular(9.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
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
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
            ),
            SizedBox(width: 8.w),
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
