import 'package:serverpod/serverpod.dart';

class UserRoleRelation extends TableRow {
  UserRoleRelation({
    required this.id,
    required this.userId,
    required this.roleId,
    required this.createdAt,
  });

  factory UserRoleRelation.fromJson(
    Map<String, dynamic> json,
    // ignore: avoid_unused_constructor_parameters
    SerializationManager serializationManager,
  ) {
    return UserRoleRelation(
      id: json['id'] as int,
      userId: json['userId'] as int,
      roleId: json['roleId'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  @override
  int? id;
  int userId;
  int roleId;
  DateTime createdAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'roleId': roleId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  @override
  void setColumn(String columnName, value) {
    switch (columnName) {
      case 'id':
        id = value as int;
        break;
      case 'userId':
        userId = value as int;
        break;
      case 'roleId':
        roleId = value as int;
        break;
      case 'createdAt':
        createdAt = DateTime.parse(value as String);
        break;
    }
  }

  @override
  Table get table => UserRoleRelationTable();

  @override
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'userId': userId,
      'roleId': roleId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class UserRoleRelationTable extends Table {
  UserRoleRelationTable() : super(tableName: 'user_role_relation') {
    id = ColumnInt('id', this);
    userId = ColumnInt('userId', this);
    roleId = ColumnInt('roleId', this);
    createdAt = ColumnDateTime('createdAt', this);
  }

  late final ColumnInt id;
  late final ColumnInt userId;
  late final ColumnInt roleId;
  late final ColumnDateTime createdAt;

  @override
  List<Column<dynamic>> get columns => [
        id,
        userId,
        roleId,
        createdAt,
      ];
}
