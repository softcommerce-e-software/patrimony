import 'package:patrimony/generated/json/base/json_convert_content.dart';
import 'package:patrimony/entity/common_value_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';


CommonValueEntity $CommonValueEntityFromJson(Map<String, dynamic> json) {
  final CommonValueEntity commonValueEntity = CommonValueEntity();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    commonValueEntity.id = id;
  }
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    commonValueEntity.value = value;
  }
  return commonValueEntity;
}

Map<String, dynamic> $CommonValueEntityToJson(CommonValueEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['value'] = entity.value;
  return data;
}