import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_guards/flutter_guards.dart';
import '_pages_utils.dart';

void main() {
  group('FutureGuard', () {
    final future = Future.delayed(Duration(milliseconds: 200));
    // final futureError = Future.delayed(Duration(milliseconds: 20));

    final futureGuardApp = MaterialApp(
      home: FutureGuard(
        future: future,
        onData: (data) => homePage,
        onLoad: () => loadingPage,
        onError: (e) => errorPage,
      ),
    );
    // final futureGuardAppError = MaterialApp(
    //   home: FutureGuard(
    //     future: futureError,
    //     onData: (data) => homePage,
    //     onLoad: () => loadingPage,
    //     onError: (e) => errorPage,
    //   ),
    // );

    testWidgets('FutureGuard should render loading state',
        (WidgetTester tester) async {
      await tester.pumpWidget(futureGuardApp);
      // await tester.runAsync(() => future);
      await tester.pump();
      final loadingFinder = find.text(loading);
      expect(loadingFinder, findsOneWidget);
    });

    testWidgets('FutureGuard should render the on data state',
        (WidgetTester tester) async {
      await tester.pumpWidget(futureGuardApp);
      await tester.runAsync(() => future);
      await tester.pump(Duration(milliseconds: 200));
      final homeFinder = find.text(home);
      final loadingFinder = find.text(loading);
      expect(homeFinder, findsOneWidget);
      expect(loadingFinder, findsNothing);
    });

    // testWidgets('FutureGuard should render the on error',
    //     (WidgetTester tester) async {
    //   await tester.pumpWidget(futureGuardAppError);
    //   await tester.runAsync(() => futureError);
    //   await tester.pump(Duration(milliseconds: 200));
    //   final errorFinder = find.text(error);
    //   final loadingFinder = find.text(loading);
    //   expect(errorFinder, findsOneWidget);
    //   expect(loadingFinder, findsNothing);
    // });
  });
}
