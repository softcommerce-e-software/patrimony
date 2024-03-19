import 'dart:convert';
import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:patrimony/data/company/company_datasource.dart';
import 'package:patrimony/domain/utils/errors.dart';
import 'package:patrimony/entity/common_value_entity.dart';
import 'package:patrimony/entity/company_entity.dart';
import 'package:patrimony/entity/history_entity.dart';
import 'package:patrimony/entity/item_entity.dart';
import 'package:patrimony/entity/user_entity.dart';

class CompanyDataSourceImpl implements CompanyDataSource {
  CompanyDataSourceImpl(this._functions, this._storage);

  final FirebaseFunctions _functions;
  final FirebaseStorage _storage;

  @override
  Future<List<CompanyEntity>> getCompanies() async {
    try {
      var response = await _functions
          .httpsCallable(
            'getcompanies',
            options: HttpsCallableOptions(
              limitedUseAppCheckToken: false,
            ),
          )
          .call();
      return listCompanyEntityFromJson(response.data);
    } catch (e) {
      print(e);
      throw RemoteFailure();
    }
  }

  @override
  Future<List<HistoryEntity>> getHistory(String companyId) async {
    try {
      var response = await _functions
          .httpsCallable(
        'gethistory',
        options: HttpsCallableOptions(
          limitedUseAppCheckToken: true,
        ),
      ).call({'companyId': companyId});
      return listHistoryEntityFromJson(response.data);
    } catch (e) {
      throw RemoteFailure();
    }
  }

  @override
  Future<List<CommonValueEntity>> getConservationStates() async {
    throw RemoteFailure();
    // try {
    //   var response = await _db
    //       .from(_CONSERVATION_STATES)
    //       .select();
    //   return response.map((e) => CommonValueEntity.fromJson(e)).toList();
    // } catch (_) {
    //   throw RemoteFailure();
    // }
  }

  @override
  Future<List<ItemEntity>> getItems(String companyId, String categoryId) async {
    try {
      var response = await _functions
          .httpsCallable(
        'getitems',
        options: HttpsCallableOptions(
          limitedUseAppCheckToken: false,
        ),
      )
          .call({'companyId': companyId, 'categoryId': categoryId});
      return listItemEntityFromJson(response.data);
    } catch (e) {
      throw RemoteFailure();
    }
  }

  @override
  Future<List<CommonValueEntity>> getTypes(String id) async {
    try {
      var response = await _functions
          .httpsCallable(
        'getcategories',
        options: HttpsCallableOptions(
          limitedUseAppCheckToken: false,
        ),
      )
          .call({'id': id});
      return listCommonValueEntityFromJson(response.data);
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
  Future<List<UserEntity>> getUsers(String id) async {
    try {
      var response = await _functions
          .httpsCallable(
        id.isEmpty ? 'getusers' : 'getusersincompany',
        options: HttpsCallableOptions(
          limitedUseAppCheckToken: false,
        ),
      )
          .call({'id': id});
      return listUserEntityFromJson(response.data);
    } catch (_) {
      throw RemoteFailure();
    }
  }

  @override
  Future<bool> postItem(
      String companyId,
      String categoryId,
      String barcode,
      double value,
      String observations,
      List<File> attachments
  ) async {
    try {
      var futureUrls = attachments.map((e) async {
        var ref = _storage.ref().child('invoices/$companyId/$categoryId/'
            '${DateTime.now().millisecondsSinceEpoch}.jpg');
        await ref.putFile(e);
        var url = await ref.getDownloadURL();
        return url;
      });
      var urls = await Future.wait(futureUrls);
      var response = await _functions.httpsCallable(
        'postitem',
        options: HttpsCallableOptions(limitedUseAppCheckToken: false,),
      ).call({
        'companyId': companyId,
        'categoryId': categoryId,
        'barcode': barcode,
        'value': value,
        'observations': observations,
        'attachments': urls,
      });
      return jsonDecode(response.data)['success'];
    } catch (e) {
      throw RemoteFailure();
    }
  }

  Future<bool> postCategory(String companyId, String name) async {
    try {
      var response = await _functions.httpsCallable(
        'postcategory',
        options: HttpsCallableOptions(limitedUseAppCheckToken: false,),
      ).call({
        'companyId': companyId,
        'name': name,
      });
      return jsonDecode(response.data)['success'];
    } catch (e) {
      throw RemoteFailure();
    }
  }
}
