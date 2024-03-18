import 'dart:convert';

List<ItemEntity> listItemEntityFromJson(String str) => List<ItemEntity>
    .from(json.decode(str).map((model)=> ItemEntity.fromJson(model)));
ItemEntity itemEntityFromJson(String str) => ItemEntity.fromJson(json.decode(str));
String itemEntityToJson(ItemEntity data) => json.encode(data.toJson());
class ItemEntity {
  ItemEntity({
      String? id, 
      String? code, 
      String? categoryId, 
      String? companyId, 
      String? observations,
    String? status,
      num? value, 
      List<String>? attachments,}){
    _id = id;
    _code = code;
    _categoryId = categoryId;
    _companyId = companyId;
    _observations = observations;
    _value = value;
    _status = status;
    _attachments = attachments;
}

  ItemEntity.fromJson(dynamic json) {
    _id = json['id'];
    _code = json['code'];
    _categoryId = json['category_id'];
    _companyId = json['company_id'];
    _observations = json['observations'];
    _value = json['value'];
    _status = json['status'];
    _attachments = json['attachments'] != null ? json['attachments'].cast<String>() : [];
  }
  String? _id;
  String? _code;
  String? _categoryId;
  String? _companyId;
  String? _observations;
  String? _status;
  num? _value;
  List<String>? _attachments;
ItemEntity copyWith({  String? id,
  String? code,
  String? categoryId,
  String? companyId,
  String? observations,
  String? status,
  num? value,
  List<String>? attachments,
}) => ItemEntity(  id: id ?? _id,
  code: code ?? _code,
  categoryId: categoryId ?? _categoryId,
  companyId: companyId ?? _companyId,
  observations: observations ?? _observations,
  value: value ?? _value,
  status: status ?? _status,
  attachments: attachments ?? _attachments,
);
  String? get id => _id;
  String? get code => _code;
  String? get status => _status;
  String? get categoryId => _categoryId;
  String? get companyId => _companyId;
  String? get observations => _observations;
  num? get value => _value;
  List<String>? get attachments => _attachments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['code'] = _code;
    map['category_id'] = _categoryId;
    map['company_id'] = _companyId;
    map['observations'] = _observations;
    map['value'] = _value;
    map['attachments'] = _attachments;
    return map;
  }

}