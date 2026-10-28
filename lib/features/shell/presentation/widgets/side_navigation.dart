import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:folio/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:folio/features/shell/presentation/widgets/shell_destinations.dart';
import 'package:folio/core/localization/app_localizations.dart';
import 'package:folio/shared/presentation/widgets/brand/developer_avatar.dart';
import 'package:folio/shared/presentation/widgets/brand/folio_wordmark.dart';
import 'package:folio/shared/presentation/widgets/navigation/language_toggle.dart';
import 'package:folio/shared/presentation/widgets/navigation/theme_toggle.dart';
import 'package:go_router/go_router.dart';

class SideNavigation extends StatelessWidget {
  const SideNavigation({
    super.key,
    required this.currentIndex,
    required this.onSelect,
  });

  final int currentIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    final profile = context.watch<ProfileBloc>().state.developer;
    final savedCount = context.select<FavoritesBloc, int>(
      (bloc) => bloc.state.count,
    );

    return Container(
      width: 266,
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(right: BorderSide(color: colors.line)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 24, 22, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => onSelect(0),
                borderRadius: BorderRadius.circular(12),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                  child: FolioWordmark(fontSize: 29),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  context.l10n.portfolio,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 9,
                    letterSpacing: 1.3,
                    color: colors.inkMuted,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (var i = 0; i < shellDestinations.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: _SideNavItem(
                            destination: shellDestinations[i],
                            selected: currentIndex == i,
                            badge: i == 2 && savedCount > 0
                                ? '$savedCount'
                                : null,
                            onTap: () => onSelect(i),
                          ),
                        ),
                      const SizedBox(height: 26),
                      const _ContactCard(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Divider(color: colors.line),
              const SizedBox(height: 14),
              InkWell(
                onTap: () => onSelect(3),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      DeveloperAvatar(
                        initials: profile.initials,
                        size: 38,
                        onTap: () => onSelect(3),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profile.name,
                              style: Theme.of(
                                context,
                              ).textTheme.titleSmall?.copyWith(fontSize: 13),
                            ),
                            Text(
                              profile.role.split(' / ').first,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.more_horiz_rounded,
                        size: 17,
                        color: colors.inkMuted,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const LanguageToggle(compact: true),
              const SizedBox(height: 6),
              const ThemeToggle(compact: true),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard();

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.ink,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 31,
            height: 31,
            decoration: BoxDecoration(
              color: colors.accent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.north_east_rounded,
              size: 17,
              color: colors.onAccent,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            context.l10n.ideaPrompt,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: colors.background,
              height: 1.25,
              letterSpacing: -0.35,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            context.l10n.collaboratePrompt,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: colors.background.withValues(alpha: 0.62),
              fontSize: 11,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 14),
          InkWell(
            onTap: () => context.push('/contact'),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      context.l10n.collaborateCta,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: colors.accent,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 13,
                    color: colors.accent,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SideNavItem extends StatefulWidget {
  const _SideNavItem({
    required this.destination,
    required this.selected,
    required this.onTap,
    this.badge,
  });

  final ShellDestination destination;
  final bool selected;
  final VoidCallback onTap;
  final String? badge;

  @override
  State<_SideNavItem> createState() => _SideNavItemState();
}

class _SideNavItemState extends State<_SideNavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    return Semantics(
      selected: widget.selected,
      button: true,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: widget.selected
                ? colors.surfaceMuted
                : _hovered
                ? colors.surfaceMuted.withValues(alpha: 0.55)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(13),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Icon(
                      widget.selected
                          ? widget.destination.selectedIcon
                          : widget.destination.icon,
                      size: 20,
                      color: widget.selected ? colors.ink : colors.inkMuted,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        shellDestinationLabel(context.l10n, widget.destination),
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: widget.selected
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: widget.selected ? colors.ink : colors.inkMuted,
                        ),
                      ),
                    ),
                    if (widget.badge != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: colors.accentSoft,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          widget.badge!,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                fontSize: 9,
                                letterSpacing: 0,
                                color: colors.accent,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      )
                    else if (widget.selected)
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: colors.accent,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
