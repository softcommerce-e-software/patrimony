import 'package:patrimony/generated/json/base/json_convert_content.dart';
import 'package:patrimony/entity/user_entity.dart';

UserEntity $UserEntityFromJson(Map<String, dynamic> json) {
  final UserEntity userEntity = UserEntity();
  final bool? isAdmin = jsonConvert.convert<bool>(json['isAdmin']);
  if (isAdmin != null) {
    userEntity.isAdmin = isAdmin;
  }
  final String? uid = jsonConvert.convert<String>(json['uid']);
  if (uid != null) {
    userEntity.uid = uid;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    userEntity.name = name;
  }
  return userEntity;
}

Map<String, dynamic> $UserEntityToJson(UserEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['isAdmin'] = entity.isAdmin;
  data['uid'] = entity.uid;
  data['name'] = entity.name;
  return data;
}