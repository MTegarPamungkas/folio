import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:folio/core/router/app_router.dart';
import 'package:folio/core/theme/folio_theme.dart';
import 'package:folio/features/explore/presentation/bloc/explore_bloc.dart';
import 'package:folio/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:folio/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:folio/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:folio/features/settings/presentation/bloc/settings_state.dart';

class FolioApp extends StatelessWidget {
  const FolioApp({
    super.key,
    required this.settingsBloc,
    required this.favoritesBloc,
    required this.exploreBloc,
    required this.profileBloc,
  });

  final SettingsBloc settingsBloc;
  final FavoritesBloc favoritesBloc;
  final ExploreBloc exploreBloc;
  final ProfileBloc profileBloc;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingsBloc>.value(value: settingsBloc),
        BlocProvider<FavoritesBloc>.value(value: favoritesBloc),
        BlocProvider<ExploreBloc>.value(value: exploreBloc),
        BlocProvider<ProfileBloc>.value(value: profileBloc),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, settings) {
          return MaterialApp.router(
            title: 'Folio — Muhammad Tegar',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: settings.themeMode.materialThemeMode,
            locale: settings.language.locale,
            supportedLocales: AppLanguageLocales.supported,
            localizationsDelegates: AppLanguageLocales.delegates,
            routerConfig: appRouter,
            scrollBehavior: const FolioScrollBehavior(),
          );
        },
      ),
    );
  }
}

/// The languages this portfolio ships in, plus the Material delegates that
/// localize built-in widgets (date pickers, tooltips, text selection…).
abstract final class AppLanguageLocales {
  static const supported = [Locale('id'), Locale('en')];

  static const delegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
}

class FolioScrollBehavior extends MaterialScrollBehavior {
  const FolioScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.stylus,
  };
}
