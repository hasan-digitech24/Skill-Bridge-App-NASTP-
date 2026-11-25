import 'package:flutter/material.dart';
import 'package:my_app/theme/app_colors.dart';

class SegmentToggle extends StatelessWidget {
  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const SegmentToggle({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final w = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(w * 0.01),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < labels.length; i++)
            GestureDetector(
              onTap: () => onChanged(i),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: w * 0.035,
                  vertical: w * 0.02,
                ),
                decoration: BoxDecoration(
                  color: i == selectedIndex
                      ? colors.cardBg
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(
                    color: i == selectedIndex
                        ? colors.border
                        : Colors.transparent,
                  ),
                ),
                child: Text(
                  labels[i],
                  style: TextStyle(
                    fontSize: w * 0.027,
                    fontWeight: FontWeight.w600,
                    color: i == selectedIndex
                        ? colors.primary
                        : colors.textGrey,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
