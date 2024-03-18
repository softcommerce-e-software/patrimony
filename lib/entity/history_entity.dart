import 'dart:convert';
HistoryEntity historyEntityFromJson(String str) => HistoryEntity.fromJson(json.decode(str));
String historyEntityToJson(HistoryEntity data) => json.encode(data.toJson());
class HistoryEntity {
  HistoryEntity({
      String? description, 
      String? item, 
      String? patrimony, 
      String? responsible,}){
    _description = description;
    _item = item;
    _patrimony = patrimony;
    _responsible = responsible;
}

  HistoryEntity.fromJson(dynamic json) {
    _description = json['description'];
    _item = json['item'];
    _patrimony = json['patrimony'];
    _responsible = json['responsible'];
  }
  String? _description;
  String? _item;
  String? _patrimony;
  String? _responsible;
HistoryEntity copyWith({  String? description,
  String? item,
  String? patrimony,
  String? responsible,
}) => HistoryEntity(  description: description ?? _description,
  item: item ?? _item,
  patrimony: patrimony ?? _patrimony,
  responsible: responsible ?? _responsible,
);
  String? get description => _description;
  String? get item => _item;
  String? get patrimony => _patrimony;
  String? get responsible => _responsible;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['description'] = _description;
    map['item'] = _item;
    map['patrimony'] = _patrimony;
    map['responsible'] = _responsible;
    return map;
  }

}