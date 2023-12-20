import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:patrimony/data/company/company_datasource.dart';
import 'package:patrimony/domain/utils/errors.dart';
import 'package:patrimony/entity/common_value_entity.dart';
import 'package:patrimony/entity/company_entity.dart';
import 'package:patrimony/entity/history_entity.dart';
import 'package:patrimony/entity/item_entity.dart';

class CompanyDataSourceImpl implements CompanyDataSource {
  final FirebaseFirestore _db;
  final FirebaseAuth _auth;

  CompanyDataSourceImpl(this._db, this._auth);

  static const String _COMPANIES = 'companies';
  static const String _USERS = 'users';
  static const String _HISTORY = 'history';
  static const String _CONSERVATION_STATE = 'conservation_state';
  static const String _ITEM = 'item';
  static const String _TYPE = 'type';

  DocumentReference<dynamic>? _companyDocument;

  @override
  Future<List<CompanyEntity>> getCompanies() async {
    try {
      var response = await _db
          .collection(_COMPANIES)
          .where(_USERS, arrayContains: _auth.currentUser?.uid)
          .withConverter<CompanyEntity>(
            fromFirestore: (snapshot, _) {
              var data = snapshot.data()!;
              data.addAll({'id': snapshot.id});
              return CompanyEntity.fromJson(data);
            },
            toFirestore: (model, _) => model.toJson(),
          )
          .get(const GetOptions(source: Source.serverAndCache));
      return response.docs.map((e) => e.data()).toList();
    } catch (_) {
      throw RemoteFailure();
    }
  }

  @override
  Future<List<HistoryEntity>> getHistory() async {
    try {
      var response = await _companyDocument
          ?.collection(_HISTORY)
          .withConverter<HistoryEntity>(
            fromFirestore: (snapshot, _) =>
                HistoryEntity.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson(),
          )
          .get();
      return response?.docs.map((e) => e.data()).toList() ?? [];
    } catch (_) {
      throw RemoteFailure();
    }
  }

  @override
  Future<List<CommonValueEntity>> getConservationStates() async {
    try {
      var response = await _db.collection(_CONSERVATION_STATE)
          .withConverter<CommonValueEntity>(
            fromFirestore: (snapshot, _) =>
                CommonValueEntity.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson(),
          )
          .get();
      return response.docs.map((e) => e.data()).toList() ?? [];
    } catch (_) {
      throw RemoteFailure();
    }
  }

  @override
  Future<List<ItemEntity>> getItems(String id) async {
    try {
      var response = await _companyDocument
          ?.collection(_ITEM)
          .withConverter<ItemEntity>(
            fromFirestore: (snapshot, _) {
              var data = snapshot.data()!;
              data.addAll({'id': snapshot.id});
              return ItemEntity.fromJson(data);
            },
            toFirestore: (model, _) => model.toJson(),
          )
          .get();
      return response?.docs.map((e) => e.data()).toList() ?? [];
    } catch (_) {
      throw RemoteFailure();
    }
  }

  @override
  Future<List<CommonValueEntity>> getTypes() async {
    try {
      var response = await _db.collection(_TYPE)
          .withConverter<CommonValueEntity>(
            fromFirestore: (snapshot, _) {
              var data = snapshot.data()!;
              data.addAll({'id': snapshot.id});
              return CommonValueEntity.fromJson(data);
            },
            toFirestore: (model, _) => model.toJson(),
          )
          .get();
      return response.docs.map((e) => e.data()).toList() ?? [];
    } catch (_) {
      throw RemoteFailure();
    }
  }

  @override
  Future<ItemEntity?> searchItem(String code, String companyId) async {
    try {
      _companyDocument = FirebaseFirestore.instance.doc('$_COMPANIES/$companyId');
      var response = await _companyDocument
          ?.collection(_ITEM)
          .where('code', isEqualTo: code)
          .withConverter<ItemEntity>(
            fromFirestore: (snapshot, _) {
              var data = snapshot.data()!;
              data.addAll({'id': snapshot.id});
              return ItemEntity.fromJson(data);
            },
            toFirestore: (model, _) => model.toJson(),
          )
          .get();
      return response?.docs.firstOrNull?.data();
    } catch (_) {
      throw RemoteFailure();
    }
  }
}
