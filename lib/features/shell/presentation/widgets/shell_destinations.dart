import 'package:flutter/material.dart';
import 'package:folio/core/localization/app_localizations.dart';

enum ShellTab { home, explore, saved, about }

class ShellDestination {
  const ShellDestination(this.tab, this.selectedIcon, this.icon);

  final ShellTab tab;
  final IconData selectedIcon;
  final IconData icon;
}

const List<ShellDestination> shellDestinations = [
  ShellDestination(ShellTab.home, Icons.home_rounded, Icons.home_outlined),
  ShellDestination(
    ShellTab.explore,
    Icons.explore_rounded,
    Icons.explore_outlined,
  ),
  ShellDestination(
    ShellTab.saved,
    Icons.bookmark_rounded,
    Icons.bookmark_border_rounded,
  ),
  ShellDestination(
    ShellTab.about,
    Icons.person_rounded,
    Icons.person_outline_rounded,
  ),
];

String shellDestinationLabel(
  AppLocalizations l10n,
  ShellDestination destination,
) => switch (destination.tab) {
  ShellTab.home => l10n.home,
  ShellTab.explore => l10n.explore,
  ShellTab.saved => l10n.savedTab,
  ShellTab.about => l10n.about,
};
