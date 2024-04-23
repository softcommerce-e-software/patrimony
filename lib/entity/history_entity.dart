import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<HistoryEntity> listHistoryEntityFromJson(String str) => List<HistoryEntity>
    .from(json.decode(str).map((model)=> HistoryEntity.fromJson(model)));
HistoryEntity historyEntityFromJson(String str) => HistoryEntity.fromJson(json.decode(str));
String historyEntityToJson(HistoryEntity data) => json.encode(data.toJson());
class HistoryEntity {
  HistoryEntity({
      String? companyId,
    DateTime? createAt,
      String? email, 
      String? id, 
      String? itemId, 
      String? title, }){
    _companyId = companyId;
    _createAt = createAt;
    _email = email;
    _id = id;
    _itemId = itemId;
    _title = title;
}

  HistoryEntity.fromJson(dynamic json) {
    _companyId = json['company_id'];
    _createAt = DateTime.tryParse(Timestamp(json['create_at']['_seconds'], json['create_at']['_nanoseconds']).toDate().toString());
    _email = json['email'];
    _id = json['id'];
    _itemId = json['item_id'];
    _title = json['title'];
  }
  String? _companyId;
  DateTime? _createAt;
  String? _email;
  String? _id;
  String? _itemId;
  String? _title;
HistoryEntity copyWith({  String? companyId,
  DateTime? createAt,
  String? email,
  String? id,
  String? itemId,
  String? title,
}) => HistoryEntity(  companyId: companyId ?? _companyId,
  createAt: createAt ?? _createAt,
  email: email ?? _email,
  id: id ?? _id,
  itemId: itemId ?? _itemId,
  title: title ?? _title,
);
  String? get companyId => _companyId;
  DateTime? get createAt => _createAt;
  String? get email => _email;
  String? get id => _id;
  String? get itemId => _itemId;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['company_id'] = _companyId;
    map['create_at'] = _createAt;
    map['email'] = _email;
    map['id'] = _id;
    map['item_id'] = _itemId;
    map['title'] = _title;
    return map;
  }

}