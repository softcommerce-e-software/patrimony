import 'dart:convert';

List<HistoryEntity> listHistoryEntityFromJson(String str) => List<HistoryEntity>
    .from(json.decode(str).map((model)=> HistoryEntity.fromJson(model)));
HistoryEntity historyEntityFromJson(String str) => HistoryEntity.fromJson(json.decode(str));
String historyEntityToJson(HistoryEntity data) => json.encode(data.toJson());
class HistoryEntity {
  HistoryEntity({
      String? companyId, 
      String? createAt, 
      String? email, 
      String? id, 
      String? itemId, 
      String? title, 
      String? updateAt,}){
    _companyId = companyId;
    _createAt = createAt;
    _email = email;
    _id = id;
    _itemId = itemId;
    _title = title;
    _updateAt = updateAt;
}

  HistoryEntity.fromJson(dynamic json) {
    _companyId = json['company_id'];
    _createAt = json['create_at'];
    _email = json['email'];
    _id = json['id'];
    _itemId = json['item_id'];
    _title = json['title'];
    _updateAt = json['update_at'];
  }
  String? _companyId;
  String? _createAt;
  String? _email;
  String? _id;
  String? _itemId;
  String? _title;
  String? _updateAt;
HistoryEntity copyWith({  String? companyId,
  String? createAt,
  String? email,
  String? id,
  String? itemId,
  String? title,
  String? updateAt,
}) => HistoryEntity(  companyId: companyId ?? _companyId,
  createAt: createAt ?? _createAt,
  email: email ?? _email,
  id: id ?? _id,
  itemId: itemId ?? _itemId,
  title: title ?? _title,
  updateAt: updateAt ?? _updateAt,
);
  String? get companyId => _companyId;
  String? get createAt => _createAt;
  String? get email => _email;
  String? get id => _id;
  String? get itemId => _itemId;
  String? get title => _title;
  String? get updateAt => _updateAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['company_id'] = _companyId;
    map['create_at'] = _createAt;
    map['email'] = _email;
    map['id'] = _id;
    map['item_id'] = _itemId;
    map['title'] = _title;
    map['update_at'] = _updateAt;
    return map;
  }

}