// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_value_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommonValueEntityAdapter extends TypeAdapter<CommonValueEntity> {
  @override
  final int typeId = 2;

  @override
  CommonValueEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CommonValueEntity()
      ..id = fields[0] as String?
      ..value = fields[1] as String?;
  }

  @override
  void write(BinaryWriter writer, CommonValueEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommonValueEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
