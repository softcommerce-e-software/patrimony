import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:patrimony/app/login/login_store.dart';
import 'package:patrimony/domain/utils/errors.dart';
import 'package:patrimony/uikit/components/base/app_scoped_builder.dart';
import 'package:patrimony/uikit/components/buttons/apple_button.dart';
import 'package:patrimony/uikit/ui_ext.dart';

import '../../../uikit/components/buttons/google_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _store = Modular.get<LoginStore>();

  @override
  void initState() {
    super.initState();
    _verifyLoggedUser();
  }

  void _verifyLoggedUser() {
    _store.isLogged();
    _store.observer(
      onState: (state) {
        if (state) {
          Modular.to.pushReplacementNamed('/bottom_view/home/');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppScopedBuilder<LoginStore, Failure, bool>(
        store: _store,
        onState: (_, result) {
          return _screen();
        },
        onError: (_, e) => _screen(),
      ),
    );
  }

  Widget _screen() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'PATRIMÔNIO',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            'BEM-VINDO',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 10.heightPercent,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.widthPercent),
            child: appleButton(onPress: () => _store.login()),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.widthPercent),
            child: googleButton(onPress: () => _store.login(isGoogle: true)),
          ),
        ],
      ),
    );
  }
}