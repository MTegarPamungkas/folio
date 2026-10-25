enum AppThemeMode {
  system,
  light,
  dark;

  static AppThemeMode fromStorage(String? value) {
    return switch (value) {
      'light' => AppThemeMode.light,
      'dark' => AppThemeMode.dark,
      _ => AppThemeMode.system,
    };
  }
}
