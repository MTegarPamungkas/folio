import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/app_language.dart';
import 'package:folio/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:folio/features/settings/presentation/bloc/settings_event.dart';
import 'package:folio/shared/presentation/l10n/app_strings.dart';

class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    final language = context.select<SettingsBloc, AppLanguage>(
      (bloc) => bloc.state.language,
    );

    return PopupMenuButton<AppLanguage>(
      tooltip: context.tr('Ganti bahasa'),
      initialValue: language,
      onSelected: (value) =>
          context.read<SettingsBloc>().add(SettingsLanguageChanged(value)),
      position: PopupMenuPosition.over,
      itemBuilder: (context) => [
        for (final option in AppLanguage.values)
          PopupMenuItem<AppLanguage>(
            value: option,
            child: Row(
              children: [
                Icon(
                  option == language
                      ? Icons.radio_button_checked_rounded
                      : Icons.radio_button_unchecked_rounded,
                  size: 17,
                  color: option == language ? colors.accent : colors.inkMuted,
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    option.nativeName,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                      fontWeight: option == language
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  option.shortLabel,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 9,
                    letterSpacing: 0.6,
                    color: colors.inkMuted,
                  ),
                ),
              ],
            ),
          ),
      ],
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 9 : 11,
          vertical: compact ? 7 : 8,
        ),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: colors.line),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.translate_rounded,
              size: compact ? 13 : 14,
              color: colors.inkMuted,
            ),
            const SizedBox(width: 6),
            Text(
              language.shortLabel,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: compact ? 9 : 10,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w700,
                color: colors.ink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
