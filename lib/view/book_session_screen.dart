import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/controllers/book_session_controller.dart';
import 'package:my_app/theme/app_colors.dart';
import 'package:my_app/widgets/booking/date_tile.dart';
import 'package:my_app/widgets/booking/segment_toggle.dart';
import 'package:my_app/widgets/booking/step_header.dart';
import 'package:my_app/widgets/booking/time_slot_tile.dart';
import 'package:my_app/widgets/student/explore_tutor_image.dart';

class BookSessionScreen extends StatelessWidget {
  const BookSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(BookSessionController());
    final colors = context.colors;
    final w = MediaQuery.of(context).size.width;
    final pad = w * 0.05;

    return Scaffold(
      backgroundColor: colors.cardBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(colors, w, pad),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(pad, w * 0.02, pad, w * 0.04),
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTutorCard(c, colors, w),
                      SizedBox(height: w * 0.06),
                      _buildDateSection(c, colors, w),
                      SizedBox(height: w * 0.06),
                      _buildTimeSection(c, colors, w),
                      SizedBox(height: w * 0.06),
                      _buildDetailsSection(c, colors, w),
                      SizedBox(height: w * 0.05),
                      _buildFeeSummary(c, colors, w),
                    ],
                  ),
                ),
              ),
            ),

            // Fixed bottom button
            _buildBottomButton(c, colors, w, pad),
          ],
        ),
      ),
    );
  }

  // ---------- Top bar ----------
  Widget _buildTopBar(AppColorsExtension colors, double w, double pad) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: pad, vertical: w * 0.03),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: SizedBox(
              width: w * 0.1,
              child: Icon(
                Icons.chevron_left_rounded,
                size: w * 0.075,
                color: colors.navy,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Book a session',
                style: TextStyle(
                  fontSize: w * 0.045,
                  fontWeight: FontWeight.w500,
                  color: colors.navy,
                ),
              ),
            ),
          ),
          SizedBox(width: w * 0.1), // keeps the title centered
        ],
      ),
    );
  }

  // ---------- Tutor summary card ----------
  Widget _buildTutorCard(
    BookSessionController c,
    AppColorsExtension colors,
    double w,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(w * 0.035),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        children: [
          TutorImage(path: c.tutor.image, width: w * 0.16, height: w * 0.16),
          SizedBox(width: w * 0.035),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        c.tutor.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.w600,
                          color: colors.navy,
                        ),
                      ),
                    ),
                    SizedBox(width: w * 0.015),
                    Icon(
                      Icons.verified,
                      color: colors.primary,
                      size: w * 0.045,
                    ),
                  ],
                ),
                SizedBox(height: w * 0.008),
                Text(
                  c.tutor.subject,
                  style: TextStyle(fontSize: w * 0.029, color: colors.textGrey),
                ),
                SizedBox(height: w * 0.015),
                Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: colors.amber,
                      size: w * 0.04,
                    ),
                    SizedBox(width: w * 0.01),
                    Text(
                      '${c.tutor.rating} · \$${c.tutor.price.round()}/hr',
                      style: TextStyle(
                        fontSize: w * 0.028,
                        color: colors.textGrey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------- 01 Select a date ----------
  Widget _buildDateSection(
    BookSessionController c,
    AppColorsExtension colors,
    double w,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StepHeader(
          number: '01',
          title: 'Select a date',
          trailing: Text(
            c.monthLabel,
            style: TextStyle(fontSize: w * 0.028, color: colors.textGrey),
          ),
        ),
        SizedBox(height: w * 0.035),
        Row(
          children: [
            for (int i = 0; i < c.dates.length; i++)
              Expanded(
                child: DateTile(
                  date: c.dates[i],
                  isSelected: c.selectedDateIndex.value == i,
                  onTap: () => c.selectDate(i),
                ),
              ),
          ],
        ),
      ],
    );
  }

  // ---------- 02 Choose a time ----------
  Widget _buildTimeSection(
    BookSessionController c,
    AppColorsExtension colors,
    double w,
  ) {
    // Build the grid: 3 tiles per row
    final rows = <Widget>[];
    for (int start = 0; start < c.slots.length; start += 3) {
      rows.add(
        Row(
          children: [
            for (int i = start; i < start + 3; i++)
              Expanded(
                child: i < c.slots.length
                    ? TimeSlotTile(
                        label: c.slotLabel(i),
                        isSelected: c.selectedSlot.value == i,
                        isBooked: c.isBooked(i),
                        onTap: () => c.selectSlot(i),
                      )
                    : const SizedBox(),
              ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StepHeader(
          number: '02',
          title: 'Choose a time',
          trailing: Container(
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.025,
              vertical: w * 0.01,
            ),
            decoration: BoxDecoration(
              color: colors.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: colors.border),
            ),
            child: Text(
              c.timezoneLabel,
              style: TextStyle(fontSize: w * 0.025, color: colors.textGrey),
            ),
          ),
        ),
        SizedBox(height: w * 0.03),
        Column(children: rows),
        SizedBox(height: w * 0.025),

        // Legend
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _legendItem('Available', colors.cardBg, colors.border, colors, w),
            SizedBox(width: w * 0.04),
            _legendItem('Selected', colors.primary, colors.primary, colors, w),
            SizedBox(width: w * 0.04),
            _legendItem('Booked', colors.divider, colors.divider, colors, w),
          ],
        ),
      ],
    );
  }

  Widget _legendItem(
    String text,
    Color fill,
    Color border,
    AppColorsExtension colors,
    double w,
  ) {
    return Row(
      children: [
        Container(
          width: w * 0.022,
          height: w * 0.022,
          decoration: BoxDecoration(
            color: fill,
            shape: BoxShape.circle,
            border: Border.all(color: border),
          ),
        ),
        SizedBox(width: w * 0.012),
        Text(
          text,
          style: TextStyle(fontSize: w * 0.024, color: colors.textGrey),
        ),
      ],
    );
  }

  // ---------- 03 Session details ----------
  Widget _buildDetailsSection(
    BookSessionController c,
    AppColorsExtension colors,
    double w,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const StepHeader(number: '03', title: 'Session details'),
        SizedBox(height: w * 0.035),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: colors.cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.border),
          ),
          child: Column(
            children: [
              // Learning mode
              Padding(
                padding: EdgeInsets.all(w * 0.04),
                child: Row(
                  children: [
                    Expanded(
                      child: _labelColumn(
                        'Learning mode',
                        'Choose how you\'ll meet',
                        colors,
                        w,
                      ),
                    ),
                    SegmentToggle(
                      labels: const ['Online', 'Home'],
                      selectedIndex: c.isOnline.value ? 0 : 1,
                      onChanged: c.setMode,
                    ),
                  ],
                ),
              ),
              Container(height: 1, color: colors.divider),

              // Duration
              Padding(
                padding: EdgeInsets.all(w * 0.04),
                child: Row(
                  children: [
                    Expanded(
                      child: _labelColumn(
                        'Duration',
                        'Length of your session',
                        colors,
                        w,
                      ),
                    ),
                    _roundButton(
                      Icons.remove,
                      c.decreaseHours,
                      false,
                      colors,
                      w,
                    ),
                    SizedBox(width: w * 0.03),
                    Text(
                      c.durationText,
                      style: TextStyle(
                        fontSize: w * 0.031,
                        fontWeight: FontWeight.w700,
                        color: colors.navy,
                      ),
                    ),
                    SizedBox(width: w * 0.03),
                    _roundButton(Icons.add, c.increaseHours, true, colors, w),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _labelColumn(
    String title,
    String subtitle,
    AppColorsExtension colors,
    double w,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: w * 0.031,
            fontWeight: FontWeight.w600,
            color: colors.navy,
          ),
        ),
        SizedBox(height: w * 0.008),
        Text(
          subtitle,
          style: TextStyle(fontSize: w * 0.025, color: colors.textMuted),
        ),
      ],
    );
  }

  // Round "-" / "+" button
  Widget _roundButton(
    IconData icon,
    VoidCallback onTap,
    bool filled,
    AppColorsExtension colors,
    double w,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: w * 0.08,
        height: w * 0.08,
        decoration: BoxDecoration(
          color: filled ? colors.primary : colors.cardBg,
          shape: BoxShape.circle,
          border: Border.all(color: colors.primary, width: 1.5),
        ),
        child: Icon(
          icon,
          size: w * 0.045,
          color: filled ? Colors.white : colors.primary,
        ),
      ),
    );
  }

  // ---------- Fee summary ----------
  Widget _buildFeeSummary(
    BookSessionController c,
    AppColorsExtension colors,
    double w,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(w * 0.04),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fee summary',
            style: TextStyle(
              fontSize: w * 0.033,
              fontWeight: FontWeight.w600,
              color: colors.navy,
            ),
          ),
          SizedBox(height: w * 0.03),
          _feeRow(
            c.feeLabel,
            '\$${c.sessionFee.toStringAsFixed(2)}',
            colors,
            w,
            false,
          ),
          SizedBox(height: w * 0.02),
          _feeRow(
            'Service fee',
            '\$${c.serviceFee.toStringAsFixed(2)}',
            colors,
            w,
            false,
          ),
          SizedBox(height: w * 0.03),
          Container(height: 1, color: colors.border),
          SizedBox(height: w * 0.03),
          _feeRow('Total', '\$${c.total.toStringAsFixed(2)}', colors, w, true),
        ],
      ),
    );
  }

  Widget _feeRow(
    String label,
    String value,
    AppColorsExtension colors,
    double w,
    bool isBold,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? w * 0.033 : w * 0.028,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            color: isBold ? colors.navy : colors.textGrey,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? w * 0.04 : w * 0.028,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            color: isBold ? colors.primary : colors.navy,
          ),
        ),
      ],
    );
  }

  // ---------- Bottom button ----------
  Widget _buildBottomButton(
    BookSessionController c,
    AppColorsExtension colors,
    double w,
    double pad,
  ) {
    return Container(
      padding: EdgeInsets.fromLTRB(pad, w * 0.03, pad, w * 0.04),
      color: colors.cardBg,
      child: GestureDetector(
        onTap: c.confirmBooking,
        child: Container(
          width: double.infinity,
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
            child: Obx(
              () => Text(
                'Confirm Booking · \$${c.total.toStringAsFixed(2)}',
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
    );
  }
}
