import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/controllers/explore_controller.dart';
import 'package:my_app/theme/app_colors.dart';
import 'package:my_app/widgets/student/category_chip.dart';
import 'package:my_app/widgets/student/featured_tutor_card.dart';
import 'package:my_app/widgets/student/section_title.dart';
import 'package:my_app/widgets/student/tutor_list_card.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ExploreController());
    final w = MediaQuery.of(context).size.width;
    final pad = w * 0.05;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, w, pad),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: pad),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: w * 0.05),
                  _buildSearchRow(controller, w),
                  SizedBox(height: w * 0.045),
                  _buildChips(controller),
                  SizedBox(height: w * 0.06),

                  // Featured
                  Text(
                    'FEATURED',
                    style: TextStyle(
                      fontSize: w * 0.026,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: w * 0.01),
                  const SectionTitle(title: 'Top tutors for you'),
                  SizedBox(height: w * 0.035),
                  FeaturedTutorCard(tutor: controller.featuredTutor),
                  SizedBox(height: w * 0.07),

                  // Popular
                  const SectionTitle(title: 'Popular near you'),
                  SizedBox(height: w * 0.035),
                  _buildTutorList(controller, w),
                  SizedBox(height: w * 0.04),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

    Widget _buildHeader(BuildContext context, double w, double pad) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(pad, topPadding + w * 0.05, pad, w * 0.07),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good morning,',
                  style: TextStyle(
                    fontSize: w * 0.033,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: w * 0.01),
                Text(
                  'Hey, Jamie!',
                  style: TextStyle(
                    fontSize: w * 0.07,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          // Profile avatar
          Container(
            width: w * 0.13,
            height: w * 0.13,
            decoration: BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.white, width: 3),
            ),
            child: const Icon(Icons.person, color: AppColors.primary),
          ),
        ],
      ),
    );
  }
  Widget _buildSearchRow(ExploreController controller, double w) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: w * 0.13,
            padding: EdgeInsets.symmetric(horizontal: w * 0.04),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: AppColors.textMuted),
                SizedBox(width: w * 0.02),
                Expanded(
                  child: TextField(
                    onChanged: controller.setSearch,
                    style: TextStyle(fontSize: w * 0.035),
                    decoration: InputDecoration(
                      hintText: 'Search tutors, subjects...',
                      hintStyle: const TextStyle(color: AppColors.textMuted),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: w * 0.03),
        Container(
          width: w * 0.13,
          height: w * 0.13,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.tune_rounded, color: AppColors.white),
        ),
      ],
    );
  }

  Widget _buildChips(ExploreController controller) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(
        () => Row(
          children: [
            for (final name in controller.categories)
              CategoryChip(
                label: name,
                isSelected: controller.selectedCategory.value == name,
                onTap: () => controller.selectCategory(name),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTutorList(ExploreController controller, double w) {
    return Obx(() {
      final list = controller.filteredTutors;

      if (list.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: w * 0.08),
          child: const Center(child: Text('No tutors found')),
        );
      }

      return Column(
        children: [
          for (final tutor in list)
            TutorListCard(
              tutor: tutor,
              isFavorite: controller.favorites.contains(tutor.id),
              onFavoriteTap: () => controller.toggleFavorite(tutor.id),
            ),
        ],
      );
    });
  }
}