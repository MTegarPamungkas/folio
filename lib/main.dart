import 'package:flutter/material.dart';
import 'package:folio/app.dart';
import 'package:folio/core/di/injection_container.dart';
import 'package:folio/features/explore/presentation/bloc/explore_bloc.dart';
import 'package:folio/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:folio/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:folio/features/settings/presentation/bloc/settings_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(
    FolioApp(
      settingsBloc: getIt<SettingsBloc>(),
      favoritesBloc: getIt<FavoritesBloc>(),
      exploreBloc: getIt<ExploreBloc>(),
      profileBloc: getIt<ProfileBloc>(),
    ),
  );
}
