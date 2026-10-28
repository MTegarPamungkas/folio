// Parses `lib/core/localization/app_localizations.dart` without running it.
//
// The file is hand-written Dart, so this small scanner reads one declaration at
// a time and extracts the `t(id, en)` arguments of every entry. It is shared by
// the consistency check and by render verification tooling.
import 'dart:io';

const defaultL10nFile = 'lib/core/localization/app_localizations.dart';

final _declaration = RegExp(r'^  String (?:get )?(\w+)');

class L10nEntry {
  const L10nEntry({
    required this.name,
    required this.params,
    required this.id,
    required this.en,
  });

  final String name;
  final List<String> params;
  final String id;
  final String en;

  bool get isParameterized => params.isNotEmpty;
}

/// Returns `null` when a declaration cannot be parsed as a `t(id, en)` entry.
List<L10nEntry?> parseL10nEntries(String source) {
  final lines = source.split('\n');
  final entries = <L10nEntry?>[];

  var index = 0;
  while (index < lines.length) {
    final match = _declaration.firstMatch(lines[index]);
    if (match == null) {
      index++;
      continue;
    }
    final name = match.group(1)!;
    final block = StringBuffer();
    var depth = 0;
    var quote = '';
    var started = false;
    var complete = false;
    while (index < lines.length) {
      final line = lines[index++];
      block.writeln(line);
      for (var i = 0; i < line.length; i++) {
        final char = line[i];
        if (quote.isNotEmpty) {
          if (char == r'\') {
            i++;
          } else if (char == quote) {
            quote = '';
          }
          continue;
        }
        if (char == "'" || char == '"') {
          quote = char;
        } else if (char == '(') {
          depth++;
          started = true;
        } else if (char == ')') {
          depth--;
        } else if (char == ';' && started && depth == 0) {
          complete = true;
          break;
        }
      }
      if (complete) break;
    }

    if (name == 't') continue;
    entries.add(_parseEntry(name, block.toString()));
  }
  return entries;
}

List<L10nEntry> loadL10nEntries([String path = defaultL10nFile]) => [
  for (final entry in parseL10nEntries(File(path).readAsStringSync())) ?entry,
];

L10nEntry? _parseEntry(String name, String text) {
  final arrow = text.indexOf('=>');
  if (arrow < 0) return null;
  final call = text.indexOf('t(', arrow);
  if (call < 0) return null;

  final header = text.substring(0, arrow);
  final open = header.indexOf('(');
  final close = header.lastIndexOf(')');
  final params = open >= 0 && close > open
      ? header
            .substring(open + 1, close)
            .split(',')
            .map((param) => param.trim())
            .where((param) => param.isNotEmpty)
            .map((param) => param.split(' ').last)
            .toList()
      : const <String>[];

  var cursor = call + 2;
  final id = _readLiteral(text, cursor);
  if (id == null) return null;
  cursor = id.end;
  while (cursor < text.length && text[cursor] != ',') {
    if (text[cursor].trim().isNotEmpty && text[cursor] != ')') return null;
    cursor++;
  }
  final en = _readLiteral(text, cursor + 1);
  if (en == null) return null;

  return L10nEntry(name: name, params: params, id: id.value, en: en.value);
}

({String value, int end})? _readLiteral(String text, int start) {
  var cursor = start;
  while (cursor < text.length && text[cursor].trim().isEmpty) {
    cursor++;
  }
  if (cursor >= text.length) return null;
  final quote = text[cursor];
  if (quote != "'" && quote != '"') return null;
  cursor++;

  final buffer = StringBuffer();
  while (cursor < text.length) {
    final char = text[cursor];
    if (char == r'\') {
      cursor++;
      if (cursor >= text.length) return null;
      buffer.write(switch (text[cursor]) {
        'n' => '\n',
        't' => '\t',
        'r' => '\r',
        r'\' => r'\',
        "'" => "'",
        '"' => '"',
        final other => other,
      });
      cursor++;
      continue;
    }
    if (char == quote) return (value: buffer.toString(), end: cursor + 1);
    buffer.write(char);
    cursor++;
  }
  return null;
}
