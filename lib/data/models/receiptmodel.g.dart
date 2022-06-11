// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receiptmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReceiptModelAdapter extends TypeAdapter<ReceiptModel> {
  @override
  final int typeId = 0;

  @override
  ReceiptModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReceiptModel(
      receiptno: fields[0] as String,
      date: fields[1] as String,
      supplier: fields[2] as String,
      product: (fields[3] as List).cast<ProductModel>(),
      totalquantity: fields[4] as int,
      totalprice: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ReceiptModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.receiptno)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.supplier)
      ..writeByte(3)
      ..write(obj.product)
      ..writeByte(4)
      ..write(obj.totalquantity)
      ..writeByte(5)
      ..write(obj.totalprice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReceiptModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
