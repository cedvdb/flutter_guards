
Don't use, unmaintained.

# flutter_guards

Simple package containing the following guards:

  - LoadingGuard
  - AuthGuard
  - FutureGuard 
  - StreamGuard


# Usage

FutureGuard and Stream guards takes buiders that will be executed on loading, on success and on data to display a widget. 
While the other guards take direct widgets.

## LoadingGuard

```
final preload = Future.delayed(Duration(seconds: 2));

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoadingGuard(
        load: preload,
        loading: LoadingPage(),
        success: HomePage(),
        error: ErrorPage(),
        ),
      ),
    );
  }
}
```

## AuthGuard


```
StreamController<bool> authState = StreamController();
authState.add(false);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthGuard(
              authStream: authState.stream,
              signedIn: HomePage(),
              signedOut: SignInPage(),
        ),
      ),
    );
  }
}
```

## FutureGuard

```

final future = Future.delayed(Duration(seconds: 2)).map((event) => true);
// ...

@override
Widget build(BuildContext context) {
  return FutureGuard<bool>(
    future: future,
    onData: (data) => HomePage('Future data received'),
    onLoad: () => LoadingPage(),
    onError: (e) => ErrorPage(),
  );
}
```

## StreamGuard

```
final stream = Stream.periodic(Duration(seconds: 2)).map((event) => true);

// ...

  @override
  Widget build(BuildContext context) {
    return StreamGuard<bool>(
      stream: ,
      onData: (data) => HomePage('Stream data received'),
      onLoad: () => LoadingPage(),
      onError: (e) => ErrorPage(),
    );
  }
```


