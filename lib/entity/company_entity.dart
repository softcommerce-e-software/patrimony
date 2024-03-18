import 'dart:convert';
import 'package:patrimony/entity/access_level_entity.dart';

List<CompanyEntity> listCompanyEntityFromJson(String str) => List<CompanyEntity>
    .from(json.decode(str).map((model)=> CompanyEntity.fromJson(model)));
CompanyEntity companyEntityFromJson(String str) => CompanyEntity.fromJson(json.decode(str));
String companyEntityToJson(CompanyEntity data) => json.encode(data.toJson());
class CompanyEntity {
  CompanyEntity({
      String? name, 
      String? id, 
      List<AccessLevelEntity>? access,}){
    _name = name;
    _id = id;
    _access = access;
}

  CompanyEntity.fromJson(dynamic json) {
    _name = json['name'];
    _id = json['id'];
    _access = json['access'] != null ?
      listAccessLevelEntityFromJson(jsonEncode(json['access'])) : [];
  }
  String? _name;
  String? _id;
  List<AccessLevelEntity>? _access;
CompanyEntity copyWith({  String? name,
  String? id,
  List<AccessLevelEntity>? access,
}) => CompanyEntity(  name: name ?? _name,
  id: id ?? _id,
  access: access ?? _access,
);
  String? get name => _name;
  String? get id => _id;
  List<AccessLevelEntity>? get access => _access;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['id'] = _id;
    map['access'] = _access;
    return map;
  }

}