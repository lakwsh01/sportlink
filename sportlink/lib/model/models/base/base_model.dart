import 'package:sportlink/model/models/base/metadata.dart';

abstract class BaseModel<T> {
  final String id;
  final MetaData metadata;

  const BaseModel({required this.id, required this.metadata});

  T Function(Map) get update;
  Map get json;
}
