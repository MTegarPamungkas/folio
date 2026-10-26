import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/core/responsive/adaptive_layouts.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/domain/entities/app_theme_mode.dart';
import 'package:folio/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:folio/features/settings/presentation/bloc/settings_event.dart';
import 'package:folio/features/settings/presentation/bloc/settings_state.dart';
import 'package:go_router/go_router.dart';

class PreferencesContactSection extends StatelessWidget {
  const PreferencesContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const AdaptiveTwoPane(
      breakpoint: 840,
      gap: 14,
      compactGap: 14,
      start: PreferencesCard(),
      end: ContactInvite(),
    );
  }
}

class PreferencesCard extends StatelessWidget {
  const PreferencesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: colors.surfaceMuted,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(
                  Icons.tune_rounded,
                  size: 17,
                  color: colors.inkMuted,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Preferensi tampilan',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Pilih tema yang paling nyaman. Pilihanmu disimpan di perangkat ini.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 11,
              height: 1.5,
              color: colors.inkMuted,
            ),
          ),
          const SizedBox(height: 16),
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, settings) {
              return Row(
                children: [
                  for (final mode in AppThemeMode.values) ...[
                    if (mode != AppThemeMode.values.first)
                      const SizedBox(width: 6),
                    Expanded(
                      child: ThemeChoice(
                        mode: mode,
                        selected: settings.themeMode == mode,
                        onTap: () => context.read<SettingsBloc>().add(
                          SettingsThemeModeChanged(mode),
                        ),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class ThemeChoice extends StatelessWidget {
  const ThemeChoice({
    super.key,
    required this.mode,
    required this.selected,
    required this.onTap,
  });

  final AppThemeMode mode;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    final (icon, label) = switch (mode) {
      AppThemeMode.system => (Icons.brightness_auto_rounded, 'Sistem'),
      AppThemeMode.light => (Icons.light_mode_outlined, 'Terang'),
      AppThemeMode.dark => (Icons.dark_mode_outlined, 'Gelap'),
    };
    return Semantics(
      button: true,
      selected: selected,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 5),
          decoration: BoxDecoration(
            color: selected ? colors.ink : colors.surfaceElevated,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: selected ? colors.ink : colors.line),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 17,
                color: selected ? colors.background : colors.inkMuted,
              ),
              const SizedBox(height: 5),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 9,
                  letterSpacing: 0.1,
                  fontWeight: FontWeight.w600,
                  color: selected ? colors.background : colors.inkMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactInvite extends StatelessWidget {
  const ContactInvite({super.key});

  @override
  Widget build(BuildContext context) {
    const ink = Color(0xFF241009);
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: context.folio.accent,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -35,
            top: -40,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ink.withValues(alpha: 0.15)),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ADA YANG INGIN DIBANGUN?',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: ink.withValues(alpha: 0.64),
                  fontSize: 8.5,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Ceritakan idemu.',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: ink,
                  fontSize: 30,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Saya terbuka untuk proyek produk, aplikasi, dan kolaborasi jangka panjang.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: ink.withValues(alpha: 0.72),
                  fontSize: 11,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () => context.push('/contact'),
                style: FilledButton.styleFrom(
                  backgroundColor: ink,
                  foregroundColor: const Color(0xFFFFF5EF),
                  minimumSize: const Size(0, 46),
                ),
                icon: const Icon(Icons.arrow_outward_rounded, size: 16),
                label: const Text('Mulai percakapan'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
