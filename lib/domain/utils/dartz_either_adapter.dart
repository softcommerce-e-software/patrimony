import 'package:asuka/asuka.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:patrimony/domain/user/user_repository.dart';
import 'package:patrimony/domain/utils/errors.dart';

class DartzEitherAdapter<R> extends EitherAdapter<Failure, R> {
  final Either<Failure, R> usecase;

  DartzEitherAdapter(this.usecase);

  @override
  T fold<T>(T Function(Failure l) leftF, T Function(R l) rightF) {
    return usecase.fold(leftF, rightF);
  }

  static Future<EitherAdapter<Failure, R>> adapter<R>(
      Future<Either<Failure, R>> usecase,
      {bool showError = true}) {
    return usecase.then((value) {
      value.fold((l) async {
        if (l is InvalidUser) {
          await Modular.get<UserRepository>().logout();
          Modular.to.pushReplacementNamed('/');
        }
        // if (showError) AsukaSnackbar.alert(l.message ?? '').show();
      }, (r) => null);
      return DartzEitherAdapter(value);
    });
  }
}