import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/controllers/tutor_detail_controller.dart';
import 'package:my_app/theme/app_colors.dart';
import 'package:my_app/widgets/student/session_tab_bar.dart';
import 'package:my_app/widgets/student/review_card.dart';
import 'package:my_app/widgets/student/skill_chip.dart';
import 'package:my_app/widgets/student/tutor_stat_box.dart';

class TutorDetailScreen extends StatelessWidget {
  const TutorDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(TutorDetailController());
    final colors = context.colors;
    final w = MediaQuery.of(context).size.width;
    final pad = w * 0.05;
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: colors.cardBg,
      body: Column(
        children: [
          // Scrollable part
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildPhoto(c, colors, w, pad, topPadding),

                  // Card that slides up over the photo
                  Container(
                    width: double.infinity,
                    transform: Matrix4.translationValues(0, -w * 0.07, 0),
                    padding: EdgeInsets.fromLTRB(pad, w * 0.06, pad, 0),
                    decoration: BoxDecoration(
                      color: colors.cardBg,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildNameRow(c, colors, w),
                        SizedBox(height: w * 0.01),
                        Text(
                          c.designation,
                          style: TextStyle(
                            fontSize: w * 0.029,
                            color: colors.textGrey,
                          ),
                        ),
                        SizedBox(height: w * 0.045),
                        _buildStats(c, colors, w),
                        SizedBox(height: w * 0.04),

                        // Tabs
                        Obx(
                          () => SessionTabBar(
                            labels: c.tabs,
                            selectedIndex: c.selectedTab.value,
                            badges: const [0, 0, 0],
                            onTap: c.selectTab,
                          ),
                        ),
                        SizedBox(height: w * 0.05),

                        // Tab content
                        Obx(() {
                          if (c.selectedTab.value == 1) {
                            return _buildReviews(c);
                          }
                          if (c.selectedTab.value == 2) {
                            return _buildSchedule(c, colors, w);
                          }
                          return _buildAbout(c, colors, w);
                        }),
                        SizedBox(height: w * 0.05),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Fixed bottom bar
          _buildBottomBar(c, colors, w, pad),
        ],
      ),
    );
  }

