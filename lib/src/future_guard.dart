import 'package:flutter/material.dart';
import '_guard.dart';

/// gets 3 builder function to load a widget on the 3 states of the future
/// on loading, on data, or on error.
class FutureGuard<T> extends Guard<T> {
  final Future<T?> future;

  const FutureGuard({
    required this.future,
    required DataFn<T?> onData,
    LoadFn? onLoad,
    ErrorFn? onError,
  }) : super(onData, onLoad, onError);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T?>(future: future, builder: builder);
  }
}
