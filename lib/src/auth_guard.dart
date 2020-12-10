import 'package:flutter/material.dart';
import 'package:flutter_guards/src/_guard.dart';
import 'stream_guard.dart';

_getAuthenticatedFn(bool authenticated, Widget signedIn, Widget signedOut) {
  signedIn = signedIn ?? Container();
  signedOut = signedOut ?? Container();
  return authenticated ? signedIn : signedOut;
}

/// gets 3 builder function to load a widget on 3 states of a stream
/// on loading, on data, or on error.
class AuthGuard extends StreamGuard {
  AuthGuard({
    @required Stream<bool> authStream,
    Widget signedIn,
    Widget signedOut,
    Widget loading,
    Widget error,
  }) : super(
          stream: authStream,
          onData: (authenticated) =>
              _getAuthenticatedFn(authenticated, signedIn, signedOut),
          onLoad: loading != null ? () => loading : dummyLoadFn,
          onError: error != null ? (e) => error : dummyErrorFn,
        );
}
