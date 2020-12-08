import 'package:flutter/material.dart';
import '_guard.dart';
import 'future_guard.dart';

/// Widget that can be set at the root of the application to change the screen
/// on the future provide
/// onSuccess screen is displayed when the future completes
class AppLoaderGuard<T> extends FutureGuard<T> {
  AppLoaderGuard({
    Future future,
    Widget successScreen,
    Widget loadingScreen,
    Widget errorScreen,
  }) : super(
          future: future,
          onData: successScreen != null ? (_) => successScreen : dummyDataFn,
          onError: errorScreen != null ? (e) => errorScreen : dummyErrorFn,
          onLoad: loadingScreen != null ? () => loadingScreen : dummyLoadFn,
        );
}
