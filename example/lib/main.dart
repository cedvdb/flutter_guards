import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_guards/flutter_guards.dart';

StreamController<bool> authState = StreamController();

void main() {
  authState.add(false);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final preload = Future.delayed(Duration(seconds: 2));
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // loading guard to preload stuff before running the app (like firebase initialization)
      home: LoadingGuard(
        load: preload,
        loading: LoadingPage(),
        success: Scaffold(
          appBar: AppBar(title: Text('examples')),
          // once everything is loaded we use the auth guard to protect screens
          body: AuthGuard(
            authStream: authState.stream,
            signedIn: Root(),
            signedOut: SignInPage(),
          ),
        ),
      ),
    );
  }
}

class Root extends StatelessWidget {
  static go(BuildContext ctx, Widget to) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (context) => to,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RaisedButton(
          onPressed: () => go(context, FutureGuardExample()),
          child: Text('Future Guard Example'),
        ),
        RaisedButton(
          onPressed: () => go(context, StreamGuardExample()),
          child: Text('Stream Guard Example'),
        ),
        RaisedButton(
          onPressed: () => authState.add(false),
          child: Text('Sign Out'),
        ),
      ],
    );
  }
}

class FutureGuardExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureGuard<bool>(
      future: Future.delayed(Duration(seconds: 2)).then((value) => true),
      onData: (data) => HomePage('Future data received'),
      onLoad: () => LoadingPage(),
      onError: (e) => ErrorPage(),
    );
  }
}

class StreamGuardExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamGuard<bool>(
      stream: Stream.periodic(Duration(seconds: 2)).map((event) => true),
      onData: (data) => HomePage('Stream data received'),
      onLoad: () => LoadingPage(),
      onError: (e) => ErrorPage(),
    );
  }
}

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        onPressed: () {
          authState.add(true);
        },
        child: Text('sign in'),
      ),
    );
  }
}

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Error'),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;

  HomePage(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text(title)),
    );
  }
}

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('loading'),
      ),
    );
  }
}
