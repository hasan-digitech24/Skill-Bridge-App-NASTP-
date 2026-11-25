import 'package:flutter/material.dart';
import 'package:my_app/theme/app_colors.dart';

class FilterSection extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final Widget child;

  const FilterSection({
    super.key,
    required this.title,
    this.trailing,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final w = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(width: double.infinity, height: 1, color: colors.border),
        Padding(
          padding: EdgeInsets.symmetric(vertical: w * 0.045),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: w * 0.037, color: colors.navy),
                  ),
                  ?trailing,
                ],
              ),
              SizedBox(height: w * 0.035),
              child,
            ],
          ),
        ),
      ],
    );
  }
}
