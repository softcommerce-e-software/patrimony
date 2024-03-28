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
    String name,
    String barcode,
    double value,
    String observations,
    List<File> attachments,
    String imagePath
  ) async {
    setLoading(true);
    var response = await _useCase.call(
      companyId,
      categoryId,
      name,
      barcode,
      value,
      observations,
      attachments,
      imagePath
    );
    response.fold(
      (l) => {},
      (r) => Modular.to.pop(r)
    );
    setLoading(false);
  }

  Future<String> goToBarcode() async {
    return _auxCamera('/bottom_view/home/barcode');
  }

  Future<String> goToCamera() async {
    return _auxCamera('/bottom_view/home/camera');
  }

  Future<String> _auxCamera(String path) async {
    var response = await Modular.to.pushNamed(
        path,
        forRoot: true
    );
    if (response is String) {
      return response;
    }
    return "";
  }
}
