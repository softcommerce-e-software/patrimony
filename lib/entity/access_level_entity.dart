import 'dart:convert';

List<AccessLevelEntity> listAccessLevelEntityFromJson(String str) => List<AccessLevelEntity>
    .from(json.decode(str).map((model)=> AccessLevelEntity.fromJson(model)));
AccessLevelEntity accessLevelEntityFromJson(String str) => AccessLevelEntity.fromJson(json.decode(str));
String accessLevelEntityToJson(AccessLevelEntity data) => json.encode(data.toJson());
class AccessLevelEntity {
  AccessLevelEntity({
      String? name, 
      String? description, 
      String? id, 
      num? level,}){
    _name = name;
    _description = description;
    _id = id;
    _level = level;
}

  AccessLevelEntity.fromJson(dynamic json) {
    _name = json['name'];
    _description = json['description'];
    _id = json['id'];
    _level = json['level'];
  }
  String? _name;
  String? _description;
  String? _id;
  num? _level;
AccessLevelEntity copyWith({  String? name,
  String? description,
  String? id,
  num? level,
}) => AccessLevelEntity(  name: name ?? _name,
  description: description ?? _description,
  id: id ?? _id,
  level: level ?? _level,
);
  String? get name => _name;
  String? get description => _description;
  String? get id => _id;
  num? get level => _level;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['description'] = _description;
    map['id'] = _id;
    map['level'] = _level;
    return map;
  }

}