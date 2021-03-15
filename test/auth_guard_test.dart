import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_guards/flutter_guards.dart';
import '_pages_utils.dart';

void main() {
  group('AuthGuard', () {
    final authGuardApp = (Stream<bool> authenticated) => MaterialApp(
          home: AuthGuard(
            authStream: authenticated,
            signedIn: homePage,
            signedOut: signInPage,
            loading: loadingPage,
            error: errorPage,
          ),
        );

    testWidgets('AuthGuard should render loading state',
        (WidgetTester tester) async {
      final stream = Stream.periodic(Duration(milliseconds: 200))
          .take(1)
          .map((event) => true);

      await tester.runAsync(() async {
        await tester.pumpWidget(authGuardApp(stream));
        await tester.pump();
        final loadingFinder = find.text(loading);
        expect(loadingFinder, findsOneWidget);
      });
    });

    testWidgets('AuthGuard should render the login screen',
        (WidgetTester tester) async {
      final stream = Stream.value(false);

      await tester.runAsync(() async {
        await tester.pumpWidget(authGuardApp(stream));
        await tester.pump(Duration(milliseconds: 400));
        final signInFinder = find.text(signIn);
        expect(signInFinder, findsOneWidget);
        final loadingFinder = find.text(loading);
        expect(loadingFinder, findsNothing);
      });
    });

    testWidgets('StreamGuard should render the home screen',
        (WidgetTester tester) async {
      final stream = Stream.value(true);

      await tester.runAsync(() async {
        await tester.pumpWidget(authGuardApp(stream));
        await tester.pump(Duration(milliseconds: 200));
        final homeFinder = find.text(home);
        expect(homeFinder, findsOneWidget);
        final loadingFinder = find.text(loading);
        expect(loadingFinder, findsNothing);
      });
    });

    testWidgets('StreamGuard should render the error screen',
        (WidgetTester tester) async {
      final Stream<bool> stream = Stream.error('error');

      await tester.runAsync(() async {
        await tester.pumpWidget(authGuardApp(stream));
        await tester.pump(Duration(milliseconds: 200));
        final errorFinder = find.text(error);
        expect(errorFinder, findsOneWidget);
        final loadingFinder = find.text(loading);
        expect(loadingFinder, findsNothing);
      });
    });
  });
}
