import 'package:patrimony/data/company/company_datasource.dart';
import 'package:patrimony/domain/utils/errors.dart';
import 'package:patrimony/entity/common_value_entity.dart';
import 'package:patrimony/entity/company_entity.dart';
import 'package:patrimony/entity/history_entity.dart';
import 'package:patrimony/entity/item_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CompanyDataSourceImpl implements CompanyDataSource {
  final SupabaseClient _db;
  final GoTrueClient _auth;

  CompanyDataSourceImpl(this._db, this._auth);

  static const String _COMPANIES = 'companies';
  static const String _HISTORY = 'history';
  static const String _CONSERVATION_STATES = 'conservation_states';
  static const String _ITEMS = 'items';
  static const String _TYPES = 'types';
  static const String _ITEMS_VIEW = 'items_view';

  @override
  Future<List<CompanyEntity>> getCompanies() async {
    try {
      var response = await _db
          .from(_COMPANIES)
          .select()
          .contains('users', [_auth.currentUser?.id]);
      return response.map((e) => CompanyEntity.fromJson(e)).toList();
    } catch (_) {
      throw RemoteFailure();
    }
  }

  @override
  Future<List<HistoryEntity>> getHistory() async {
    try {
      var response = await _db
          .from(_HISTORY)
          .select();
      return response.map((e) => HistoryEntity.fromJson(e)).toList();
    } catch (_) {
      throw RemoteFailure();
    }
  }

  @override
  Future<List<CommonValueEntity>> getConservationStates() async {
    try {
      var response = await _db
          .from(_CONSERVATION_STATES)
          .select();
      return response.map((e) => CommonValueEntity.fromJson(e)).toList();
    } catch (_) {
      throw RemoteFailure();
    }
  }

  @override
  Future<List<ItemEntity>> getItems(String id) async {
    try {
      var response = await _db
          .from(_ITEMS)
          .select();
      return response.map((e) => ItemEntity.fromJson(e)).toList();
    } catch (_) {
      throw RemoteFailure();
    }
  }

  @override
  Future<List<CommonValueEntity>> getTypes() async {
    try {
      var response = await _db
          .from(_TYPES)
          .select();
      return response.map((e) => CommonValueEntity.fromJson(e)).toList();
    } catch (_) {
      throw RemoteFailure();
    }
  }

  @override
  Future<ItemEntity?> searchItem(String code, String companyId) async {
    try {
      var response = await _db
          .from(_ITEMS_VIEW)
          .select()
          .eq('code', code);
      return response.map((e) => ItemEntity.fromJson(e)).firstOrNull;
    } catch (_) {
      throw RemoteFailure();
    }
  }
}
