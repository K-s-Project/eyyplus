// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_suggestion.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SupplierSuggestionModelAdapter
    extends TypeAdapter<SupplierSuggestionModel> {
  @override
  final int typeId = 3;

  @override
  SupplierSuggestionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SupplierSuggestionModel(
      suppliername: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SupplierSuggestionModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.suppliername);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SupplierSuggestionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
