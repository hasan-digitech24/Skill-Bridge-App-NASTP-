import 'package:flutter/material.dart';
import 'package:my_app/theme/app_colors.dart';

class OptionRow extends StatelessWidget {
  final List<String> labels;
  final String selected;
  final ValueChanged<String> onSelect;
  final List<IconData?> icons;
  final Color? iconColor;

  const OptionRow({
    super.key,
    required this.labels,
    required this.selected,
    required this.onSelect,
    this.icons = const [],
    this.iconColor,
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
              onTap: () => onSelect(labels[i]),
              child: Container(
                height: w * 0.115,
                margin: EdgeInsets.only(
                  right: i == labels.length - 1 ? 0 : w * 0.025,
                ),
                decoration: BoxDecoration(
                  color: labels[i] == selected
                      ? colors.lightBlue
                      : colors.cardBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: labels[i] == selected
                        ? colors.primary
                        : colors.border,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (i < icons.length && icons[i] != null) ...[
                      Icon(
                        icons[i],
                        size: w * 0.045,
                        color:
                            iconColor ??
                            (labels[i] == selected
                                ? colors.primary
                                : colors.textGrey),
                      ),
                      SizedBox(width: w * 0.015),
                    ],
                    Text(
                      labels[i],
                      style: TextStyle(
                        fontSize: w * 0.03,
                        fontWeight: FontWeight.w600,
                        color: labels[i] == selected
                            ? colors.primary
                            : colors.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
