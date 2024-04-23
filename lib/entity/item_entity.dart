import 'dart:convert';

List<ItemEntity> listItemEntityFromJson(String str) => List<ItemEntity>
    .from(json.decode(str).map((model)=> ItemEntity.fromJson(model)));
ItemEntity itemEntityFromJson(String str) => ItemEntity.fromJson(json.decode(str));
String itemEntityToJson(ItemEntity data) => json.encode(data.toJson());
class ItemEntity {
  ItemEntity({
      String? id, 
      String? code,
    String? name,
      String? categoryId, 
      String? companyId, 
      String? observations,
    String? status,
    String? image,
      num? value, 
      List<String>? attachments,
    String? workingStatus}){
    _id = id;
    _code = code;
    _categoryId = categoryId;
    _companyId = companyId;
    _name = name;
    _observations = observations;
    _value = value;
    _status = status;
    _image = image;
    _attachments = attachments;
    _workingStatus = workingStatus;
}

  ItemEntity.fromJson(dynamic json) {
    _id = json['id'];
    _code = json['code'];
    _categoryId = json['category_id'];
    _companyId = json['company_id'];
    _observations = json['observations'];
    _name = json['name'];
    _value = json['value'];
    _status = json['status'];
    _image = json['image'];
    _attachments = json['attachments'] != null ? json['attachments'].cast<String>() : [];
    _workingStatus = json['working_status'];
  }
  String? _id;
  String? _code;
  String? _name;
  String? _image;
  String? _categoryId;
  String? _companyId;
  String? _observations;
  String? _status;
  num? _value;
  List<String>? _attachments;
  String? _workingStatus;

ItemEntity copyWith({  String? id,
  String? code,
  String? categoryId,
  String? companyId,
  String? name,
  String? observations,
  String? status,
  String? image,
  num? value,
  List<String>? attachments,
  String? workingStatus
}) => ItemEntity(  id: id ?? _id,
  code: code ?? _code,
  categoryId: categoryId ?? _categoryId,
  companyId: companyId ?? _companyId,
  observations: observations ?? _observations,
  value: value ?? _value,
  name: name ?? _name,
  status: status ?? _status,
  image: image ?? _image,
  attachments: attachments ?? _attachments,
  workingStatus: workingStatus ?? _workingStatus ?? workingStatusList[0]
);
  String? get id => _id;
  String? get code => _code;
  String? get status => _status;
  String? get name => _name;
  String? get categoryId => _categoryId;
  String? get companyId => _companyId;
  String? get observations => _observations;
  String? get image => _image;
  num? get value => _value;
  List<String>? get attachments => _attachments;
  String get workingStatus => _workingStatus ?? workingStatusList[0];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['code'] = _code;
    map['name'] = _name;
    map['category_id'] = _categoryId;
    map['company_id'] = _companyId;
    map['observations'] = _observations;
    map['value'] = _value;
    map['image'] = _image;
    map['attachments'] = _attachments;
    map['working_status'] = _workingStatus;
    return map;
  }

}

const workingStatusList = ['Em funcionamento', 'Parado', 'Com defeito'];