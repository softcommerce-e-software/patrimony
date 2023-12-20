import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';

class AppScopedBuilder<TStore extends Store<TState>,
TError extends Object, TState extends Object> extends TripleBuilder {
  AppScopedBuilder(
      {super.key, distinct, filter, onState, onError, store})
      : super(
      distinct: distinct,
      filter: filter,
      builder: (context, triple) {
        if (triple.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (triple.error != null) {
          return onError(context, triple.error);
        } else {
          return onState(context, triple.state);
        }
      },
      store: store
  );
}