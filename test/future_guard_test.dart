import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_guards/flutter_guards.dart';
import '_pages_utils.dart';

void main() {
  group('FutureGuard', () {
    final futureGuardApp = (Future future) => MaterialApp(
          home: FutureGuard(
            future: future,
            onData: (data) => homePage,
            onLoad: () => loadingPage,
            onError: (e) => errorPage,
          ),
        );

    testWidgets('FutureGuard should render loading state',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        Future<void> future = Future.delayed(Duration(milliseconds: 200));
        await tester.pumpWidget(futureGuardApp(future));
        await tester.pump();
        final loadingFinder = find.text(loading);
        expect(loadingFinder, findsOneWidget);
      });
    });

    testWidgets('FutureGuard should render the on data state',
        (WidgetTester tester) async {
      final future = Future.delayed(Duration(milliseconds: 20));
      await tester.runAsync(() async {
        await tester.pumpWidget(futureGuardApp(future));
        await tester.pumpAndSettle(Duration(milliseconds: 200));
        final homeFinder = find.text(home);
        expect(homeFinder, findsOneWidget);
        final loadingFinder = find.text(loading);
        expect(loadingFinder, findsNothing);
      });
    });

    testWidgets('FutureGuard should render the on error',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        final futureError = Future.error('error');
        await tester.pumpWidget(futureGuardApp(futureError));
        await tester.pump(Duration(milliseconds: 200));
        final errorFinder = find.text(error);
        expect(errorFinder, findsOneWidget);
        final loadingFinder = find.text(loading);
        expect(loadingFinder, findsNothing);
      });
    });
  });
}
