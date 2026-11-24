import 'package:flutter/material.dart';
import 'package:my_app/models/explore_tutor_model.dart';
import 'package:my_app/theme/app_colors.dart';
import 'package:my_app/widgets/student/explore_tutor_image.dart';

class FeaturedTutorCard extends StatelessWidget {
  final ExploreTutorModel tutor;
  final VoidCallback? onViewProfile;

  const FeaturedTutorCard({super.key, required this.tutor, this.onViewProfile});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final firstName = tutor.name.split(' ').first;

    return SizedBox(
      height: w * 0.48,
      child: Row(
        children: [
          // Left: blue info panel
          Expanded(
            flex: 11,
            child: Container(
              padding: EdgeInsets.all(w * 0.04),
              decoration: const BoxDecoration(
                color: Color(0xFF1E40AF),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(22),
                  bottomLeft: Radius.circular(22),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Badge
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: w * 0.025,
                      vertical: w * 0.01,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.amber,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'TOP RATED',
                      style: TextStyle(
                        fontSize: w * 0.025,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                  ),

                  // Title + rating
                  Text(
                    'Master ${tutor.category}\nwith $firstName',
                    style: TextStyle(
                      fontSize: w * 0.05,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                      height: 1.2,
                    ),
                  ),
                  Text(
                    '${tutor.rating} rating · 2k+ students',
                    style: TextStyle(
                      fontSize: w * 0.026,
                      color: AppColors.white,
                    ),
                  ),

                  // Button
                  GestureDetector(
                    onTap: onViewProfile,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: w * 0.035,
                        vertical: w * 0.02,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'View Profile >',
                        style: TextStyle(
                          fontSize: w * 0.03,
                          fontWeight: FontWeight.w700,
                          color: AppColors.navy,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Right: photo
          Expanded(
            flex: 9,
            child: TutorImage(
              path: tutor.image,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(22),
                bottomRight: Radius.circular(22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}