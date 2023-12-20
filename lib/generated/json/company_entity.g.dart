import 'package:patrimony/generated/json/base/json_convert_content.dart';
import 'package:patrimony/entity/company_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';


CompanyEntity $CompanyEntityFromJson(Map<String, dynamic> json) {
  final CompanyEntity companyEntity = CompanyEntity();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    companyEntity.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    companyEntity.name = name;
  }
  final String? owner = jsonConvert.convert<String>(json['owner']);
  if (owner != null) {
    companyEntity.owner = owner;
  }
  final List<String>? users = (json['users'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (users != null) {
    companyEntity.users = users;
  }
  return companyEntity;
}

Map<String, dynamic> $CompanyEntityToJson(CompanyEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['owner'] = entity.owner;
  data['users'] = entity.users;
  return data;
}