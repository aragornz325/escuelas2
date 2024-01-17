import 'package:escuelas_commons/escuelas_commons.dart';
import 'package:serverpod/serverpod.dart';

/// {@template Role}
/// A role is a set of permissions that can be assigned to a user.
/// {@endtemplate}
class Role extends TableRow {
  /// {@macro Role}
  Role({
    int? id,
    required this.name,
    required this.permissions,
    required this.createdAt,
    required this.updatedAt,
  }) : super(id);

  /// {@macro fromJson}
  factory Role.fromJson(
    Map<String, dynamic> json,
    // ignore: avoid_unused_constructor_parameters
    SerializationManager serializationManager,
  ) {
    return Role(
      id: json['id'] as int,
      name: json['name'] as String,
      permissions: json['permissions'] as String,
      createdAt: DateTime.parse(json['createdAt'].toString()),
      updatedAt: DateTime.parse(json['createdAt'].toString()),
    );
  }

  /// The permissions of the role.
  String permissions;

  /// The name of the role.
  String name;

  DateTime createdAt;

  DateTime updatedAt;

  /// This is the JSON representation of the Role class.
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'permissions': permissions,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': createdAt.toIso8601String(),
    };
  }

  List<List<Enum>> get permissionsList =>
      Permisos().deserialization(permissions);

  @override
  void setColumn(String columnName, value) {
    switch (columnName) {
      case 'id':
        id = value as int;
      case 'name':
        name = value as String;
      case 'permissions':
        permissions = value as String;
      case 'createdAt':
        createdAt = value as DateTime;
      case 'updatedAt':
        createdAt = value as DateTime;
    }
  }

  @override
  Table get table => RoleTable();

  @override
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'name': name,
      'permissions': permissions,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': createdAt.toIso8601String(),
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'id': id,
      'name': name,
      'permissions': permissions,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': createdAt.toIso8601String(),
    };
  }
}

class RoleTable extends Table {
  RoleTable() : super(tableName: 'roles') {
    id = ColumnInt('id', this);
    name = ColumnString('name', this);
    permissions = ColumnString('permissions', this);
    createdAt = ColumnDateTime('createdAt', this);
    updatedAt = ColumnDateTime('updatedAt', this);
  }

  @override
  String tableName = 'roles';

  @override
  late final ColumnInt id;
  late final ColumnString name;
  late final ColumnString permissions;
  late final ColumnDateTime createdAt;
  late final ColumnDateTime updatedAt;

  @override
  List<Column<dynamic>> get columns => [
        id,
        name,
        permissions,
        createdAt,
        updatedAt,
      ];
}
