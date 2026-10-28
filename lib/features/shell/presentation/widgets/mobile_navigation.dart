import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:folio/features/shell/presentation/widgets/shell_destinations.dart';
import 'package:folio/shared/presentation/l10n/app_strings.dart';

class MobileNavigation extends StatelessWidget {
  const MobileNavigation({
    super.key,
    required this.currentIndex,
    required this.onSelect,
  });

  final int currentIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final colors = context.folio;
    final savedCount = context.select<FavoritesBloc, int>(
      (bloc) => bloc.state.count,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(top: BorderSide(color: colors.line)),
      ),
      child: SafeArea(
        top: false,
        child: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: onSelect,
          destinations: [
            for (var i = 0; i < shellDestinations.length; i++)
              NavigationDestination(
                icon: i == 2 && savedCount > 0
                    ? Badge.count(
                        count: savedCount,
                        backgroundColor: colors.accent,
                        textColor: colors.onAccent,
                        child: Icon(shellDestinations[i].icon),
                      )
                    : Icon(shellDestinations[i].icon),
                selectedIcon: i == 2 && savedCount > 0
                    ? Badge.count(
                        count: savedCount,
                        backgroundColor: colors.accent,
                        textColor: colors.onAccent,
                        child: Icon(shellDestinations[i].selectedIcon),
                      )
                    : Icon(shellDestinations[i].selectedIcon),
                label: context.tr(shellDestinations[i].label),
                tooltip: context.tr(shellDestinations[i].label),
              ),
          ],
        ),
      ),
    );
  }
}
