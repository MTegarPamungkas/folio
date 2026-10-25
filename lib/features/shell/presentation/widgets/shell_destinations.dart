import 'package:flutter/material.dart';

class ShellDestination {
  const ShellDestination(this.label, this.selectedIcon, this.icon);

  final String label;
  final IconData selectedIcon;
  final IconData icon;
}

const List<ShellDestination> shellDestinations = [
  ShellDestination('Beranda', Icons.home_rounded, Icons.home_outlined),
  ShellDestination('Jelajah', Icons.explore_rounded, Icons.explore_outlined),
  ShellDestination(
    'Tersimpan',
    Icons.bookmark_rounded,
    Icons.bookmark_border_rounded,
  ),
  ShellDestination(
    'Tentang',
    Icons.person_rounded,
    Icons.person_outline_rounded,
  ),
];
