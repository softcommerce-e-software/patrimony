import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:patrimony/uikit/components/base/app_store.dart';

abstract class AppState<T extends StatefulWidget, S extends AppStore> extends State<T> {
  final store = Modular.get<S>();

  @override
  void initState() {
    store.addListener(() {
      setState(() {});
    });
    super.initState();
  }
}