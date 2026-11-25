import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/controllers/explore_controller.dart';
import 'package:my_app/theme/app_colors.dart';
import 'package:my_app/widgets/student/filter_section.dart';
import 'package:my_app/widgets/student/option_row.dart';

class FiltersSheet extends StatelessWidget {
  const FiltersSheet({super.key});

  String _priceText(RangeValues range) {
    final start = '\$${range.start.round()}';
    final end = range.end >= 100 ? '\$100+' : '\$${range.end.round()}';
    return '$start — $end';
  }

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ExploreController>();
    final colors = context.colors;
    final w = MediaQuery.of(context).size.width;
    final pad = w * 0.06;
    final bottomSafe = MediaQuery.of(context).padding.bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(pad, w * 0.03, pad, bottomSafe + w * 0.05),
      decoration: BoxDecoration(
        color: colors.cardBg,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: w * 0.1,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.border,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            SizedBox(height: w * 0.045),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filters',
                  style: TextStyle(
                    fontSize: w * 0.055,
                    fontWeight: FontWeight.w500,
                    color: colors.navy,
                  ),
                ),
                GestureDetector(
                  onTap: c.resetDraft,
                  child: Text(
                    'Reset',
                    style: TextStyle(
                      fontSize: w * 0.032,
                      fontWeight: FontWeight.w600,
                      color: colors.primary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: w * 0.04),

            // 1. Hourly price
            FilterSection(
              title: 'Hourly price',
              trailing: Text(
                _priceText(c.draftPrice.value),
                style: TextStyle(
                  fontSize: w * 0.035,
                  fontWeight: FontWeight.w700,
                  color: colors.primary,
                ),
              ),
              child: Column(
                children: [
                  RangeSlider(
                    values: c.draftPrice.value,
                    min: 15,
                    max: 100,
                    divisions: 17,
                    activeColor: colors.primary,
                    inactiveColor: colors.border,
                    onChanged: (values) => c.draftPrice.value = values,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$15',
                        style: TextStyle(
                          fontSize: w * 0.027,
                          color: colors.textMuted,
                        ),
                      ),
                      Text(
                        '\$100+',
                        style: TextStyle(
                          fontSize: w * 0.027,
                          color: colors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 2. Learning mode
            FilterSection(
              title: 'Learning mode',
              child: OptionRow(
                labels: const ['All', 'Online', 'Home'],
                icons: const [
                  null,
                  Icons.videocam_outlined,
                  Icons.location_on_outlined,
                ],
                selected: c.draftMode.value,
                onSelect: (label) => c.draftMode.value = label,
              ),
            ),

            // 3. Minimum rating
            FilterSection(
              title: 'Minimum rating',
              child: OptionRow(
                labels: const ['4.5+', '4.0+', '3.5+'],
                icons: const [
                  Icons.star_rounded,
                  Icons.star_rounded,
                  Icons.star_rounded,
                ],
                iconColor: colors.amber,
                selected: '${c.draftRating.value.toStringAsFixed(1)}+',
                onSelect: (label) {
                  c.draftRating.value = double.parse(label.replaceAll('+', ''));
                },
              ),
            ),

            // 4. Availability
            FilterSection(
              title: 'Availability',
              child: OptionRow(
                labels: const ['Today', 'Tomorrow', 'This week'],
                selected: c.draftAvailability.value,
                onSelect: (label) => c.draftAvailability.value = label,
              ),
            ),

            // Divider above the buttons
            Container(width: double.infinity, height: 1, color: colors.border),
            SizedBox(height: w * 0.045),

            // Bottom buttons
            Row(
              children: [
                // Cancel
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: w * 0.13,
                      decoration: BoxDecoration(
                        color: colors.cardBg,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: colors.border),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: w * 0.036,
                            fontWeight: FontWeight.w600,
                            color: colors.navy,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: w * 0.03),

                // Show tutors
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      c.applyFilters();
                      Get.back();
                    },
                    child: Container(
                      height: w * 0.13,
                      decoration: BoxDecoration(
                        color: colors.primary,
                        borderRadius: BorderRadius.circular(14),
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
                          'Show ${c.draftCount} Tutors',
                          style: const TextStyle(
                            fontSize: 14,
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
          ],
        ),
      ),
    );
  }
}
