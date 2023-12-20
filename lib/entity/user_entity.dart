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
	String? uid;
	@HiveField(2)
	String? name;

	UserEntity();

	factory UserEntity.fromJson(Map<String, dynamic> json) => $UserEntityFromJson(json);

	Map<String, dynamic> toJson() => $UserEntityToJson(this);

	UserEntity copyWith({bool? isAdmin, String? uid, String? name}) {
		return UserEntity()
			..isAdmin= isAdmin ?? this.isAdmin
			..uid= uid ?? this.uid
			..name= name ?? this.name;
	}

	@override
	String toString() {
		return jsonEncode(this);
	}

	@override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntity &&
          runtimeType == other.runtimeType &&
          isAdmin == other.isAdmin &&
          uid == other.uid &&
          name == other.name;

  @override
  int get hashCode => isAdmin.hashCode ^ uid.hashCode ^ name.hashCode;
}