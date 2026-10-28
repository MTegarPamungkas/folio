// Reports `context.tr(...)` literals that have no entry in the English map.
// Run with: dart run tool/check_strings.dart
import 'dart:io';

const _mapFile = 'lib/shared/presentation/l10n/app_strings.dart';

String _unescape(String raw) {
  final buffer = StringBuffer();
  for (var i = 0; i < raw.length; i++) {
    final char = raw[i];
    if (char != r'\' || i == raw.length - 1) {
      buffer.write(char);
      continue;
    }
    i++;
    switch (raw[i]) {
      case 'n':
        buffer.write('\n');
      case 't':
        buffer.write('\t');
      case r'\':
        buffer.write(r'\');
      case "'":
        buffer.write("'");
      default:
        buffer.write(raw[i]);
    }
  }
  return buffer.toString();
}

/// Parses one string literal starting at [start] (which must be a quote).
/// Returns the decoded literal and the index just past the closing quote.
({String value, int end})? _literal(String source, int start) {
  final quote = source[start];
  if (quote != "'" && quote != '"') return null;
  var i = start + 1;
  final buffer = StringBuffer();
  while (i < source.length) {
    final char = source[i];
    if (char == r'\') {
      buffer.write(source.substring(i, i + 2));
      i += 2;
      continue;
    }
    if (char == quote) {
      return (value: _unescape(buffer.toString()), end: i + 1);
    }
    buffer.write(char);
    i++;
  }
  return null;
}

const _call = r'(?:readTr|readTrArgs|tr|trArgs)\(';

Iterable<({String text})> _callKeys(String source) sync* {
  for (final match in RegExp(_call).allMatches(source)) {
    var i = match.end;
    final parts = <String>[];
    while (true) {
      while (i < source.length && ' \t\r\n'.contains(source[i])) {
        i++;
      }
      if (i >= source.length) break;
      final literal = _literal(source, i);
      if (literal == null) break;
      parts.add(literal.value);
      i = literal.end;
    }
    if (parts.isNotEmpty) yield (text: parts.join());
  }
}

void main() {
  final keys = <String>{};
  final mapSource = File(_mapFile).readAsStringSync();
  for (final line in mapSource.split('\n')) {
    final match = RegExp(r"^\s*'((?:[^'\\]|\\.)*)'\s*:").firstMatch(line);
    if (match != null) keys.add(_unescape(match.group(1)!));
  }

  final missing = <String, Set<String>>{};
  final files = Directory('lib')
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart'))
      .where((file) => !file.path.replaceAll(r'\', '/').endsWith(_mapFile));
  for (final file in files) {
    final source = file.readAsStringSync();
    for (final call in _callKeys(source)) {
      if (keys.contains(call.text)) continue;
      missing.putIfAbsent(call.text, () => <String>{}).add(file.path);
    }
  }

  if (missing.isEmpty) {
    stdout.writeln('All ${keys.length} keys are covered.');
    return;
  }
  missing.forEach((text, files) {
    stdout.writeln('MISSING: ${text.replaceAll('\n', r'\n')}');
    for (final file in files) {
      stdout.writeln('  $file');
    }
  });
  exitCode = 1;
}
