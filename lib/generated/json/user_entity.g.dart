import 'package:patrimony/generated/json/base/json_convert_content.dart';
import 'package:patrimony/entity/user_entity.dart';

UserEntity $UserEntityFromJson(Map<String, dynamic> json) {
  final UserEntity userEntity = UserEntity();
  final bool? isAdmin = jsonConvert.convert<bool>(json['isAdmin']);
  if (isAdmin != null) {
    userEntity.isAdmin = isAdmin;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    userEntity.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    userEntity.name = name;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    userEntity.email = email;
  }
  final String? photo = jsonConvert.convert<String>(json['photo']);
  if (photo != null) {
    userEntity.photo = photo;
  }
  return userEntity;
}

Map<String, dynamic> $UserEntityToJson(UserEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['isAdmin'] = entity.isAdmin;
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['email'] = entity.email;
  data['photo'] = entity.photo;
  return data;
}