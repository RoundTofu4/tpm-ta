// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sparepart.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SparepartAdapter extends TypeAdapter<Sparepart> {
  @override
  final int typeId = 1;

  @override
  Sparepart read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sparepart(
      name: fields[0] as String,
      stock: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Sparepart obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.stock);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SparepartAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
