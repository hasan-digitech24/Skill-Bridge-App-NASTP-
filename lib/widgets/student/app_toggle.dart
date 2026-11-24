import 'package:flutter/material.dart';
import 'package:my_app/theme/app_colors.dart';

class AppToggle extends StatelessWidget {
  final bool isOn;
  final VoidCallback onTap;

  const AppToggle({super.key, required this.isOn, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: w * 0.12,
        height: w * 0.065,
        padding: EdgeInsets.all(w * 0.008),
        alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
        decoration: BoxDecoration(
          color: isOn ? AppColors.primary : AppColors.border,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          width: w * 0.049,
          height: w * 0.049,
          decoration: const BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}