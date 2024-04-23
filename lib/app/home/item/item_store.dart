import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:patrimony/domain/item/add_attachment_item_usecase.dart';
import 'package:patrimony/domain/item/add_photo_item_usecase.dart';
import 'package:patrimony/domain/item/delete_attachment_item_usecase.dart';
import 'package:patrimony/domain/item/delete_item_usecase.dart';
import 'package:patrimony/domain/item/delete_photo_item_usecase.dart';
import 'package:patrimony/domain/item/update_item_usecase.dart';
import 'package:patrimony/domain/utils/app_store_state.dart';
import 'package:patrimony/entity/item_entity.dart';

class ItemStore extends AppStoreState<ItemEntity> {
  final DeleteItemUseCase _deleteItemUseCase;
  final UpdateItemUseCase _updateItemUseCase;
  final AddPhotoItemUseCase _addPhotoItemUseCase;
  final DeletePhotoItemUseCase _deletePhotoItemUseCase;
  final AddAttachmentItemUseCase _addAttachmentItemUseCase;
  final DeleteAttachmentItemUseCase _deleteAttachmentItemUseCase;

  ItemStore(
    this._deleteItemUseCase,
    this._updateItemUseCase,
    this._addPhotoItemUseCase,
    this._deletePhotoItemUseCase,
    this._addAttachmentItemUseCase,
    this._deleteAttachmentItemUseCase
  ) : super(ItemEntity());

  Future<void> getItem(ItemEntity entity) async {
    value = entity;
  }

  Future<void> refresh() async {
    getItem(value);
  }

  Future<void> delete(String? id) async {
    if(id != null && id.isNotEmpty) {
      setLoading(true);
      var response = await _deleteItemUseCase.call(id);
      response.fold(
              (l) => {},
              (r) => Modular.to.pop(r)
      );
      setLoading(false);
    }
  }

  Future<void> updateItem(
      String name,
      String barcode,
      double value,
      String observations,
      String status,
      String workingStatus
  ) async {
    setLoading(true);
    var response = await _updateItemUseCase.call(
        this.value.id ?? '',
        name,
        barcode,
        value,
        observations,
        status,
        workingStatus,
    );
    response.fold(
            (l) => null,
            (r) => this.value =
                this.value.copyWith(
                    name: name,
                    code: barcode,
                    value: value,
                    observations: observations,
                    status: status,
                    workingStatus: workingStatus,
                )
    );
    setLoading(false);
    return;
  }

  Future<String> goToBarcode() async {
    return _auxCamera('/bottom_view/home/barcode');
  }

  Future<void> goToCamera() async {
    var photo = await _auxCamera('/bottom_view/home/camera');
    if (photo.isNotEmpty) {
      await addPhoto(File(photo));
    }
    return;
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

  Future<void> addAttachment(File image) async {
    var response = await _addAttachmentItemUseCase.call(
        value.companyId ?? '',
        value.categoryId ?? '',
        value.id ?? '',
        image
    );
    response.fold(
            (l) => null,
            (r) {
          if (r.isNotEmpty) {
            var attachments = value.attachments ?? [];
            attachments.add(r);
            value.copyWith(
                attachments: attachments
            );
          }
        }
    );
    return;
  }

  Future<void> deleteAttachment(String url) async {
    var response = await _deleteAttachmentItemUseCase.call(
        value.id ?? '',
        url
    );
    response.fold(
            (l) => null,
            (r) {
          if (r) {
            value =
                value.copyWith(
                    attachments: value.attachments?.where((element) => element != url).toList()
                );
          }
        }
    );
    return;
  }

  Future<void> addPhoto(File image) async {
    var response = await _addPhotoItemUseCase.call(
        value.companyId ?? '',
        value.categoryId ?? '',
        value.id ?? '',
        image
    );
    response.fold(
      (l) => null,
      (r) {
        if (r.isNotEmpty) {
          value = value.copyWith(image: r);
        }
      }
    );
    return;
  }

  Future<void> deletePhoto(String url) async {
    var response = await _deletePhotoItemUseCase.call(
        value.id ?? '',
        url
    );
    response.fold(
            (l) => null,
            (r) {
          if (r) {
            value = value.copyWith(image: null);
          }
        }
    );
    return;
  }
}
