import 'package:patrimony/generated/json/base/json_field.dart';
import 'package:patrimony/generated/json/history_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class HistoryEntity {
	String? description;
	String? item;
	String? patrimony;
	String? responsible;

	HistoryEntity();

	factory HistoryEntity.fromJson(Map<String, dynamic> json) => $HistoryEntityFromJson(json);

	Map<String, dynamic> toJson() => $HistoryEntityToJson(this);

	HistoryEntity copyWith({String? description, String? item, String? patrimony, String? responsible}) {
		return HistoryEntity()
			..description= description ?? this.description
			..item= item ?? this.item
			..patrimony= patrimony ?? this.patrimony
			..responsible= responsible ?? this.responsible;
	}

	@override
	String toString() {
		return jsonEncode(this);
	}
}