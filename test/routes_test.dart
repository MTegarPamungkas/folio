import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:folio/core/router/app_router.dart';
import 'test_dependencies.dart';

Future<void> _visit(WidgetTester tester, String route) async {
  appRouter.go(route);
  await tester.pumpAndSettle();
  expect(tester.takeException(), isNull, reason: 'Route $route');
}

void main() {
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
}
