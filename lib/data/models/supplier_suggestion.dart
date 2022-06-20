// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:eyyplus/domain/entity/supplier_suggestion.dart';
import 'package:hive/hive.dart';

part 'supplier_suggestion.g.dart';

@HiveType(typeId: 3)
class SupplierSuggestionModel extends SupplierSuggestionEntity {
  @HiveField(0)
  final String suppliername;
  SupplierSuggestionModel({
    required this.suppliername,
  }) : super(
          suppliername: suppliername,
        );

  factory SupplierSuggestionModel.fromEntity(SupplierSuggestionEntity entity) {
    return SupplierSuggestionModel(suppliername: entity.suppliername);
  }
}
