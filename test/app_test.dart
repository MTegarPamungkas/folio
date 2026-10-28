import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:folio/core/router/app_router.dart';
import 'package:folio/domain/entities/app_language.dart';
import 'package:folio/domain/entities/app_theme_mode.dart';
import 'package:folio/features/favorites/presentation/bloc/favorites_event.dart';
import 'package:folio/features/settings/presentation/bloc/settings_event.dart';
import 'test_dependencies.dart';

void main() {
  // Widget tests run inside a fake-async zone where `rootBundle` loads never
  // complete, so the JSON is read once in `setUpAll` (a real async zone).
  setUpAll(TestHarness.preload);

  testWidgets('home and search flow render on a phone viewport', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(() => appRouter.go('/'));

    final harness = await TestHarness.create();
    await tester.pumpWidget(harness.app);
    appRouter.go('/');
    await tester.pumpAndSettle();

    expect(find.textContaining('sedang saya bangun'), findsOneWidget);
    expect(find.text('Beranda'), findsOneWidget);
    expect(find.text('Jelajah'), findsOneWidget);

    await tester.tap(find.text('Jelajah'));
    await tester.pumpAndSettle();
    expect(find.byType(TextField), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'TomboAti');
    await tester.pumpAndSettle();
    expect(find.text('1 hasil ditemukan'), findsOneWidget);
    expect(find.text('TomboAti'), findsWidgets);

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('contact form keeps typed values and project context', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(() => appRouter.go('/'));

    final harness = await TestHarness.create();
    await tester.pumpWidget(harness.app);
    appRouter.go('/contact?project=mis-msa');
    await tester.pumpAndSettle();

    expect(
      find.textContaining('saya tertarik dengan proyek MIS MSA'),
      findsOneWidget,
    );

    await tester.enterText(find.byType(TextFormField).first, 'Tegar');
    await tester.pumpAndSettle();
    expect(find.text('Tegar'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
  });

  test('favorites and theme mode persist through blocs', () async {
    final harness = await TestHarness.create();

    harness.favoritesBloc.add(const FavoriteToggled('mis-msa'));
    await harness.favoritesBloc.stream.firstWhere(
      (state) => state.isSaved('mis-msa'),
    );
    expect(
      harness.savedProjects(harness.favoritesBloc.state.ids).single.name,
      'MIS MSA',
    );
    expect(harness.preferences.getStringList('folio.savedProjects'), [
      'mis-msa',
    ]);

    harness.settingsBloc.add(const SettingsThemeModeChanged(AppThemeMode.dark));
    await harness.settingsBloc.stream.firstWhere(
      (state) => state.themeMode == AppThemeMode.dark,
    );
    await Future<void>.delayed(const Duration(milliseconds: 10));
    expect(harness.settingsBloc.state.themeMode, AppThemeMode.dark);
    expect(harness.preferences.getString('folio.themeMode'), 'dark');

    harness.favoritesBloc.add(const FavoriteToggled('mis-msa'));
    await harness.favoritesBloc.stream.firstWhere(
      (state) => !state.isSaved('mis-msa'),
    );
    expect(harness.savedProjects(harness.favoritesBloc.state.ids), isEmpty);
  });

  test('language defaults to Indonesian and persists the choice', () async {
    final harness = await TestHarness.create();
    expect(harness.settingsBloc.state.language, AppLanguage.id);

    harness.settingsBloc.add(const SettingsLanguageChanged(AppLanguage.en));
    await harness.settingsBloc.stream.firstWhere(
      (state) => state.language == AppLanguage.en,
    );
    await Future<void>.delayed(const Duration(milliseconds: 10));
    expect(harness.preferences.getString('folio.language'), 'en');
  });

  testWidgets('switches the interface copy to English', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(() => appRouter.go('/'));

    final harness = await TestHarness.create();
    await tester.pumpWidget(harness.app);
    appRouter.go('/');
    await tester.pumpAndSettle();

    expect(find.text('Beranda'), findsOneWidget);
    expect(find.text('Jelajah'), findsOneWidget);

    await tester.tap(find.text('ID').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('English').last);
    await tester.pumpAndSettle();

    expect(harness.settingsBloc.state.language, AppLanguage.en);
    expect(find.text('Beranda'), findsNothing);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Explore'), findsOneWidget);
    expect(find.text('Saved'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);
    expect(harness.preferences.getString('folio.language'), 'en');

    await tester.pumpWidget(const SizedBox.shrink());
  });
}
