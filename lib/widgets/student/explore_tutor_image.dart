import 'package:flutter/material.dart';

class TutorImage extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final BorderRadius borderRadius;

  const TutorImage({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        image: DecorationImage(
          image: AssetImage(path),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}