import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:folio/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:folio/features/settings/presentation/bloc/settings_event.dart';
import 'package:folio/core/localization/app_localizations.dart';
import 'package:folio/shared/presentation/widgets/brand/developer_avatar.dart';
import 'package:folio/shared/presentation/widgets/brand/folio_wordmark.dart';
import 'package:folio/shared/presentation/widgets/navigation/language_toggle.dart';
import 'package:go_router/go_router.dart';

class MobileTopBar extends StatelessWidget {
  const MobileTopBar({
    super.key,
    required this.currentIndex,
    required this.onSearch,
    required this.onProfile,
  });

  final int currentIndex;
  final VoidCallback onSearch;
  final VoidCallback onProfile;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final initials = context.select<ProfileBloc, String>(
      (bloc) => bloc.state.developer.initials,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.background,
        border: Border(bottom: BorderSide(color: colors.line)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 12, 10),
          child: Row(
            children: [
              // The wordmark shrinks instead of overflowing when the reader
              // uses large text or a narrow phone.
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () => context.go('/'),
                    borderRadius: BorderRadius.circular(10),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: FolioWordmark(fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ),
              if (currentIndex != 1)
                Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: IconButton(
                    onPressed: onSearch,
                    tooltip: context.l10n.searchWork,
                    icon: const Icon(Icons.search_rounded, size: 22),
                  ),
                ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 2),
                child: LanguageToggle(compact: true),
              ),
              IconButton(
                onPressed: () => context.read<SettingsBloc>().add(
                  SettingsThemeToggled(isCurrentlyDark: isDark),
                ),
                tooltip: isDark
                    ? context.l10n.switchToLightTheme
                    : context.l10n.switchToDarkTheme,
                icon: Icon(
                  isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                  size: 21,
                ),
              ),
              const SizedBox(width: 3),
              DeveloperAvatar(
                initials: initials,
                size: 34,
                showStatus: false,
                onTap: onProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
