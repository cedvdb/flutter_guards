import 'package:flutter/material.dart';
import '_guard.dart';

/// gets 3 builder function to load a widget on 3 states of the stream
/// on loading, on data, or on error. (on complete is omitted)
class StreamGuard<T> extends Guard<T> {
  final Stream<T?> stream;

  StreamGuard({
    required this.stream,
    required DataFn<T?> onData,
    LoadFn? onLoad,
    ErrorFn? onError,
  }) : super(onData, onLoad, onError);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T?>(
      stream: stream,
      builder: builder,
    );
  }
}
