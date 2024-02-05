import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:patrimony/app/login/login_store.dart';
import 'package:patrimony/domain/utils/errors.dart';
import 'package:patrimony/uikit/components/base/app_scoped_builder.dart';
import 'package:patrimony/uikit/components/buttons/custom_image_button.dart';
import 'package:patrimony/uikit/ui_ext.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

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
            'PATRIMÔNIO'.toUpperCase(),
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
          ),
          Text(
            'BEM-VINDO',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Colors.black,
                ),
          ),
          SizedBox(
            height: 10.heightPercent,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.widthPercent),
            child: CustomImageButton(
              onPressed: () => _store.login(),
              background: Theme.of(context).primaryColorDark,
              textColor: Theme.of(context).primaryColorLight,
              iconPath: 'assets/icon/ic_white_apple.webp',
              buttonText: 'Sign in with Apple',
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.widthPercent),
            child: CustomImageButton(
              onPressed: () => _store.login(isGoogle: true),
              background: Theme.of(context).colorScheme.primary,
              textColor: Theme.of(context).primaryColorDark,
              iconPath: 'assets/icon/ic_google.webp',
              buttonText: 'Sign in with Google',
            ),
          ),
        ],
      ),
    );
  }
}
