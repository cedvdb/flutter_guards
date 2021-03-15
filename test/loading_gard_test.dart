import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_guards/flutter_guards.dart';
import '_pages_utils.dart';

void main() {
  group('AppLoaderGuard', () {
    final future = Future.delayed(Duration(milliseconds: 200));
    // final futureError = Future.delayed(Duration(milliseconds: 20));
    final loadingGuardApp = (future) => MaterialApp(
          home: LoadingGuard(
            load: future,
            success: homePage,
            loading: loadingPage,
            error: errorPage,
          ),
        );

    testWidgets('LoaderGuard should render loading state',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        final future = Future.delayed(Duration(milliseconds: 200));
        await tester.pumpWidget(loadingGuardApp(future));
        await tester.pump();
        final loadingFinder = find.text(loading);
        expect(loadingFinder, findsOneWidget);
      });
    });

    testWidgets('LoaderGuard should render the on data state',
        (WidgetTester tester) async {
      final future = Future.delayed(Duration(milliseconds: 20));
      await tester.runAsync(() async {
        await tester.pumpWidget(loadingGuardApp(future));
        await tester.pumpAndSettle(Duration(milliseconds: 200));
        final homeFinder = find.text(home);
        expect(homeFinder, findsOneWidget);
        final loadingFinder = find.text(loading);
        expect(loadingFinder, findsNothing);
      });
    });

    testWidgets('LoaderGuard should render the on error',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        final futureError = Future.error('error');
        await tester.pumpWidget(loadingGuardApp(futureError));
        await tester.pump(Duration(milliseconds: 200));
        final errorFinder = find.text(error);
        expect(errorFinder, findsOneWidget);
        final loadingFinder = find.text(loading);
        expect(loadingFinder, findsNothing);
      });
    });
  });
}