  // ---------- Photo with back + heart buttons ----------
  Widget _buildPhoto(
    TutorDetailController c,
    AppColorsExtension colors,
    double w,
    double pad,
    double topPadding,
  ) {
    return Container(
      width: double.infinity,
      height: w * 0.85,
      padding: EdgeInsets.fromLTRB(pad, topPadding + w * 0.03, pad, 0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(c.tutor.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back button
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: w * 0.105,
                  height: w * 0.105,
                  decoration: BoxDecoration(
                    color: colors.cardBg,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.chevron_left_rounded,
                    color: colors.navy,
                    size: w * 0.07,
                  ),
                ),
              ),

              // Heart button
              GestureDetector(
                onTap: c.toggleFavorite,
                child: Container(
                  width: w * 0.105,
                  height: w * 0.105,
                  decoration: BoxDecoration(
                    color: colors.cardBg,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Obx(
                    () => Icon(
                      c.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: c.isFavorite ? colors.red : colors.navy,
                      size: w * 0.055,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------- Name, verified icon, "Available" badge ----------
  Widget _buildNameRow(TutorDetailController c, AppColorsExtension colors, double w) {
    return Row(
      children: [
        Flexible(
          child: Text(
            c.tutor.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: w * 0.06,
              fontWeight: FontWeight.w500,
              color: colors.navy,
            ),
          ),
        ),
        SizedBox(width: w * 0.015),
        Icon(Icons.verified, color: colors.primary, size: w * 0.055),
        const Spacer(),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: w * 0.025,
            vertical: w * 0.01,
          ),
          decoration: BoxDecoration(
            color: colors.greenLight,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                width: w * 0.015,
                height: w * 0.015,
                decoration: BoxDecoration(
                  color: colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: w * 0.01),
              Text(
                'Available',
                style: TextStyle(
                  fontSize: w * 0.024,
                  fontWeight: FontWeight.w600,
                  color: colors.greenDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------- 3 stat boxes ----------
  Widget _buildStats(TutorDetailController c, AppColorsExtension colors, double w) {
    return Row(
      children: [
        Expanded(child: TutorStatBox(value: c.students, label: 'Students')),
        SizedBox(width: w * 0.025),
        Expanded(child: TutorStatBox(value: c.experience, label: 'Experience')),
        SizedBox(width: w * 0.025),
        Expanded(
          child: TutorStatBox(
            value: '${c.tutor.rating}',
            label: 'Rating',
            icon: Icons.star_rounded,
            iconColor: colors.amber,
          ),
        ),
      ],
    );
  }

  // ---------- Small bold title used in the tabs ----------
  Widget _title(String text, AppColorsExtension colors, double w) {
    return Text(
      text,
      style: TextStyle(
        fontSize: w * 0.04,
        fontWeight: FontWeight.w500,
        color: colors.navy,
      ),
    );
  }

  // ---------- Tab 1: About ----------
  Widget _buildAbout(TutorDetailController c, AppColorsExtension colors, double w) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title('About me', colors, w),
        SizedBox(height: w * 0.025),
        Obx(
          () => Text(
            c.about,
            maxLines: c.readMore.value ? null : 3,
            overflow: c.readMore.value
                ? TextOverflow.visible
                : TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: w * 0.03,
              color: colors.textGrey,
              height: 1.5,
            ),
          ),
        ),
        SizedBox(height: w * 0.015),
        GestureDetector(
          onTap: c.toggleReadMore,
          child: Obx(
            () => Text(
              c.readMore.value ? 'Read less' : 'Read more',
              style: TextStyle(
                fontSize: w * 0.03,
                fontWeight: FontWeight.w600,
                color: colors.primary,
              ),
            ),
          ),
        ),
        SizedBox(height: w * 0.05),
        _title('I can help you with', colors, w),
        SizedBox(height: w * 0.03),
        Wrap(
          spacing: w * 0.02,
          runSpacing: w * 0.02,
          children: [
            for (final skill in c.skills) SkillChip(text: skill),
          ],
        ),
        SizedBox(height: w * 0.05),
        ReviewCard(review: c.reviews.first),
      ],
    );
  }

  // ---------- Tab 2: Reviews ----------
  Widget _buildReviews(TutorDetailController c) {
    return Column(
      children: [
        for (final review in c.reviews) ReviewCard(review: review),
      ],
    );
  }

  // ---------- Tab 3: Schedule ----------
  Widget _buildSchedule(TutorDetailController c, AppColorsExtension colors, double w) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title('Weekly schedule', colors, w),
        SizedBox(height: w * 0.03),
        for (final row in c.schedule)
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: w * 0.025),
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.04,
              vertical: w * 0.035,
            ),
            decoration: BoxDecoration(
              color: colors.background,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  row[0],
                  style: TextStyle(
                    fontSize: w * 0.031,
                    fontWeight: FontWeight.w600,
                    color: colors.navy,
                  ),
                ),
                Text(
                  row[1],
                  style: TextStyle(
                    fontSize: w * 0.029,
                    color: row[1] == 'Off' ? colors.red : colors.textGrey,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  // ---------- Bottom bar: hourly rate + Book Session ----------
  Widget _buildBottomBar(
    TutorDetailController c,
    AppColorsExtension colors,
    double w,
    double pad,
  ) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        pad,
        w * 0.04,
        pad,
        w * 0.04 +
            MediaQueryData.fromView(
                  WidgetsBinding.instance.platformDispatcher.views.first,
                ).padding.bottom /
                WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio,
      ),
      decoration: BoxDecoration(
        color: colors.cardBg,
        boxShadow: colors.bottomBarShadow,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hourly rate',
                style: TextStyle(fontSize: w * 0.026, color: colors.textGrey),
              ),
              SizedBox(height: w * 0.008),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${c.tutor.price.round()}',
                    style: TextStyle(
                      fontSize: w * 0.06,
                      fontWeight: FontWeight.w700,
                      color: colors.navy,
                    ),
                  ),
                  SizedBox(width: w * 0.01),
                  Text(
                    '/ hour',
                    style: TextStyle(
                      fontSize: w * 0.027,
                      color: colors.textGrey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(width: w * 0.06),
          Expanded(
            child: GestureDetector(
              onTap: c.bookSession,
              child: Container(
                height: w * 0.135,
                decoration: BoxDecoration(
                  color: colors.primary,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x4D2863F0),
                      blurRadius: 14,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Book Session',
                    style: TextStyle(
                      fontSize: w * 0.038,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
