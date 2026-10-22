import 'package:flutter/material.dart';

/// Maximum width of the centred page content.
const double kContentMaxWidth = 1120;

const String _fontFamily = 'PlusJakartaSans';

/// Palette tokens from the portfolio design system.
abstract final class AppColors {
  static const background = Color(0xFF101012);
  static const surface = Color(0xFF1A1719);
  static const maroonDeep = Color(0xFF64152D);
  static const maroon = Color(0xFF8B1E3F);
  static const crimson = Color(0xFFD06A85);
  static const textPrimary = Color(0xFFF5F3F4);
  static const textSecondary = Color(0xFFB7AEB2);
  static const border = Color(0xFF30272B);
}

/// Builds the single dark theme used across the portfolio.
ThemeData buildAppTheme() {
  const colorScheme = ColorScheme.dark(
    primary: AppColors.maroon,
    onPrimary: AppColors.textPrimary,
    secondary: AppColors.crimson,
    onSecondary: AppColors.background,
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,
    onSurfaceVariant: AppColors.textSecondary,
    outline: AppColors.border,
    error: AppColors.crimson,
    onError: AppColors.background,
  );

  final base = ThemeData(colorScheme: colorScheme, fontFamily: _fontFamily);

  return base.copyWith(
    scaffoldBackgroundColor: AppColors.background,
    canvasColor: AppColors.background,
    dividerColor: AppColors.border,
    focusColor: AppColors.crimson,
    hoverColor: AppColors.crimson.withValues(alpha: 0.08),
    splashColor: AppColors.crimson.withValues(alpha: 0.12),
    textTheme: _buildTextTheme(base.textTheme),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.crimson,
      selectionColor: Color(0x4DD06A85),
      selectionHandleColor: AppColors.crimson,
    ),
    filledButtonTheme: FilledButtonThemeData(style: _filledButtonStyle()),
    outlinedButtonTheme: OutlinedButtonThemeData(style: _outlinedButtonStyle()),
    textButtonTheme: TextButtonThemeData(style: _textButtonStyle()),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: const WidgetStatePropertyAll(AppColors.textSecondary),
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return AppColors.crimson.withValues(alpha: 0.24);
          }
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.pressed)) {
            return AppColors.crimson.withValues(alpha: 0.12);
          }
          return null;
        }),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.textSecondary),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.surface,
      contentTextStyle: _jakarta(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: AppColors.border),
      ),
    ),
  );
}

TextStyle _jakarta({
  required double fontSize,
  required FontWeight fontWeight,
  double? height,
  double? letterSpacing,
  Color color = AppColors.textPrimary,
}) {
  return TextStyle(
    fontFamily: _fontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    height: height,
    letterSpacing: letterSpacing,
    color: color,
  );
}

TextTheme _buildTextTheme(TextTheme base) {
  return base.copyWith(
    displayLarge: _jakarta(
      fontSize: 56,
      fontWeight: FontWeight.w800,
      height: 1.05,
      letterSpacing: -1,
    ),
    displayMedium: _jakarta(
      fontSize: 44,
      fontWeight: FontWeight.w800,
      height: 1.08,
      letterSpacing: -0.8,
    ),
    headlineLarge: _jakarta(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      height: 1.15,
      letterSpacing: -0.5,
    ),
    headlineMedium: _jakarta(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      height: 1.2,
      letterSpacing: -0.3,
    ),
    headlineSmall: _jakarta(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      height: 1.25,
    ),
    titleLarge: _jakarta(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      height: 1.3,
    ),
    titleMedium: _jakarta(fontSize: 16, fontWeight: FontWeight.w600),
    bodyLarge: _jakarta(fontSize: 16, fontWeight: FontWeight.w400, height: 1.6),
    bodyMedium: _jakarta(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      height: 1.55,
      color: AppColors.textSecondary,
    ),
    bodySmall: _jakarta(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      height: 1.5,
      color: AppColors.textSecondary,
    ),
    labelLarge: _jakarta(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.3,
    ),
    labelMedium: _jakarta(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.4,
      color: AppColors.textSecondary,
    ),
    labelSmall: _jakarta(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.4,
      color: AppColors.crimson,
    ),
  );
}

ButtonStyle _filledButtonStyle() {
  return FilledButton.styleFrom(
    backgroundColor: AppColors.maroon,
    foregroundColor: AppColors.textPrimary,
    disabledBackgroundColor: AppColors.maroonDeep,
    disabledForegroundColor: AppColors.textSecondary,
    minimumSize: const Size(0, 48),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    textStyle: _jakarta(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.3,
    ),
  ).copyWith(
    side: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.focused)) {
        return const BorderSide(color: AppColors.crimson, width: 2);
      }
      return BorderSide.none;
    }),
  );
}

ButtonStyle _outlinedButtonStyle() {
  return OutlinedButton.styleFrom(
    foregroundColor: AppColors.textPrimary,
    minimumSize: const Size(0, 48),
    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    textStyle: _jakarta(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.3,
    ),
  ).copyWith(
    side: WidgetStateProperty.resolveWith((states) {
      final highlighted =
          states.contains(WidgetState.focused) ||
          states.contains(WidgetState.hovered);
      return BorderSide(
        color: highlighted ? AppColors.crimson : AppColors.border,
      );
    }),
  );
}

ButtonStyle _textButtonStyle() {
  return TextButton.styleFrom(
    foregroundColor: AppColors.textSecondary,
    minimumSize: const Size(0, 48),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    textStyle: _jakarta(fontSize: 14, fontWeight: FontWeight.w500),
  ).copyWith(
    foregroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.focused)) {
        return AppColors.textPrimary;
      }
      return AppColors.textSecondary;
    }),
    overlayColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.focused)) {
        return AppColors.crimson.withValues(alpha: 0.18);
      }
      if (states.contains(WidgetState.hovered) ||
          states.contains(WidgetState.pressed)) {
        return AppColors.crimson.withValues(alpha: 0.10);
      }
      return null;
    }),
  );
}
