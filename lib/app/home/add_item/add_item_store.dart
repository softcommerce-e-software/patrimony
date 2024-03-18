import 'dart:io';

import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:patrimony/domain/company/post_item_usecase.dart';
import 'package:patrimony/domain/utils/app_state.dart';

class AddItemStoreStore extends AppState<bool> {
  final PostItemUseCase _useCase;

  AddItemStoreStore(this._useCase) : super(true);

  Future<void> addItem(
    String companyId,
    String categoryId,
    String barcode,
    double value,
    String observations,
    List<File> attachments
  ) async {
    setLoading(true);
    var response = await _useCase.call(
      companyId,
      categoryId,
      barcode,
      value,
      observations,
      attachments
    );
    response.fold(
      (l) => AsukaSnackbar.alert(l.message ?? '').show(),
      (r) => Modular.to.pop(r)
    );
    setLoading(false);
  }
}
