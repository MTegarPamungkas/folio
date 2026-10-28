import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/core/di/injection_container.dart';
import 'package:folio/features/about/presentation/bloc/about_bloc.dart';
import 'package:folio/features/about/presentation/bloc/about_event.dart';
import 'package:folio/features/about/presentation/pages/about_page.dart';
import 'package:folio/features/contact/presentation/bloc/contact_bloc.dart';
import 'package:folio/features/contact/presentation/pages/contact_page.dart';
import 'package:folio/features/explore/presentation/pages/explore_page.dart';
import 'package:folio/features/home/presentation/bloc/home_bloc.dart';
import 'package:folio/features/home/presentation/bloc/home_event.dart';
import 'package:folio/features/home/presentation/pages/home_page.dart';
import 'package:folio/features/project/presentation/bloc/project_detail_bloc.dart';
import 'package:folio/features/project/presentation/bloc/project_detail_event.dart';
import 'package:folio/features/project/presentation/pages/project_detail_page.dart';
import 'package:folio/features/saved/presentation/bloc/saved_bloc.dart';
import 'package:folio/features/saved/presentation/pages/saved_page.dart';
import 'package:folio/features/shell/presentation/widgets/app_shell.dart';
import 'package:folio/shared/presentation/l10n/app_strings.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              name: 'home',
              builder: (context, state) => BlocProvider(
                create: (_) => getIt<HomeBloc>()..add(const HomeStarted()),
                child: const HomePage(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/explore',
              name: 'explore',
              builder: (context, state) => const ExplorePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/saved',
              name: 'saved',
              builder: (context, state) => BlocProvider(
                create: (_) => getIt<SavedBloc>(),
                child: const SavedPage(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/about',
              name: 'about',
              builder: (context, state) => BlocProvider(
                create: (_) => getIt<AboutBloc>()..add(const AboutStarted()),
                child: const AboutPage(),
              ),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/project/:id',
      name: 'project',
      parentNavigatorKey: rootNavigatorKey,
      pageBuilder: (context, state) {
        final projectId = state.pathParameters['id']!;
        return _fadePage(
          state,
          BlocProvider(
            create: (_) =>
                getIt<ProjectDetailBloc>(param1: projectId)
                  ..add(const ProjectDetailStarted()),
            child: ProjectDetailPage(projectId: projectId),
          ),
        );
      },
    ),
    GoRoute(
      path: '/contact',
      name: 'contact',
      parentNavigatorKey: rootNavigatorKey,
      pageBuilder: (context, state) {
        final projectId = state.uri.queryParameters['project'];
        return _fadePage(
          state,
          BlocProvider(
            create: (_) => getIt<ContactBloc>(param1: projectId),
            child: const ContactPage(),
          ),
        );
      },
    ),
  ],
  errorBuilder: (context, state) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.explore_off_rounded, size: 48),
              const SizedBox(height: 14),
              Text(
                context.tr('Halaman tidak ditemukan'),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 18),
              FilledButton(
                onPressed: () => context.go('/'),
                child: Text(context.tr('Kembali ke beranda')),
              ),
            ],
          ),
        ),
      ),
    );
  },
);

CustomTransitionPage<void> _fadePage(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 280),
    reverseTransitionDuration: const Duration(milliseconds: 220),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.025),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
}
