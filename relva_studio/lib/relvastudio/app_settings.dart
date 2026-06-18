import 'package:flutter/material.dart';

// ─── Theme Modes ─────────────────────────────────────────────────────────────
// light = REV palette (pink/purple, light bg)
// dark  = REV palette (pink/purple, dark bg)
enum AppThemeMode { light, dark }

// ─── Language ────────────────────────────────────────────────────────────────
enum AppLanguage { en, id }

// ─── Settings Notifier ───────────────────────────────────────────────────────
class AppSettings extends ChangeNotifier {
  AppThemeMode _theme = AppThemeMode.light;
  AppLanguage _language = AppLanguage.en;

  AppThemeMode get theme => _theme;
  AppLanguage get language => _language;

  void setTheme(AppThemeMode mode) {
    _theme = mode;
    notifyListeners();
  }

  void setLanguage(AppLanguage lang) {
    _language = lang;
    notifyListeners();
  }

  // ─── Color palettes ────────────────────────────────────────────────────────
  // Light = REV palette (pink/purple, light bg) matching CSS .rev
  static const _lightPrimary  = Color(0xFF9B6DD6);  // light purple
  static const _lightBackground = Color(0xFFF8F4FF); // very light lavender
  static const _lightSurface  = Color(0xFFEEE6FF);
  static const _lightCard     = Color(0xFFFFFFFF);
  static const _lightText     = Color(0xFF3D1F7A);   // deep purple
  static const _lightSubText  = Color(0xFF7A5BAD);
  static const _lightAccent   = Color(0xFFF0C4DD);   // light pink
  static const _lightGrad1    = Color(0xFFD8B4FE);   // lavender
  static const _lightGrad2    = Color(0xFFF9A8D4);   // pink

  // Dark = REV palette but darkened matching CSS .dark spirit with purple hues
  static const _darkPrimary   = Color(0xFFCBA8F0);   // soft light purple
  static const _darkBackground = Color(0xFF130D1F);  // very dark purple-black
  static const _darkSurface   = Color(0xFF1E1430);   // dark purple
  static const _darkCard      = Color(0xFF261A3D);   // slightly lighter dark purple
  static const _darkText      = Color(0xFFF0E8FF);   // light lavender white
  static const _darkSubText   = Color(0xFFAA90D4);   // muted lavender
  static const _darkAccent    = Color(0xFFD4608A);   // muted pink
  static const _darkGrad1     = Color(0xFF1A0D2E);   // dark purple
  static const _darkGrad2     = Color(0xFF2D1052);   // deep violet

  // ─── Getters ───────────────────────────────────────────────────────────────
  Color get primaryColor => _theme == AppThemeMode.dark
      ? _darkPrimary
      : _lightPrimary;

  Color get backgroundColor => _theme == AppThemeMode.dark
      ? _darkBackground
      : _lightBackground;

  Color get surfaceColor => _theme == AppThemeMode.dark
      ? _darkSurface
      : _lightSurface;

  Color get cardColor => _theme == AppThemeMode.dark
      ? _darkCard
      : _lightCard;

  Color get textColor => _theme == AppThemeMode.dark
      ? _darkText
      : _lightText;

  Color get subTextColor => _theme == AppThemeMode.dark
      ? _darkSubText
      : _lightSubText;

  Color get accentColor => _theme == AppThemeMode.dark
      ? _darkAccent
      : _lightAccent;

  LinearGradient get backgroundGradient => _theme == AppThemeMode.dark
      ? const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_darkGrad1, _darkGrad2],
        )
      : const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_lightGrad1, _lightGrad2],
        );

  Color get navBg => _theme == AppThemeMode.dark
      ? const Color(0xFF1E1430).withValues(alpha: 0.97)
      : const Color(0xFFF8F4FF).withValues(alpha: 0.97);

  Brightness get brightness =>
      _theme == AppThemeMode.dark ? Brightness.dark : Brightness.light;

  // ─── MaterialApp ThemeData ─────────────────────────────────────────────────
  ThemeData get themeData => ThemeData(
        brightness: brightness,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: ColorScheme(
          brightness: brightness,
          primary: primaryColor,
          onPrimary: _theme == AppThemeMode.dark
              ? const Color(0xFF130D1F)
              : Colors.white,
          secondary: accentColor,
          onSecondary: Colors.white,
          error: const Color(0xFFCF6679),
          onError: Colors.white,
          surface: surfaceColor,
          onSurface: textColor,
        ),
        cardTheme: CardThemeData(
          color: cardColor,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
          ),
        ),
      );
}

// ─── Inherited Widget ─────────────────────────────────────────────────────────
class AppSettingsProvider extends InheritedNotifier<AppSettings> {
  const AppSettingsProvider({
    super.key,
    required AppSettings settings,
    required super.child,
  }) : super(notifier: settings);

  static AppSettings of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<AppSettingsProvider>();
    assert(provider != null, 'No AppSettingsProvider found in context');
    return provider!.notifier!;
  }
}
