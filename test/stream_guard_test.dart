import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_guards/flutter_guards.dart';
import '_pages_utils.dart';

void main() {
  group('StreamGuard', () {
    final stream =
        Stream.periodic(Duration(milliseconds: 200)).map((event) => true);
    // final futureError = Future.delayed(Duration(milliseconds: 20));
    final streamGuardApp = MaterialApp(
      home: StreamGuard<bool>(
        stream: stream,
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

    testWidgets('StreamGuard should render loading state',
        (WidgetTester tester) async {
      await tester.pumpWidget(streamGuardApp);
      await tester.pump();
      final loadingFinder = find.text(loading);
      expect(loadingFinder, findsOneWidget);
    });

    testWidgets('StreamGuard should render the on data state',
        (WidgetTester tester) async {
      await tester.pumpWidget(streamGuardApp);
      await tester.pump(Duration(milliseconds: 300));
      // await tester.runAsync(() => stream);
      final homeFinder = find.text(home);
      final loadingFinder = find.text(loading);
      expect(homeFinder, findsOneWidget);
      expect(loadingFinder, findsNothing);
    });

    // testWidgets('StreamGuard should render the on error',
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
