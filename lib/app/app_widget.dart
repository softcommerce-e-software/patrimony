import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:patrimony/uikit/themes/app_theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setObservers([Asuka.asukaHeroController]);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Patrimônio',
      theme: AppTheme(context: context).lightMode(),
      routerConfig: Modular.routerConfig,
      builder: Asuka.builder,
    );
  }
}
