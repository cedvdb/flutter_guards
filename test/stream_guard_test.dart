import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_guards/flutter_guards.dart';
import '_pages_utils.dart';

void main() {
  group('StreamGuard', () {
    final streamGuardApp = (stream) => MaterialApp(
          home: StreamGuard(
            stream: stream,
            onData: (data) => homePage,
            onLoad: () => loadingPage,
            onError: (e) => errorPage,
          ),
        );

    testWidgets('StreamGuard should render loading state',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        final stream =
            Stream.fromFuture(Future.delayed(Duration(milliseconds: 20000)));
        await tester.pumpWidget(streamGuardApp(stream));
        await tester.pump();
        final loadingFinder = find.text(loading);
        expect(loadingFinder, findsOneWidget);
      });
    });

    testWidgets('StreamGuard should render the on data state',
        (WidgetTester tester) async {
      final stream =
          Stream.fromFuture(Future.delayed(Duration(milliseconds: 20)));
      await tester.runAsync(() async {
        await tester.pumpWidget(streamGuardApp(stream));
        await tester.pump(Duration(milliseconds: 400));
        final homeFinder = find.text(home);
        expect(homeFinder, findsOneWidget);
        final loadingFinder = find.text(loading);
        expect(loadingFinder, findsNothing);
      });
    });

    testWidgets('StreamGuard should render the on error',
        (WidgetTester tester) async {
      final stream = Stream.error('error');
      await tester.runAsync(() async {
        await tester.pumpWidget(streamGuardApp(stream));
        await tester.pump(Duration(milliseconds: 200));
        final errorFinder = find.text(error);
        expect(errorFinder, findsOneWidget);
        final loadingFinder = find.text(loading);
        expect(loadingFinder, findsNothing);
      });
    });
  });
}
