import 'package:patrimony/generated/json/base/json_convert_content.dart';
import 'package:patrimony/entity/history_entity.dart';

HistoryEntity $HistoryEntityFromJson(Map<String, dynamic> json) {
  final HistoryEntity historyEntity = HistoryEntity();
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    historyEntity.description = description;
  }
  final String? item = jsonConvert.convert<String>(json['item']);
  if (item != null) {
    historyEntity.item = item;
  }
  final String? patrimony = jsonConvert.convert<String>(json['patrimony']);
  if (patrimony != null) {
    historyEntity.patrimony = patrimony;
  }
  final String? responsible = jsonConvert.convert<String>(json['responsible']);
  if (responsible != null) {
    historyEntity.responsible = responsible;
  }
  return historyEntity;
}

Map<String, dynamic> $HistoryEntityToJson(HistoryEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['description'] = entity.description;
  data['item'] = entity.item;
  data['patrimony'] = entity.patrimony;
  data['responsible'] = entity.responsible;
  return data;
}