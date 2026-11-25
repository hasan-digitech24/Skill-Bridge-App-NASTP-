import 'package:flutter/material.dart';

@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color primary;
  final Color background;
  final Color cardBg;
  final Color navy;
  final Color navyLight;
  final Color textGrey;
  final Color textMuted;
  final Color border;
  final Color divider;
  final Color lightBlue;
  final Color headerBg;
  final Color featuredCardBg;
  final Color green;
  final Color greenDark;
  final Color greenLight;
  final Color greenBorder;
  final Color red;
  final Color redLight;
  final Color orange;
  final Color orangeLight;
  final Color amber;
  final Color amberLight;
  final Color purple;
  final Color purpleLight;
  final Color toggleTrack;
  final Color toggleThumb;
  final List<BoxShadow> cardShadow;
  final List<BoxShadow> bottomBarShadow;

  const AppColorsExtension({
    required this.primary,
    required this.background,
    required this.cardBg,
    required this.navy,
    required this.navyLight,
    required this.textGrey,
    required this.textMuted,
    required this.border,
    required this.divider,
    required this.lightBlue,
    required this.headerBg,
    required this.featuredCardBg,
    required this.green,
    required this.greenDark,
    required this.greenLight,
    required this.greenBorder,
    required this.red,
    required this.redLight,
    required this.orange,
    required this.orangeLight,
    required this.amber,
    required this.amberLight,
    required this.purple,
    required this.purpleLight,
    required this.toggleTrack,
    required this.toggleThumb,
    required this.cardShadow,
    required this.bottomBarShadow,
  });

  /// Light theme colors matching the Figma design
  static const light = AppColorsExtension(
    primary: Color(0xFF2863F0),
    background: Color(0xFFF4F7FC),
    cardBg: Color(0xFFFFFFFF),
    navy: Color(0xFF111827),
    navyLight: Color(0xFF1F2937),
    textGrey: Color(0xFF6B7280),
    textMuted: Color(0xFF9CA3AF),
    border: Color(0xFFE5E7EB),
    divider: Color(0xFFEEF1F6),
    lightBlue: Color(0xFFEFF5FF),
    headerBg: Color(0xFF2863F0),
    featuredCardBg: Color(0xFF1E40AF),
    green: Color(0xFF10B981),
    greenDark: Color(0xFF059669),
    greenLight: Color(0xFFECFDF5),
    greenBorder: Color(0xFF6EE7B7),
    red: Color(0xFFE11D48),
    redLight: Color(0xFFFEF2F2),
    orange: Color(0xFFF97316),
    orangeLight: Color(0xFFFFEFE0),
    amber: Color(0xFFF59E0B),
    amberLight: Color(0xFFFFF6E5),
    purple: Color(0xFF8B5CF6),
    purpleLight: Color(0xFFF3EEFF),
    toggleTrack: Color(0xFFE5E7EB),
    toggleThumb: Color(0xFFFFFFFF),
    cardShadow: [
      BoxShadow(color: Color(0x0D111827), blurRadius: 12, offset: Offset(0, 4)),
    ],
    bottomBarShadow: [
      BoxShadow(color: Color(0x14111827), blurRadius: 12, offset: Offset(0, -4)),
    ],
  );

  /// Dark theme colors placeholder - will be refined once dark screenshots are provided
  static const dark = AppColorsExtension(
    primary: Color(0xFF2860F1),
    background: Color(0xFF121212),
    cardBg: Color(0xFF1E1E1E),
    navy: Color(0xFFFFFFFF),
    navyLight: Color(0xFFE4E4E7),
    textGrey: Color(0xFFA1A1AA),
    textMuted: Color(0xFF71717A),
    border: Color(0xFF2C2C2E),
    divider: Color(0xFF27272A),
    lightBlue: Color(0xFF1E293B),
    headerBg: Color(0xFF1E1E1E),
    featuredCardBg: Color(0xFF1E293B),
    green: Color(0xFF10B981),
    greenDark: Color(0xFF34D399),
    greenLight: Color(0xFF064E3B),
    greenBorder: Color(0xFF059669),
    red: Color(0xFFF43F5E),
    redLight: Color(0xFF4C0519),
    orange: Color(0xFFFB923C),
    orangeLight: Color(0xFF431407),
    amber: Color(0xFFFBBF24),
    amberLight: Color(0xFF451A03),
    purple: Color(0xFFA78BFA),
    purpleLight: Color(0xFF2E1065),
    toggleTrack: Color(0xFF3F3F46),
    toggleThumb: Color(0xFFFFFFFF),
    cardShadow: [],
    bottomBarShadow: [],
  );

  @override
  AppColorsExtension copyWith({
    Color? primary,
    Color? background,
    Color? cardBg,
    Color? navy,
    Color? navyLight,
    Color? textGrey,
    Color? textMuted,
    Color? border,
    Color? divider,
    Color? lightBlue,
    Color? headerBg,
    Color? featuredCardBg,
    Color? green,
    Color? greenDark,
    Color? greenLight,
    Color? greenBorder,
    Color? red,
    Color? redLight,
    Color? orange,
    Color? orangeLight,
    Color? amber,
    Color? amberLight,
    Color? purple,
    Color? purpleLight,
    Color? toggleTrack,
    Color? toggleThumb,
    List<BoxShadow>? cardShadow,
    List<BoxShadow>? bottomBarShadow,
  }) {
    return AppColorsExtension(
      primary: primary ?? this.primary,
      background: background ?? this.background,
      cardBg: cardBg ?? this.cardBg,
      navy: navy ?? this.navy,
      navyLight: navyLight ?? this.navyLight,
      textGrey: textGrey ?? this.textGrey,
      textMuted: textMuted ?? this.textMuted,
      border: border ?? this.border,
      divider: divider ?? this.divider,
      lightBlue: lightBlue ?? this.lightBlue,
      headerBg: headerBg ?? this.headerBg,
      featuredCardBg: featuredCardBg ?? this.featuredCardBg,
      green: green ?? this.green,
      greenDark: greenDark ?? this.greenDark,
      greenLight: greenLight ?? this.greenLight,
      greenBorder: greenBorder ?? this.greenBorder,
      red: red ?? this.red,
      redLight: redLight ?? this.redLight,
      orange: orange ?? this.orange,
      orangeLight: orangeLight ?? this.orangeLight,
      amber: amber ?? this.amber,
      amberLight: amberLight ?? this.amberLight,
      purple: purple ?? this.purple,
      purpleLight: purpleLight ?? this.purpleLight,
      toggleTrack: toggleTrack ?? this.toggleTrack,
      toggleThumb: toggleThumb ?? this.toggleThumb,
      cardShadow: cardShadow ?? this.cardShadow,
      bottomBarShadow: bottomBarShadow ?? this.bottomBarShadow,
    );
  }

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      background: Color.lerp(background, other.background, t)!,
      cardBg: Color.lerp(cardBg, other.cardBg, t)!,
      navy: Color.lerp(navy, other.navy, t)!,
      navyLight: Color.lerp(navyLight, other.navyLight, t)!,
      textGrey: Color.lerp(textGrey, other.textGrey, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      border: Color.lerp(border, other.border, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      lightBlue: Color.lerp(lightBlue, other.lightBlue, t)!,
      headerBg: Color.lerp(headerBg, other.headerBg, t)!,
      featuredCardBg: Color.lerp(featuredCardBg, other.featuredCardBg, t)!,
      green: Color.lerp(green, other.green, t)!,
      greenDark: Color.lerp(greenDark, other.greenDark, t)!,
      greenLight: Color.lerp(greenLight, other.greenLight, t)!,
      greenBorder: Color.lerp(greenBorder, other.greenBorder, t)!,
      red: Color.lerp(red, other.red, t)!,
      redLight: Color.lerp(redLight, other.redLight, t)!,
      orange: Color.lerp(orange, other.orange, t)!,
      orangeLight: Color.lerp(orangeLight, other.orangeLight, t)!,
      amber: Color.lerp(amber, other.amber, t)!,
      amberLight: Color.lerp(amberLight, other.amberLight, t)!,
      purple: Color.lerp(purple, other.purple, t)!,
      purpleLight: Color.lerp(purpleLight, other.purpleLight, t)!,
      toggleTrack: Color.lerp(toggleTrack, other.toggleTrack, t)!,
      toggleThumb: Color.lerp(toggleThumb, other.toggleThumb, t)!,
      cardShadow: t < 0.5 ? cardShadow : other.cardShadow,
      bottomBarShadow: t < 0.5 ? bottomBarShadow : other.bottomBarShadow,
    );
  }
}

extension AppThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  AppColorsExtension get colors =>
      Theme.of(this).extension<AppColorsExtension>() ?? AppColorsExtension.light;
}
