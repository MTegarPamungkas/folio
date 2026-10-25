import 'package:flutter/material.dart';
import 'package:folio/core/responsive/app_breakpoints.dart';
import 'package:folio/features/shell/presentation/widgets/mobile_navigation.dart';
import 'package:folio/features/shell/presentation/widgets/mobile_top_bar.dart';
import 'package:folio/features/shell/presentation/widgets/side_navigation.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _go(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (context.usesSideNavigation) {
      return Scaffold(
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SideNavigation(
              currentIndex: navigationShell.currentIndex,
              onSelect: _go,
            ),
            Expanded(child: navigationShell),
          ],
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          MobileTopBar(
            currentIndex: navigationShell.currentIndex,
            onSearch: () => _go(1),
            onProfile: () => _go(3),
          ),
          Expanded(child: navigationShell),
        ],
      ),
      bottomNavigationBar: MobileNavigation(
        currentIndex: navigationShell.currentIndex,
        onSelect: _go,
      ),
    );
  }
}
