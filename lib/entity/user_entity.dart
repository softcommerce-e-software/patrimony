import 'package:hive/hive.dart';
import 'package:patrimony/generated/json/base/json_field.dart';
import 'package:patrimony/generated/json/user_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
@HiveType(typeId: 3)
class UserEntity extends HiveObject {
	@HiveField(0)
	bool? isAdmin;
	@HiveField(1)
	String? id;
	@HiveField(2)
	String? name;
	@HiveField(3)
	String? email;
	@HiveField(4)
	String? photo;

	UserEntity();

	factory UserEntity.fromJson(Map<String, dynamic> json) => $UserEntityFromJson(json);

	Map<String, dynamic> toJson() => $UserEntityToJson(this);

	UserEntity copyWith({bool? isAdmin, String? id, String? name, String? email, String? photo}) {
		return UserEntity()
			..isAdmin= isAdmin ?? this.isAdmin
			..id= id ?? this.id
			..name= name ?? this.name
			..email= email ?? this.email
			..photo= photo ?? this.photo;
	}

	@override
	String toString() {
		return jsonEncode(this);
	}
}