import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:financial_freedom_v0_3_2275937868/app.dart';
import 'package:financial_freedom_v0_3_2275937868/navigation/screen_catalog.dart';
import 'package:financial_freedom_v0_3_2275937868/navigation/screen_routes.dart';

void main() {
  test('every screen route has a registered screen', () {
    expect(screenCatalog.keys, containsAll(ScreenRoute.values));
    expect(screenCatalog.length, 18);
  });

  testWidgets('every native screen route renders without layout errors',
      (WidgetTester tester) async {
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetViewPadding);

    const iPhoneSizes = [
      (375.0, 667.0, 2.0, 20.0, 0.0),
      (414.0, 736.0, 3.0, 20.0, 0.0),
      (375.0, 812.0, 3.0, 44.0, 34.0),
      (390.0, 844.0, 3.0, 47.0, 34.0),
      (393.0, 852.0, 3.0, 59.0, 34.0),
      (402.0, 874.0, 3.0, 62.0, 34.0),
      (430.0, 932.0, 3.0, 62.0, 34.0),
    ];

    for (final (width, height, pixelRatio, topInset, bottomInset)
        in iPhoneSizes) {
      tester.view.devicePixelRatio = pixelRatio;
      tester.view.physicalSize = Size(width * pixelRatio, height * pixelRatio);
      tester.view.viewPadding = FakeViewPadding(
        top: topInset,
        bottom: bottomInset,
      );

      for (final route in ScreenRoute.values) {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(platform: TargetPlatform.iOS),
            home: Builder(
              builder: (context) => screenCatalog[route]!(context),
            ),
          ),
        );
        await tester.pumpAndSettle();
        final layoutException = tester.takeException();
        expect(
          layoutException,
          isNull,
          reason: '${route.path} at ${width}x$height: $layoutException',
        );
        expect(
          find.byType(Image),
          findsNothing,
          reason: '${route.path} at ${width}x$height',
        );
      }
    }
  });

  testWidgets('native screens navigate without rendering reference images',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const FinancialFreedomApp());

    expect(find.text('Financial Freedom'), findsOneWidget);
    expect(find.byType(Image), findsNothing);
    await tester.tap(find.bySemanticsLabel('Continue to Freedom setup'));
    await tester.pumpAndSettle();
    expect(find.text('Summary'), findsOneWidget);
    expect(find.byType(Image), findsNothing);

    final addNumbersButton =
        find.bySemanticsLabel('Add monthly income and lifestyle cost');
    await tester.ensureVisible(addNumbersButton);
    await tester.tap(addNumbersButton);
    await tester.pumpAndSettle();
    expect(find.text('Add My Numbers'), findsNWidgets(2));

    await tester.tap(find.bySemanticsLabel('Compute Freedom score'));
    await tester.pumpAndSettle();
    expect(find.text('Financial Freedom Achieved'), findsOneWidget);

    final cashFlowTab = find.bySemanticsLabel('Open Cash Flow screen');
    await tester.ensureVisible(cashFlowTab);
    await tester.tap(cashFlowTab);
    await tester.pumpAndSettle();
    expect(find.text("This month's run rate"), findsOneWidget);

    final housingCategory =
        find.bySemanticsLabel('View Housing expense details');
    await tester.ensureVisible(housingCategory);
    await tester.tap(housingCategory);
    await tester.pumpAndSettle();
    expect(find.text('Housing'), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('Back to Cash Flow'));
    await tester.pumpAndSettle();
    expect(find.text('Expense Categories'), findsOneWidget);

    final assetsTab = find.bySemanticsLabel('Open Assets screen');
    await tester.ensureVisible(assetsTab);
    await tester.tap(assetsTab);
    await tester.pumpAndSettle();
    expect(find.text('Income Producing Assets'), findsOneWidget);

    await tester
        .tap(find.bySemanticsLabel('View monthly asset income allocation'));
    await tester.pumpAndSettle();
    expect(find.text('Active Allocations'), findsOneWidget);
    await tester.tap(find.bySemanticsLabel('Back to Assets'));
    await tester.pumpAndSettle();

    final coachTab = find.bySemanticsLabel('Open Coach screen');
    await tester.ensureVisible(coachTab);
    await tester.tap(coachTab);
    await tester.pumpAndSettle();
    expect(find.text('Freedom Coach'), findsOneWidget);
    await tester.tap(find.bySemanticsLabel('Ask how to retire sooner'));
    await tester.pumpAndSettle();
    expect(find.text('Your Path to 100%'), findsOneWidget);

    final freedomTab = find.bySemanticsLabel('Open Freedom screen');
    await tester.ensureVisible(freedomTab);
    await tester.tap(freedomTab);
    await tester.pumpAndSettle();
    expect(
        find.text('Summary of your path to financial freedom'), findsOneWidget);
    await tester.tap(find.bySemanticsLabel('View profile settings'));
    await tester.pumpAndSettle();
    expect(find.text('Profile Settings'), findsOneWidget);
    await tester.tap(find.bySemanticsLabel('Back to Profile'));
    await tester.pumpAndSettle();
    expect(find.text('Alerzano Sen'), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('Sign in with Apple'));
    await tester.pumpAndSettle();
    expect(find.text('Sign in with Apple ID'), findsOneWidget);
    await tester.tap(find.bySemanticsLabel('Continue with Apple ID'));
    await tester.pumpAndSettle();
    expect(find.text('ACTIVE ACCOUNT PERKS'), findsOneWidget);
    await tester.tap(find.bySemanticsLabel('Sign out of all devices'));
    await tester.pumpAndSettle();
    expect(find.text('Sign In with Apple'), findsOneWidget);
    expect(find.byType(Image), findsNothing);
  });
}
