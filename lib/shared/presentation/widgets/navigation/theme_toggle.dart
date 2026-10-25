import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:folio/features/settings/presentation/bloc/settings_event.dart';
import 'package:folio/features/settings/presentation/bloc/settings_state.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, settings) {
        return Tooltip(
          message: isDark ? 'Ganti ke tema terang' : 'Ganti ke tema gelap',
          child: InkWell(
            onTap: () => context.read<SettingsBloc>().add(
              SettingsThemeToggled(isCurrentlyDark: isDark),
            ),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: compact ? 4 : 10,
                vertical: 7,
              ),
              child: Row(
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 180),
                    child: Icon(
                      isDark
                          ? Icons.light_mode_outlined
                          : Icons.dark_mode_outlined,
                      key: ValueKey(isDark),
                      size: 17,
                      color: colors.inkMuted,
                    ),
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      compact
                          ? (isDark ? 'Tema terang' : 'Tema gelap')
                          : 'Tema',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colors.inkMuted,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  if (!compact)
                    Text(
                      isDark ? 'Gelap' : 'Terang',
                      style: theme.textTheme.bodySmall?.copyWith(fontSize: 11),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
