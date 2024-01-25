import 'package:patrimony/generated/json/base/json_field.dart';
import 'package:patrimony/generated/json/company_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class CompanyEntity {
  String? id;
  String? name;
  String? owner;
  List<String>? users;

  CompanyEntity();

  factory CompanyEntity.fromJson(Map<String, dynamic> json) =>
      $CompanyEntityFromJson(json);

  Map<String, dynamic> toJson() => $CompanyEntityToJson(this);

  CompanyEntity copyWith(
      {String? id, String? name, String? owner, List<String>? users}) {
    return CompanyEntity()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..owner = owner ?? this.owner
      ..users = users ?? this.users;
  }

  @override
  String toString() {
    return jsonEncode(this);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompanyEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          owner == other.owner &&
          users == other.users;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ owner.hashCode ^ users.hashCode;
}
