import 'package:flutter/material.dart';
import 'package:my_app/models/review_model.dart';
import 'package:my_app/theme/app_colors.dart';
import 'package:my_app/widgets/tutor/initials_avatar.dart';

class ReviewCard extends StatelessWidget {
  final ReviewModel review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: w * 0.03),
      padding: EdgeInsets.all(w * 0.035),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InitialsAvatar(name: review.studentName, size: w * 0.09, radius: 10),
              SizedBox(width: w * 0.025),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.studentName,
                      style: TextStyle(
                        fontSize: w * 0.031,
                        fontWeight: FontWeight.w700,
                        color: AppColors.navy,
                      ),
                    ),
                    Text(
                      review.timeAgo,
                      style: TextStyle(
                        fontSize: w * 0.025,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.star_rounded, color: AppColors.amber, size: w * 0.04),
              SizedBox(width: w * 0.008),
              Text(
                review.rating.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: w * 0.03,
                  fontWeight: FontWeight.w700,
                  color: AppColors.navy,
                ),
              ),
            ],
          ),
          SizedBox(height: w * 0.025),
          Text(
            '"${review.comment}"',
            style: TextStyle(
              fontSize: w * 0.028,
              color: AppColors.textGrey,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}