import 'package:flutter/material.dart';
import 'package:my_app/theme/app_colors.dart';

class SessionTabBar extends StatelessWidget {
  final List<String> labels;
  final int selectedIndex;
  final List<int> badges;
  final ValueChanged<int> onTap;

  const SessionTabBar({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.badges,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final w = MediaQuery.of(context).size.width;

    return Row(
      children: [
        for (int i = 0; i < labels.length; i++)
          Expanded(
            child: GestureDetector(
              onTap: () => onTap(i),
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: w * 0.035),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: i == selectedIndex
                          ? colors.primary
                          : colors.divider,
                      width: 2,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      labels[i],
                      style: TextStyle(
                        fontSize: w * 0.033,
                        fontWeight: i == selectedIndex
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: i == selectedIndex
                            ? colors.primary
                            : colors.navy,
                      ),
                    ),
                    if (badges[i] > 0) ...[
                      SizedBox(width: w * 0.015),
                      Container(
                        width: w * 0.05,
                        height: w * 0.05,
                        decoration: BoxDecoration(
                          color: colors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${badges[i]}',
                            style: TextStyle(
                              fontSize: w * 0.026,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
