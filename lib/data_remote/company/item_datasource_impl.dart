import 'dart:convert';
import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:patrimony/data/item/item_datasource.dart';
import 'package:patrimony/domain/utils/errors.dart';
import 'package:patrimony/entity/item_entity.dart';

class ItemDataSourceImpl implements ItemDataSource {
  ItemDataSourceImpl(this._functions, this._storage);

  final FirebaseFunctions _functions;
  final FirebaseStorage _storage;

  @override
  Future<List<ItemEntity>> getItems(String companyId, String categoryId, int page) async {
    try {
      var response = await _functions
          .httpsCallable('getitemspaginate')
          .call({
            'companyId': companyId,
            'categoryId': categoryId,
            'page': page
          });
      return listItemEntityFromJson(response.data);
    } catch (e) {
      throw RemoteFailure();
    }
  }

  @override
  Future<ItemEntity> searchItem(String code, String companyId) async {
    throw RemoteFailure();
    // try {
    //   var response = await _db
    //       .from(_ITEMS_VIEW)
    //       .select()
    //       .eq('code', code);
    //   return response.map((e) => ItemEntity.fromJson(e)).firstOrNull;
    // } catch (_) {
    //   throw RemoteFailure();
    // }
  }

  @override
  Future<bool> postItem(
      String companyId,
      String categoryId,
      String name,
      String barcode,
      double value,
      String observations,
      List<File> attachments,
      String imagePath
  ) async {
    try {
      var futureAttachmentsUrls = attachments.map((e) async {
        var ref = _storage.ref().child('invoices/$companyId/$categoryId/'
            '${DateTime.now().millisecondsSinceEpoch}.jpg');
        await ref.putFile(e);
        var url = await ref.getDownloadURL();
        return url;
      });
      var attachmentsUrls = await Future.wait(futureAttachmentsUrls);

      var imageUrl = "";
     if (imagePath.isNotEmpty) {
       var ref = _storage.ref().child('item/$companyId/$categoryId/'
           '${DateTime.now().millisecondsSinceEpoch}.jpg');
       await ref.putFile(File(imagePath));
       imageUrl = await ref.getDownloadURL();
     }

      var response = await _functions.httpsCallable(
        'postitem',
        options: HttpsCallableOptions(limitedUseAppCheckToken: false,),
      ).call({
        'companyId': companyId,
        'categoryId': categoryId,
        'name': name,
        'barcode': barcode,
        'value': value,
        'observations': observations,
        'attachments': attachmentsUrls,
        'image': imageUrl
      });
      return jsonDecode(response.data)['success'];
    } catch (e) {
      throw RemoteFailure();
    }
  }

  @override
  Future<bool> deleteItem(String id) async {
    try {
      var response = await _functions
          .httpsCallable(
        'deleteitem',
        options: HttpsCallableOptions(
          limitedUseAppCheckToken: false,
        ),
      ).call({'id': id});
      return jsonDecode(response.data)['success'];
    } catch (e) {
      throw RemoteFailure();
    }
  }

  @override
  Future<bool> updateItem(
      String itemId,
      String name,
      String barcode,
      double value,
      String observations,
      String status,
  ) async {
    try {
      var response = await _functions.httpsCallable(
        'updateitem',
      ).call({
        'id': itemId,
        'name': name,
        'barcode': barcode,
        'value': value,
        'observations': observations,
        'status': status,
      });
      return jsonDecode(response.data)['success'];
    } catch (e) {
      throw RemoteFailure();
    }
  }

  @override
  Future<String> addAttachment(
      String companyId, String categoryId, String itemId, File photo
  ) async {
    try {
      var ref = _storage.ref().child('invoices/$companyId/$categoryId/item/$itemId'
          '${DateTime.now().millisecondsSinceEpoch}.jpg');
      await ref.putFile(photo);
      var url = await ref.getDownloadURL();

      var response = await _functions.httpsCallable(
        'addattachment',
      ).call({
        'attachment': url,
        'id': itemId
      });
      if (jsonDecode(response.data)['success'] == true) {
        return url;
      }
      return "";
    } catch (e) {
      throw RemoteFailure();
    }
  }

  @override
  Future<String> addPhoto(
      String companyId, String categoryId, String itemId, File photo
  ) async {
    try {
      var ref = _storage.ref().child('invoices/$companyId/$categoryId/item/$itemId'
          '${DateTime.now().millisecondsSinceEpoch}.jpg');
      await ref.putFile(photo);
      var url = await ref.getDownloadURL();

      var response = await _functions.httpsCallable(
        'addphoto',
      ).call({
        'attachment': url,
        'id': itemId
      });
      if (jsonDecode(response.data)['success'] == true) {
        return url;
      }
      return "";
    } catch (e) {
      throw RemoteFailure();
    }
  }

  @override
  Future<bool> deleteAttachment(String id, String url) async {
    try {
      var response = await _functions.httpsCallable(
        'deleteattachment',
      ).call({
        'url': url,
        'id': id
      });
      return jsonDecode(response.data)['success'];
    } catch (e) {
      throw RemoteFailure();
    }
  }

  @override
  Future<bool> deletePhoto(String id, String url) async {
    try {
      var response = await _functions.httpsCallable(
        'deletephoto',
      ).call({
        'url': url,
        'id': id
      });
      return jsonDecode(response.data)['success'];
    } catch (e) {
      throw RemoteFailure();
    }
  }
}
