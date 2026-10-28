// Lists string literals in lib/ that look like Indonesian UI copy but are not
// part of the localization class. Run with: dart run tool/check_hardcoded.dart
import 'dart:io';

const _localizationDir = 'lib/core/localization/';

/// Files that legitimately keep Indonesian source strings: content fixtures,
/// identifiers sent in emails, and enum labels that are mapped by the
/// localization class.
const _allowedPaths = [
  '/data/',
  '/core/di/',
  '/features/contact/presentation/bloc/',
  '/shared/presentation/theme/project_visuals.dart',
  // Native language names are proper nouns, not UI copy.
  '/domain/entities/app_language.dart',
];

const _words = [
  'yang',
  'dan',
  'untuk',
  'dengan',
  'tidak',
  'bisa',
  'kamu',
  'saya',
  'aku',
  'proyek',
  'karya',
  'halaman',
  'tombol',
  'cari',
  'lihat',
  'simpan',
  'buka',
  'tutup',
  'baru',
  'semua',
  'lagi',
  'sudah',
  'belum',
  'atau',
  'dari',
  'ini',
  'itu',
  'juga',
  'akan',
  'pada',
  'adalah',
  'sedang',
  'tanpa',
  'lebih',
  'paling',
  'tentang',
  'jelajah',
  'beranda',
  'tersimpan',
  'kontak',
  'pesan',
  'nama',
  'kirim',
  'pilih',
  'bahasa',
  'tema',
  'unduh',
  'tautan',
  'layar',
  'situs',
  'rilis',
  'fitur',
  'tangkapan',
  'geser',
  'kembali',
  'ganti',
  'terang',
  'gelap',
  'salin',
  'disalin',
  'kesalahan',
  'gagal',
  'memuat',
];

final _literalPattern = RegExp(r"'((?:[^'\\]|\\.)*)'");

void main() {
  final found = <String, Set<String>>{};
  final files = Directory('lib')
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart'));
  for (final file in files) {
    final path = file.path.replaceAll(r'\', '/');
    if (path.endsWith(_localizationDir) ||
        path.contains(_localizationDir) ||
        _allowedPaths.any(path.contains)) {
      continue;
    }
    final source = file.readAsStringSync();
    for (final match in _literalPattern.allMatches(source)) {
      final value = match.group(1)!;
      if (value.startsWith('package:') || value.startsWith('assets/')) {
        continue;
      }
      if (value.length < 3 || !value.contains(' ')) continue;
      final lower = value.toLowerCase();
      final looksIndonesian = _words.any(
        (word) => RegExp(
          '(^|[^a-z])$word([^a-z]|'
          r'$)',
        ).hasMatch(lower),
      );
      if (!looksIndonesian) continue;
      found.putIfAbsent(value, () => <String>{}).add(path);
    }
  }
  if (found.isEmpty) {
    stdout.writeln('No hardcoded Indonesian copy found.');
    return;
  }
  found.forEach((text, files) {
    stdout.writeln('SUSPECT: $text');
    for (final file in files) {
      stdout.writeln('  $file');
    }
  });
  exitCode = 1;
}
