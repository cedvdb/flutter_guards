import 'package:flutter/material.dart';

typedef Widget DataFn<T>(T result);
typedef Widget LoadFn();
typedef Widget ErrorFn(Object error);

Widget dummyDataFn(data) => Container(child: Text(data.toString()));
Widget dummyLoadFn() => Container(child: Text('Loading...'));
Widget dummyErrorFn(error) => Container(child: Text(error.toString()));

abstract class Guard<T> extends StatelessWidget {
  final LoadFn onLoad;
  final DataFn<T> onData;
  final ErrorFn onError;

  const Guard([
    onData,
    onLoad,
    onError,
  ])  : onData = onData ?? dummyDataFn,
        onLoad = onLoad ?? dummyLoadFn,
        onError = onError ?? dummyErrorFn;

  Widget builder(BuildContext context, AsyncSnapshot<T> snapshot) {
    if (snapshot.hasError) {
      return onError(snapshot.error);
    }
    if (snapshot.hasData || snapshot.connectionState == ConnectionState.done) {
      return onData(snapshot.data);
    }
    return onLoad();
  }
}
