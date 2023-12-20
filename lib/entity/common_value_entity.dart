import 'package:hive_flutter/hive_flutter.dart';
import 'package:patrimony/generated/json/base/json_field.dart';
import 'package:patrimony/generated/json/common_value_entity.g.dart';
import 'dart:convert';

part 'common_value_entity.g.dart';
const String typeBox = 'typeBox';
const String conservationStateBox = 'conservationStateBox';

@JsonSerializable()
@HiveType(typeId: 2)
class CommonValueEntity extends HiveObject {
	@HiveField(0)
	String? id;
	@HiveField(1)
	String? value;

	CommonValueEntity();

	factory CommonValueEntity.fromJson(Map<String, dynamic> json) => $CommonValueEntityFromJson(json);

	Map<String, dynamic> toJson() => $CommonValueEntityToJson(this);

	CommonValueEntity copyWith({String? value}) {
		return CommonValueEntity()
			..id= id ?? this.id
			..value= value ?? this.value;
	}

	@override
	String toString() {
		return jsonEncode(this);
	}

	@override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommonValueEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          value == other.value;

  @override
  int get hashCode => id.hashCode ^ value.hashCode;
}