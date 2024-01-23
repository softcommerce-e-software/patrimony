import 'package:patrimony/generated/json/base/json_convert_content.dart';
import 'package:patrimony/entity/item_entity.dart';

ItemEntity $ItemEntityFromJson(Map<String, dynamic> json) {
  final ItemEntity itemEntity = ItemEntity();
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    itemEntity.code = code;
  }
  final String? conservationState = jsonConvert.convert<String>(
      json['conservation_state']);
  if (conservationState != null) {
    itemEntity.conservationState = conservationState;
  }
  final String? invoice = jsonConvert.convert<String>(json['invoice']);
  if (invoice != null) {
    itemEntity.invoice = invoice;
  }
  final String? nowLocation = jsonConvert.convert<String>(json['now_location']);
  if (nowLocation != null) {
    itemEntity.nowLocation = nowLocation;
  }
  final double? price = jsonConvert.convert<double>(json['price']);
  if (price != null) {
    itemEntity.price = price;
  }
  final String? registrationLocation = jsonConvert.convert<String>(
      json['registration_location']);
  if (registrationLocation != null) {
    itemEntity.registrationLocation = registrationLocation;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    itemEntity.type = type;
  }
  return itemEntity;
}

Map<String, dynamic> $ItemEntityToJson(ItemEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['conservation_state'] = entity.conservationState;
  data['invoice'] = entity.invoice;
  data['now_location'] = entity.nowLocation;
  data['price'] = entity.price;
  data['registration_location'] = entity.registrationLocation;
  data['type'] = entity.type;
  return data;
}