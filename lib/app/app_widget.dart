import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setObservers([Asuka.asukaHeroController]);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Patrimônio',
      theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routerConfig: Modular.routerConfig,
      builder: Asuka.builder,
    );
  }
}