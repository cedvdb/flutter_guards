import 'package:flutter/material.dart';
import '_guard.dart';
import 'future_guard.dart';

/// Use this if you don't care about the state of the Future, else use FutureGuard
/// Widget that can be set at the root of the application to change the screen
/// on the future provide
/// success widget is displayed when the future completes
class LoadingGuard<T> extends FutureGuard<T> {
  LoadingGuard({
    Future load,
    Widget success,
    Widget loading,
    Widget error,
  }) : super(
          future: load ?? Future.value(),
          onData: success != null ? (_) => success : dummyDataFn,
          onError: error != null ? (e) => error : dummyErrorFn,
          onLoad: loading != null ? () => loading : dummyLoadFn,
        );
}
