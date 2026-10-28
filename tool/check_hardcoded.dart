// Lists string literals in lib/ that look like Indonesian UI copy but are not
// routed through context.tr/readTr. Run with: dart run tool/check_hardcoded.dart
import 'dart:io';

const _mapFile = 'lib/shared/presentation/l10n/app_strings.dart';

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
final _trPrefix = RegExp(r'(?:readTr|readTrArgs|tr|trArgs)\(\s*$');

/// Whether the literal ending at [end] is an argument of a `tr`-style call.
/// Walks backwards across whitespace and adjacent literals (implicit string
/// concatenation) until it meets the call parenthesis or something else.
bool _isTrArgument(String source, int start, int end) {
  var index = start;
  while (true) {
    // Skip whitespace before the literal.
    while (index > 0 && ' \t\r\n'.contains(source[index - 1])) {
      index--;
    }
    if (index == 0) return false;
    if (_trPrefix.hasMatch(source.substring(0, index))) return true;
    final char = source[index - 1];
    if (char != "'" && char != '"') return false;
    // Walk back over the preceding literal.
    var cursor = index - 2;
    while (cursor >= 0) {
      if (source[cursor] == r'\') {
        cursor -= 2;
        continue;
      }
      if (source[cursor] == char) break;
      cursor--;
    }
    if (cursor < 0) return false;
    index = cursor;
  }
}

void main() {
  final found = <String, Set<String>>{};
  final files = Directory('lib')
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart'))
      .where((file) => !file.path.replaceAll(r'\', '/').endsWith(_mapFile));
  for (final file in files) {
    final path = file.path.replaceAll(r'\', '/');
    if (path.contains('/data/') || path.contains('/core/di/')) continue;
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
      if (_isTrArgument(source, match.start, match.end)) continue;
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
}
