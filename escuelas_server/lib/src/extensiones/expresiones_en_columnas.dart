import 'package:serverpod/serverpod.dart';

extension ColumnIntX on ColumnInt {
  /// Agrega expresión compatible con Serverpod para operador SQL `IN`.
  Expression contains(List<int> values, String tableName) {
    if (values.isEmpty) {
      return Expression('"$tableName"."$columnName" IS NOT NULL');
    } else {
      final valueList = values.join(',');
      return Expression('"$tableName"."$columnName" IN ($valueList)');
    }
  }
}
