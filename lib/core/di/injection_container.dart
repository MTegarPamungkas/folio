import 'package:folio/data/datasources/portfolio_json_data_source.dart';
import 'package:folio/data/datasources/preferences_local_data_source.dart';
import 'package:folio/data/repositories/contact_repository_impl.dart';
import 'package:folio/data/repositories/favorites_repository_impl.dart';
import 'package:folio/data/repositories/portfolio_repository_impl.dart';
import 'package:folio/data/repositories/settings_repository_impl.dart';
import 'package:folio/domain/entities/portfolio_content.dart';
import 'package:folio/domain/repositories/contact_repository.dart';
import 'package:folio/domain/repositories/favorites_repository.dart';
import 'package:folio/domain/repositories/portfolio_repository.dart';
import 'package:folio/domain/repositories/settings_repository.dart';
import 'package:folio/domain/usecases/filter_projects.dart';
import 'package:folio/domain/usecases/get_about_content.dart';
import 'package:folio/domain/usecases/get_contact_context.dart';
import 'package:folio/domain/usecases/get_favorite_ids.dart';
import 'package:folio/domain/usecases/get_home_content.dart';
import 'package:folio/domain/usecases/get_portfolio_content.dart';
import 'package:folio/domain/usecases/get_project_detail.dart';
import 'package:folio/domain/usecases/get_saved_projects.dart';
import 'package:folio/domain/usecases/get_theme_mode.dart';
import 'package:folio/domain/usecases/send_contact_request.dart';
import 'package:folio/domain/usecases/set_theme_mode.dart';
import 'package:folio/domain/usecases/toggle_favorite.dart';
import 'package:folio/features/about/presentation/bloc/about_bloc.dart';
import 'package:folio/features/contact/presentation/bloc/contact_bloc.dart';
import 'package:folio/features/explore/presentation/bloc/explore_bloc.dart';
import 'package:folio/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:folio/features/home/presentation/bloc/home_bloc.dart';
import 'package:folio/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:folio/features/project/presentation/bloc/project_detail_bloc.dart';
import 'package:folio/features/saved/presentation/bloc/saved_bloc.dart';
import 'package:folio/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

Future<SharedPreferences> configureDependencies({
  SharedPreferences? preferences,
  PortfolioContent? portfolioContent,
}) async {
  final prefs = preferences ?? await SharedPreferences.getInstance();
  final content = portfolioContent ?? await PortfolioJsonDataSource().load();

  getIt.registerSingleton<SharedPreferences>(prefs);
  getIt.registerSingleton<PortfolioContent>(content);

  // Data sources
  getIt.registerLazySingleton<PreferencesLocalDataSource>(
    () => PreferencesLocalDataSource(getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<PortfolioRepository>(
    () => PortfolioRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<ContactRepository>(ContactRepositoryImpl.new);

  // Use cases
  getIt
    ..registerLazySingleton(() => GetPortfolioContent(getIt()))
    ..registerLazySingleton(() => GetHomeContent(getIt()))
    ..registerLazySingleton(() => GetAboutContent(getIt()))
    ..registerLazySingleton(() => FilterProjects())
    ..registerLazySingleton(() => GetProjectDetail(getIt()))
    ..registerLazySingleton(() => GetSavedProjects(getIt()))
    ..registerLazySingleton(() => GetFavoriteIds(getIt()))
    ..registerLazySingleton(() => ToggleFavorite(getIt()))
    ..registerLazySingleton(() => GetThemeMode(getIt()))
    ..registerLazySingleton(() => SetThemeMode(getIt()))
    ..registerLazySingleton(() => GetContactContext(getIt()))
    ..registerLazySingleton(() => SendContactRequest(getIt()));

  // App-level state
  getIt
    ..registerLazySingleton<SettingsBloc>(
      () => SettingsBloc(getIt(), getIt()),
      dispose: (bloc) => bloc.close(),
    )
    ..registerLazySingleton<FavoritesBloc>(
      () => FavoritesBloc(getIt(), getIt()),
      dispose: (bloc) => bloc.close(),
    )
    ..registerLazySingleton<ExploreBloc>(
      () => ExploreBloc(getIt(), getIt()),
      dispose: (bloc) => bloc.close(),
    )
    ..registerLazySingleton<ProfileBloc>(
      () => ProfileBloc(getIt()),
      dispose: (bloc) => bloc.close(),
    );

  // Page-level state
  getIt
    ..registerFactory(() => HomeBloc(getIt()))
    ..registerFactory(() => AboutBloc(getIt()))
    ..registerFactory(() => SavedBloc(getIt(), getIt()))
    ..registerFactoryParam<ProjectDetailBloc, String, void>(
      (projectId, _) => ProjectDetailBloc(getIt(), projectId),
    )
    ..registerFactoryParam<ContactBloc, String?, void>(
      (projectId, _) => ContactBloc(getIt(), getIt(), projectId),
    );

  return prefs;
}
