import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/controllers/profile_controller.dart';
import 'package:my_app/theme/app_colors.dart';
import 'package:my_app/widgets/student/profile_menu_tile.dart';

class PhotoOptionsSheet extends StatelessWidget {
  const PhotoOptionsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProfileController>();
    final w = MediaQuery.of(context).size.width;
    final bottomSafe = MediaQuery.of(context).padding.bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(
        w * 0.05,
        w * 0.03,
        w * 0.05,
        bottomSafe + w * 0.05,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: w * 0.1,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          SizedBox(height: w * 0.045),

          Text(
            'Profile photo',
            style: TextStyle(
              fontSize: w * 0.05,
              fontWeight: FontWeight.w500,
              color: AppColors.navy,
            ),
          ),
          SizedBox(height: w * 0.03),

          // Options
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                ProfileMenuTile(
                  icon: Icons.photo_camera_outlined,
                  iconColor: AppColors.primary,
                  iconBg: AppColors.lightBlue,
                  title: 'Open camera',
                  subtitle: 'Take a new photo',
                  onTap: () => c.pickImage(ImageSource.camera),
                ),
                ProfileMenuTile(
                  icon: Icons.photo_library_outlined,
                  iconColor: AppColors.greenDark,
                  iconBg: AppColors.greenLight,
                  title: 'Select from Gallery',
                  subtitle: 'Choose an existing photo',
                  showDivider: false,
                  onTap: () => c.pickImage(ImageSource.gallery),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}