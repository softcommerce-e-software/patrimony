import 'package:patrimony/generated/json/base/json_field.dart';
import 'package:patrimony/generated/json/item_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class ItemEntity {
	String? code;
	@JSONField(name: "conservation_state")
	String? conservationState;
	String? invoice;
	@JSONField(name: "now_location")
	String? nowLocation;
	double? price;
	@JSONField(name: "registration_location")
	String? registrationLocation;
	String? type;

	ItemEntity();

	factory ItemEntity.fromJson(Map<String, dynamic> json) => $ItemEntityFromJson(json);

	Map<String, dynamic> toJson() => $ItemEntityToJson(this);

	ItemEntity copyWith({String? code, String? conservationState, String? invoice, String? nowLocation, double? price, String? registrationLocation, String? type}) {
		return ItemEntity()
			..code= code ?? this.code
			..conservationState= conservationState ?? this.conservationState
			..invoice= invoice ?? this.invoice
			..nowLocation= nowLocation ?? this.nowLocation
			..price= price ?? this.price
			..registrationLocation= registrationLocation ?? this.registrationLocation
			..type= type ?? this.type;
	}

	@override
	String toString() {
		return jsonEncode(this);
	}
}