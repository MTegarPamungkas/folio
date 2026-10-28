import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:folio/core/router/app_router.dart';
import 'package:folio/domain/entities/app_language.dart';
import 'package:folio/features/settings/presentation/bloc/settings_event.dart';
import 'test_dependencies.dart';

Future<void> _visit(WidgetTester tester, String route) async {
  appRouter.go(route);
  await tester.pumpAndSettle();
  expect(tester.takeException(), isNull, reason: 'Route $route');
}

void main() {
  // Fake-async widget tests can't await `rootBundle`, so load the JSON first.
  setUpAll(TestHarness.preload);

  testWidgets('all routes lay out on a phone with large text', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = 1.3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    addTearDown(() => appRouter.go('/'));

    final harness = await TestHarness.create();
    await tester.pumpWidget(harness.app);
    await tester.pumpAndSettle();

    for (final route in ['/', '/explore', '/saved', '/about']) {
      await _visit(tester, route);
    }
    await _visit(tester, '/project/mis-msa');
    await _visit(tester, '/contact');
  });

  testWidgets('all routes lay out on desktop', (tester) async {
    tester.view.physicalSize = const Size(1440, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(() => appRouter.go('/'));

    final harness = await TestHarness.create();
    await tester.pumpWidget(harness.app);
    await tester.pumpAndSettle();

    for (final route in ['/', '/explore', '/saved', '/about']) {
      await _visit(tester, route);
    }
    await _visit(tester, '/project/mis-msa');
    await _visit(tester, '/contact');
  });

  testWidgets('english copy lays out on desktop', (tester) async {
    tester.view.physicalSize = const Size(1440, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(() => appRouter.go('/'));

    final harness = await TestHarness.create();
    harness.settingsBloc.add(const SettingsLanguageChanged(AppLanguage.en));
    await tester.pumpWidget(harness.app);
    await tester.pumpAndSettle();
    expect(harness.settingsBloc.state.language, AppLanguage.en);
    expect(find.text('Home'), findsWidgets);

    for (final route in ['/', '/explore', '/saved', '/about']) {
      await _visit(tester, route);
    }
    await _visit(tester, '/project/mis-msa');
    await _visit(tester, '/contact');
  });

  testWidgets('english copy lays out on a small phone', (tester) async {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(() => appRouter.go('/'));

    final harness = await TestHarness.create();
    harness.settingsBloc.add(const SettingsLanguageChanged(AppLanguage.en));
    await tester.pumpWidget(harness.app);
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsWidgets);

    for (final route in ['/', '/explore', '/saved', '/about']) {
      await _visit(tester, route);
    }
    await _visit(tester, '/project/mis-msa');
    await _visit(tester, '/contact');
  });
}
