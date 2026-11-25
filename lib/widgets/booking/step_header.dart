import 'package:flutter/material.dart';
import 'package:my_app/theme/app_colors.dart';

class StepHeader extends StatelessWidget {
  final String number;
  final String title;
  final Widget? trailing;

  const StepHeader({
    super.key,
    required this.number,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final w = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Container(
          width: w * 0.065,
          height: w * 0.065,
          decoration: BoxDecoration(
            color: colors.lightBlue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                fontSize: w * 0.025,
                fontWeight: FontWeight.w700,
                color: colors.primary,
              ),
            ),
          ),
        ),
        SizedBox(width: w * 0.025),
        Text(
          title,
          style: TextStyle(
            fontSize: w * 0.04,
            fontWeight: FontWeight.w500,
            color: colors.navy,
          ),
        ),
        const Spacer(),
        ?trailing,
      ],
    );
  }
}
