import 'package:flutter/material.dart';

typedef Widget DataFn<T>(T result);
typedef Widget LoadFn();
typedef Widget ErrorFn(Object error);

Widget dummyDataFn(data) => Container(child: Text(data.toString()));
Widget dummyLoadFn() => Container();
Widget dummyErrorFn(error) => Container(child: Text(error.toString()));

abstract class Guard<T> extends StatelessWidget {
  final LoadFn loading;
  final DataFn<T> success;
  final ErrorFn error;

  const Guard([
    success,
    loading,
    error,
  ])  : success = success ?? dummyDataFn,
        loading = loading ?? dummyLoadFn,
        error = error ?? dummyErrorFn;

  Widget builder(BuildContext context, AsyncSnapshot<T> snapshot) {
    if (snapshot.hasError) {
      return error(snapshot.error);
    }
    if (snapshot.hasData || snapshot.connectionState == ConnectionState.done) {
      return success(snapshot.data);
    }
    return loading();
  }
}
