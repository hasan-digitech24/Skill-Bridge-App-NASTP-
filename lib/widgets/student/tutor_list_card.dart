import 'package:flutter/material.dart';
import 'package:my_app/models/explore_tutor_model.dart';
import 'package:my_app/theme/app_colors.dart';
import 'package:my_app/widgets/student/explore_tutor_image.dart';

class TutorListCard extends StatelessWidget {
  final ExploreTutorModel tutor;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;
  final VoidCallback? onTap;

  const TutorListCard({
    super.key,
    required this.tutor,
    required this.isFavorite,
    required this.onFavoriteTap,
    required this.onTap
  });

  Widget _tag(String text, double w) {
    return Container(
      margin: EdgeInsets.only(right: w * 0.015),
      padding: EdgeInsets.symmetric(horizontal: w * 0.02, vertical: w * 0.008),
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: w * 0.026,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: w * 0.035),
        padding: EdgeInsets.all(w * 0.025),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: AppColors.cardShadow,
        ),
        child: Row(
          children: [
            // Photo
            TutorImage(path: tutor.image, width: w * 0.2, height: w * 0.2),
            SizedBox(width: w * 0.035),
      
            // Middle: name, subject, rating, tags
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          tutor.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: w * 0.038,
                            fontWeight: FontWeight.w600,
                            color: AppColors.navy,
                          ),
                        ),
                      ),
                      SizedBox(width: w * 0.015),
                      Icon(Icons.verified, color: AppColors.primary, size: w * 0.05),
                    ],
                  ),
                  SizedBox(height: w * 0.008),
                  Text(
                    tutor.subject,
                    style: TextStyle(fontSize: w * 0.029, color: AppColors.textGrey),
                  ),
                  SizedBox(height: w * 0.012),
                  Row(
                    children: [
                      Icon(Icons.star_rounded, color: AppColors.amber, size: w * 0.04),
                      SizedBox(width: w * 0.01),
                      Text(
                        '${tutor.rating}',
                        style: TextStyle(
                          fontSize: w * 0.031,
                          fontWeight: FontWeight.w700,
                          color: AppColors.navy,
                        ),
                      ),
                      SizedBox(width: w * 0.01),
                      Text(
                        '(${tutor.reviews})',
                        style: TextStyle(
                          fontSize: w * 0.028,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: w * 0.015),
                  Row(
                    children: [
                      if (tutor.isOnline) _tag('Online', w),
                      if (tutor.isHome) _tag('Home', w),
                    ],
                  ),
                ],
              ),
            ),
      
            SizedBox(
              height: w * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: onFavoriteTap,
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? AppColors.red : AppColors.textMuted,
                      size: w * 0.06,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$${tutor.price.round()}',
                        style: TextStyle(
                          fontSize: w * 0.045,
                          fontWeight: FontWeight.w700,
                          color: AppColors.navy,
                        ),
                      ),
                      Text(
                        '/hr',
                        style: TextStyle(
                          fontSize: w * 0.026,
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}