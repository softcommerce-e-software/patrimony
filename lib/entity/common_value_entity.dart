import 'dart:convert';

List<CommonValueEntity> listCommonValueEntityFromJson(String str) => List<CommonValueEntity>
    .from(json.decode(str).map((model)=> CommonValueEntity.fromJson(model)));
CommonValueEntity commonValueEntityFromJson(String str) => CommonValueEntity.fromJson(json.decode(str));
String commonValueEntityToJson(CommonValueEntity data) => json.encode(data.toJson());
class CommonValueEntity {
  CommonValueEntity({
      String? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  CommonValueEntity.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;
CommonValueEntity copyWith({  String? id,
  String? name,
}) => CommonValueEntity(  id: id ?? _id,
  name: name ?? _name,
);
  String? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}