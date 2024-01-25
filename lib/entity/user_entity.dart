import 'package:patrimony/generated/json/base/json_field.dart';
import 'package:patrimony/generated/json/user_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class UserEntity {
  bool? isAdmin;
  String? id;
  String? name;
  String? email;
  String? photo;

  UserEntity();

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      $UserEntityFromJson(json);

  Map<String, dynamic> toJson() => $UserEntityToJson(this);

  UserEntity copyWith(
      {bool? isAdmin, String? id, String? name, String? email, String? photo}) {
    return UserEntity()
      ..isAdmin = isAdmin ?? this.isAdmin
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..email = email ?? this.email
      ..photo = photo ?? this.photo;
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}
