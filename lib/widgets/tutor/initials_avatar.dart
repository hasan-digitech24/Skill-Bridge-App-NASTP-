import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class InitialsAvatar extends StatelessWidget {
  final String name;
  final double size;
  final double radius;

  const InitialsAvatar({
    super.key,
    required this.name,
    this.size = 40,
    this.radius = 12,
  });

  static const List<Color> _palette = [
    Color(0xFFDBEAFE),
    Color(0xFFFCE7F3),
    Color(0xFFD1FAE5),
    Color(0xFFFEF3C7),
    Color(0xFFEDE9FE),
  ];

  String get _initials {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    final first = parts.first[0].toUpperCase();
    final second = parts.length > 1 ? parts.last[0].toUpperCase() : '';
    return '$first$second';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _palette[name.length % _palette.length],
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Text(
        _initials,
        style: TextStyle(
          fontSize: size * 0.34,
          fontWeight: FontWeight.w700,
          color: AppColors.navy,
        ),
      ),
    );
  }
}
