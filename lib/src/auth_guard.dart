import 'package:flutter/material.dart';
import '_guard.dart';
import 'stream_guard.dart';

class AuthGuard extends StreamGuard {
  AuthGuard({
    Stream<bool> authenticated,
    Widget authenticatedScreen,
    Widget unauthenticatedScreen,
    Widget loadScreen,
    ErrorFn onError,
  }) : super(
          stream: authenticated,
          onData: (_authenticated) =>
              _authenticated ? authenticatedScreen : unauthenticatedScreen,
          onLoad: () => loadScreen,
          onError: onError,
        );
}
