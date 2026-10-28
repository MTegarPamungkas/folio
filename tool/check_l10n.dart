// Verifies the hand-written localization class stays consistent.
//
// It checks that every entry calls `t(id, en)`, that names and source strings
// are unique, that placeholders match across both languages and the method
// signature, and that no entry is left unused. Run with:
// dart run tool/check_l10n.dart
import 'dart:io';

import 'l10n_entries.dart';

void main() {
  final parsed = parseL10nEntries(File(defaultL10nFile).readAsStringSync());
  final problems = <String>[
    for (final entry in parsed)
      if (entry == null) 'UNPARSED ENTRY: expected t(id, en)',
  ];
  final entries = [for (final entry in parsed) ?entry];

  if (entries.length < 100) {
    stderr.writeln(
      'Only ${entries.length} entries parsed from $defaultL10nFile.',
    );
    exitCode = 1;
    return;
  }

  final names = <String, int>{};
  final sources = <String, int>{};
  for (final entry in entries) {
    names.update(entry.name, (count) => count + 1, ifAbsent: () => 1);
    sources.update(entry.id, (count) => count + 1, ifAbsent: () => 1);

    final idPlaceholders = _placeholders(entry.id);
    final enPlaceholders = _placeholders(entry.en);
    if (idPlaceholders.length != enPlaceholders.length ||
        !idPlaceholders.containsAll(enPlaceholders)) {
      problems.add(
        'PLACEHOLDER MISMATCH: ${entry.name}\n'
        '  id: ${idPlaceholders.join(', ')}\n'
        '  en: ${enPlaceholders.join(', ')}',
      );
    }
    if (entry.params.length != idPlaceholders.length ||
        !entry.params.toSet().containsAll(idPlaceholders)) {
      problems.add(
        'SIGNATURE MISMATCH: ${entry.name}\n'
        '  params: ${entry.params.join(', ')}\n'
        '  placeholders: ${idPlaceholders.join(', ')}',
      );
    }
  }

  names.forEach((name, count) {
    if (count > 1) problems.add('DUPLICATE NAME: $name ($count times)');
  });
  sources.forEach((source, count) {
    if (count > 1) {
      problems.add('DUPLICATE SOURCE: ${source.replaceAll('\n', r'\n')}');
    }
  });

  final libFiles = Directory('lib')
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart'))
      .where(
        (file) => !file.path.replaceAll(r'\', '/').endsWith(defaultL10nFile),
      );
  final sourcesText = [for (final file in libFiles) file.readAsStringSync()];
  final unused = [
    for (final entry in entries)
      if (!sourcesText.any(
        (source) => RegExp('\\.${entry.name}\\b').hasMatch(source),
      ))
        entry.name,
  ];
  if (unused.isNotEmpty) {
    problems.add('UNUSED ENTRIES:\n  ${unused.join('\n  ')}');
  }

  if (problems.isEmpty) {
    stdout.writeln('${entries.length} localization entries are consistent.');
    return;
  }
  problems.forEach(stderr.writeln);
  exitCode = 1;
}

/// Placeholders appear either as `{name}` or as `$name` interpolation.
Set<String> _placeholders(String value) => {
  ...RegExp(r'\{([^}]+)\}').allMatches(value).map((match) => match.group(1)!),
  ...RegExp(
    r'\$([A-Za-z_]\w*)',
  ).allMatches(value).map((match) => match.group(1)!),
};
