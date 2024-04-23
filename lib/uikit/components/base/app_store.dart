import 'package:flutter/foundation.dart';

abstract class AppStore<T> extends ChangeNotifier implements ValueListenable<T> {

  var isLoading = false;
  var isError = false;

  AppStore(this._value) {
    if (kFlutterMemoryAllocationsEnabled) {
      ChangeNotifier.maybeDispatchObjectCreation(this);
    }
    initStore();
  }

  void initStore() {}

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void setError(bool value) {
    isError = value;
    notifyListeners();
  }

  @override
  T get value => _value;
  T _value;
  set value(T newValue) {
    if (_value == newValue) {
      return;
    }
    _value = newValue;
    setError(false);
    setLoading(false);
  }

  @override
  String toString() => '${describeIdentity(this)}($value)';
}