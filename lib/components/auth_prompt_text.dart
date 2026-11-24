import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthPromptText extends StatelessWidget {
  final String normalText;
  final String actionText;
  final VoidCallback onActionTap;

  const AuthPromptText({
    super.key,
    required this.normalText,
    required this.actionText,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: RichText(
        text: TextSpan(
          text: normalText,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            color: colorScheme.onSurfaceVariant,
          ),
          children: [
            TextSpan(
              text: actionText,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: colorScheme.primary,
              ),
              recognizer: TapGestureRecognizer()..onTap = onActionTap,
            ),
          ],
        ),
      ),
    );
  }
}
