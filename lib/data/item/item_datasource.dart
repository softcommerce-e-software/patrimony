import 'dart:io';

import 'package:patrimony/entity/item_entity.dart';

abstract class ItemDataSource {
  Future<List<ItemEntity>> getItems(String companyId, String categoryId, int page);
  Future<ItemEntity> searchItem(String code, String companyId);
  Future<bool> postItem(
      String companyId,
      String categoryId,
      String name,
      String barcode,
      double value,
      String observations,
      List<File> attachments,
      String imagePath
  );
  Future<bool> deleteItem(String id);
  Future<bool> updateItem(
      String itemId,
      String name,
      String barcode,
      double value,
      String observations,
      String status,
  );
  Future<String> addAttachment(
      String companyId,
      String categoryId,
      String itemId,
      File photo
  );
  Future<String> addPhoto(
      String companyId,
      String categoryId,
      String itemId,
      File photo
  );
  Future<bool> deleteAttachment(
      String id,
      String url
  );
  Future<bool> deletePhoto(
      String id,
      String url
  );
}