import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:patrimony/data/company/company_datasource.dart';
import 'package:patrimony/domain/utils/errors.dart';
import 'package:patrimony/entity/common_value_entity.dart';
import 'package:patrimony/entity/company_entity.dart';
import 'package:patrimony/entity/history_entity.dart';
import 'package:patrimony/entity/user_entity.dart';

class CompanyDataSourceImpl implements CompanyDataSource {
  CompanyDataSourceImpl(this._functions);

  final FirebaseFunctions _functions;

  @override
  Future<List<CompanyEntity>> getCompanies() async {
    try {
      var response = await _functions
          .httpsCallable(
            'getcompanies',
          ).call();
      return listCompanyEntityFromJson(response.data);
    } catch (e) {
      throw RemoteFailure();
    }
  }

  @override
  Future<List<HistoryEntity>> getHistory(String companyId, int page) async {
    try {
      var response = await _functions
          .httpsCallable(
        'gethistoryapp',
      ).call({'id': companyId, 'page': page});
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

  @override
  Future<bool> updateCategory(String id, String name) async {
    try {
      var response = await _functions.httpsCallable(
        'updatecategory',
      ).call({
        'id': id,
        'name': name,
      });
      return jsonDecode(response.data)['success'];
    } catch (e) {
      throw RemoteFailure();
    }
  }
}
