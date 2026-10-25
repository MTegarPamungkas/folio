import 'package:flutter/cupertino.dart' show CupertinoPageTransitionsBuilder;
import 'package:flutter/material.dart';

@immutable
class FolioColors extends ThemeExtension<FolioColors> {
  const FolioColors({
    required this.background,
    required this.surface,
    required this.surfaceElevated,
    required this.surfaceMuted,
    required this.ink,
    required this.inkMuted,
    required this.line,
    required this.accent,
    required this.accentSoft,
    required this.onAccent,
    required this.success,
    required this.warning,
    required this.shadow,
  });

  final Color background;
  final Color surface;
  final Color surfaceElevated;
  final Color surfaceMuted;
  final Color ink;
  final Color inkMuted;
  final Color line;
  final Color accent;
  final Color accentSoft;
  final Color onAccent;
  final Color success;
  final Color warning;
  final Color shadow;

  @override
  FolioColors copyWith({
    Color? background,
    Color? surface,
    Color? surfaceElevated,
    Color? surfaceMuted,
    Color? ink,
    Color? inkMuted,
    Color? line,
    Color? accent,
    Color? accentSoft,
    Color? onAccent,
    Color? success,
    Color? warning,
    Color? shadow,
  }) {
    return FolioColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      surfaceMuted: surfaceMuted ?? this.surfaceMuted,
      ink: ink ?? this.ink,
      inkMuted: inkMuted ?? this.inkMuted,
      line: line ?? this.line,
      accent: accent ?? this.accent,
      accentSoft: accentSoft ?? this.accentSoft,
      onAccent: onAccent ?? this.onAccent,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  FolioColors lerp(covariant FolioColors? other, double t) {
    if (other == null) return this;
    return FolioColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceElevated: Color.lerp(surfaceElevated, other.surfaceElevated, t)!,
      surfaceMuted: Color.lerp(surfaceMuted, other.surfaceMuted, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      inkMuted: Color.lerp(inkMuted, other.inkMuted, t)!,
      line: Color.lerp(line, other.line, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentSoft: Color.lerp(accentSoft, other.accentSoft, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
    );
  }
}

extension FolioThemeContext on BuildContext {
  FolioColors get folio => Theme.of(this).extension<FolioColors>()!;
}

class FolioTypography {
  FolioTypography._();

  static const String sans = 'PlusJakartaSans';
  static const String serifFamily = 'InstrumentSerif';

  static TextStyle serif({
    double? fontSize,
    FontWeight fontWeight = FontWeight.w400,
    Color? color,
    double? height,
    bool italic = true,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: serifFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }
}

class AppTheme {
  AppTheme._();

  static const Color accent = Color(0xFFFF5C35);

  static const FolioColors _light = FolioColors(
    background: Color(0xFFF5F3EE),
    surface: Color(0xFFFCFBF8),
    surfaceElevated: Color(0xFFFFFFFF),
    surfaceMuted: Color(0xFFECE9E2),
    ink: Color(0xFF171614),
    inkMuted: Color(0xFF6D6960),
    line: Color(0xFFDFDBD1),
    accent: accent,
    accentSoft: Color(0xFFFFE4DB),
    onAccent: Color(0xFF1B0C07),
    success: Color(0xFF1C7A52),
    warning: Color(0xFFB46A0B),
    shadow: Color(0x180D0C09),
  );

  static const FolioColors _dark = FolioColors(
    background: Color(0xFF0F0F0E),
    surface: Color(0xFF171715),
    surfaceElevated: Color(0xFF1E1E1B),
    surfaceMuted: Color(0xFF252521),
    ink: Color(0xFFF7F4EC),
    inkMuted: Color(0xFFA7A298),
    line: Color(0xFF2E2D28),
    accent: Color(0xFFFF7555),
    accentSoft: Color(0xFF3B1C14),
    onAccent: Color(0xFF180B07),
    success: Color(0xFF63D6A1),
    warning: Color(0xFFF1B95E),
    shadow: Color(0x66000000),
  );

  static ThemeData get lightTheme => _theme(_light, Brightness.light);

  static ThemeData get darkTheme => _theme(_dark, Brightness.dark);

  static ThemeData _theme(FolioColors colors, Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final textTheme = TextTheme(
      displayLarge: TextStyle(
        fontSize: 62,
        height: 0.98,
        letterSpacing: -2.9,
        fontWeight: FontWeight.w800,
        color: colors.ink,
      ),
      displayMedium: TextStyle(
        fontSize: 48,
        height: 1.02,
        letterSpacing: -2.1,
        fontWeight: FontWeight.w800,
        color: colors.ink,
      ),
      displaySmall: TextStyle(
        fontSize: 38,
        height: 1.04,
        letterSpacing: -1.5,
        fontWeight: FontWeight.w800,
        color: colors.ink,
      ),
      headlineLarge: TextStyle(
        fontSize: 32,
        height: 1.12,
        letterSpacing: -1.0,
        fontWeight: FontWeight.w700,
        color: colors.ink,
      ),
      headlineMedium: TextStyle(
        fontSize: 27,
        height: 1.15,
        letterSpacing: -0.7,
        fontWeight: FontWeight.w700,
        color: colors.ink,
      ),
      headlineSmall: TextStyle(
        fontSize: 23,
        height: 1.2,
        letterSpacing: -0.4,
        fontWeight: FontWeight.w700,
        color: colors.ink,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        height: 1.25,
        letterSpacing: -0.3,
        fontWeight: FontWeight.w700,
        color: colors.ink,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        height: 1.35,
        letterSpacing: -0.1,
        fontWeight: FontWeight.w600,
        color: colors.ink,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        height: 1.35,
        fontWeight: FontWeight.w600,
        color: colors.ink,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        height: 1.65,
        letterSpacing: -0.1,
        fontWeight: FontWeight.w400,
        color: colors.ink,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        height: 1.6,
        fontWeight: FontWeight.w400,
        color: colors.ink,
      ),
      bodySmall: TextStyle(
        fontSize: 12.5,
        height: 1.5,
        fontWeight: FontWeight.w400,
        color: colors.inkMuted,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        height: 1.2,
        letterSpacing: 0.1,
        fontWeight: FontWeight.w600,
        color: colors.ink,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        height: 1.2,
        letterSpacing: 0.2,
        fontWeight: FontWeight.w600,
        color: colors.inkMuted,
      ),
      labelSmall: TextStyle(
        fontSize: 10.5,
        height: 1.2,
        letterSpacing: 1.25,
        fontWeight: FontWeight.w700,
        color: colors.inkMuted,
      ),
    );

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: colors.accent,
      onPrimary: colors.onAccent,
      primaryContainer: colors.accentSoft,
      onPrimaryContainer: isDark
          ? const Color(0xFFFFC8B8)
          : const Color(0xFF7D1B00),
      secondary: colors.ink,
      onSecondary: colors.background,
      secondaryContainer: colors.surfaceMuted,
      onSecondaryContainer: colors.ink,
      tertiary: colors.success,
      onTertiary: isDark ? const Color(0xFF042A1A) : Colors.white,
      tertiaryContainer: isDark
          ? const Color(0xFF123F2C)
          : const Color(0xFFDDF6E9),
      onTertiaryContainer: isDark
          ? const Color(0xFF9CE9C0)
          : const Color(0xFF0D5036),
      error: isDark ? const Color(0xFFFFB4AB) : const Color(0xFFBA1A1A),
      onError: isDark ? const Color(0xFF690005) : Colors.white,
      errorContainer: isDark
          ? const Color(0xFF93000A)
          : const Color(0xFFFFDAD6),
      onErrorContainer: isDark
          ? const Color(0xFFFFDAD6)
          : const Color(0xFF410002),
      surface: colors.surface,
      onSurface: colors.ink,
      surfaceContainerHighest: colors.surfaceMuted,
      onSurfaceVariant: colors.inkMuted,
      outline: colors.line,
      outlineVariant: colors.line.withValues(alpha: 0.65),
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: colors.ink,
      onInverseSurface: colors.background,
      inversePrimary: colors.accentSoft,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colors.background,
      fontFamily: FolioTypography.sans,
      textTheme: textTheme,
      extensions: [colors],
      splashFactory: InkRipple.splashFactory,
      visualDensity: VisualDensity.standard,
      dividerColor: colors.line,
      dividerTheme: DividerThemeData(
        color: colors.line,
        thickness: 1,
        space: 1,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        foregroundColor: colors.ink,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colors.accent,
        selectionColor: colors.accent.withValues(alpha: 0.24),
        selectionHandleColor: colors.accent,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colors.accent,
          foregroundColor: colors.onAccent,
          disabledBackgroundColor: colors.surfaceMuted,
          disabledForegroundColor: colors.inkMuted,
          elevation: 0,
          minimumSize: const Size(0, 52),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontFamily: FolioTypography.sans,
            fontSize: 14.5,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.1,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.ink,
          minimumSize: const Size(0, 52),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
          side: BorderSide(color: colors.line, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontFamily: FolioTypography.sans,
            fontSize: 14.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.ink,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontFamily: FolioTypography.sans,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(colors.ink),
          overlayColor: WidgetStatePropertyAll(
            colors.ink.withValues(alpha: 0.06),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surfaceElevated,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 17,
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(color: colors.inkMuted),
        labelStyle: textTheme.bodyMedium?.copyWith(color: colors.inkMuted),
        floatingLabelStyle: textTheme.bodySmall?.copyWith(color: colors.ink),
        errorStyle: textTheme.bodySmall?.copyWith(color: colorScheme.error),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colors.line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colors.line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colors.ink, width: 1.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorScheme.error, width: 1.6),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 70,
        elevation: 0,
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        indicatorColor: colors.accentSoft,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return textTheme.labelSmall!.copyWith(
            fontSize: 10,
            letterSpacing: 0.15,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
            color: selected ? colors.ink : colors.inkMuted,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            size: 23,
            color: selected ? colors.accent : colors.inkMuted,
          );
        }),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colors.surfaceElevated,
        selectedColor: colors.ink,
        disabledColor: colors.surfaceMuted,
        side: BorderSide(color: colors.line),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        labelStyle: textTheme.labelMedium?.copyWith(color: colors.inkMuted),
        secondaryLabelStyle: textTheme.labelMedium?.copyWith(
          color: colors.background,
        ),
        showCheckmark: false,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colors.ink,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: colors.background,
          fontWeight: FontWeight.w500,
        ),
        actionTextColor: colors.accent,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        insetPadding: const EdgeInsets.all(16),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: colors.ink,
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: textTheme.bodySmall?.copyWith(color: colors.background),
        waitDuration: const Duration(milliseconds: 450),
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStatePropertyAll(colors.ink.withValues(alpha: 0.18)),
        radius: const Radius.circular(100),
        thickness: const WidgetStatePropertyAll(5),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
    );
  }
}
