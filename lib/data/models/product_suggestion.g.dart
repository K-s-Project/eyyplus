// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_suggestion.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductSuggestionModelAdapter
    extends TypeAdapter<ProductSuggestionModel> {
  @override
  final int typeId = 2;

  @override
  ProductSuggestionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductSuggestionModel(
      suggestion: fields[0] as String,
      receiptno: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProductSuggestionModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.suggestion)
      ..writeByte(1)
      ..write(obj.receiptno);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductSuggestionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
