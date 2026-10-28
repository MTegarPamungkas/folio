/// The languages the portfolio is published in.
enum AppLanguage {
  id('id', 'Bahasa Indonesia', 'ID'),
  en('en', 'English', 'EN');

  const AppLanguage(this.code, this.nativeName, this.shortLabel);

  final String code;
  final String nativeName;
  final String shortLabel;

  bool get isEnglish => this == AppLanguage.en;

  static AppLanguage fromCode(String? code) {
    for (final language in values) {
      if (language.code == code) return language;
    }
    return AppLanguage.id;
  }
}
