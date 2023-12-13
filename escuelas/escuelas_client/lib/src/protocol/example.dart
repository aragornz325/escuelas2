/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class Example extends _i1.SerializableEntity {
  Example._({
    this.id,
    required this.name,
    required this.data,
  });

  factory Example({
    int? id,
    required String name,
    required int data,
  }) = _ExampleImpl;

  factory Example.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Example(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      name: serializationManager.deserialize<String>(jsonSerialization['name']),
      data: serializationManager.deserialize<int>(jsonSerialization['data']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  int data;

  Example copyWith({
    int? id,
    String? name,
    int? data,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'data': data,
    };
  }
}

class _Undefined {}

class _ExampleImpl extends Example {
  _ExampleImpl({
    int? id,
    required String name,
    required int data,
  }) : super._(
          id: id,
          name: name,
          data: data,
        );

  @override
  Example copyWith({
    Object? id = _Undefined,
    String? name,
    int? data,
  }) {
    return Example(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      data: data ?? this.data,
    );
  }
}
