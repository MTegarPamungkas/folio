import 'package:folio/app.dart';
import 'package:folio/core/di/injection_container.dart';
import 'package:folio/data/datasources/portfolio_json_data_source.dart';
import 'package:folio/domain/entities/portfolio_content.dart';
import 'package:folio/domain/usecases/get_saved_projects.dart';
import 'package:folio/features/explore/presentation/bloc/explore_bloc.dart';
import 'package:folio/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:folio/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:folio/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestHarness {
  TestHarness._({
    required this.app,
    required this.preferences,
    required this.settingsBloc,
    required this.favoritesBloc,
    required this.exploreBloc,
    required this.savedProjects,
  });

  final FolioApp app;
  final SharedPreferences preferences;
  final SettingsBloc settingsBloc;
  final FavoritesBloc favoritesBloc;
  final ExploreBloc exploreBloc;
  final GetSavedProjects savedProjects;

  static PortfolioContent? _content;

  static Future<PortfolioContent> _loadContent() async {
    return _content ??= await PortfolioJsonDataSource().load();
  }

  static Future<void> preload() async {
    _content ??= await _loadContent();
  }

  static Future<TestHarness> create() async {
    // Widget tests replace one tree with another without disposing the old
    // global Bloc instances first. Disposing them while the previous test tree
    // is still attached can keep close() waiting on its stream listeners.
    // Production blocs live for the app lifetime, so tests simply detach them.
    await GetIt.instance.reset(dispose: false);
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final content = _content ?? await _loadContent();
    await configureDependencies(
      preferences: preferences,
      portfolioContent: content,
    );

    return TestHarness._(
      app: FolioApp(
        settingsBloc: getIt<SettingsBloc>(),
        favoritesBloc: getIt<FavoritesBloc>(),
        exploreBloc: getIt<ExploreBloc>(),
        profileBloc: getIt<ProfileBloc>(),
      ),
      preferences: preferences,
      settingsBloc: getIt<SettingsBloc>(),
      favoritesBloc: getIt<FavoritesBloc>(),
      exploreBloc: getIt<ExploreBloc>(),
      savedProjects: getIt<GetSavedProjects>(),
    );
  }
}
