import 'package:serverpod/serverpod.dart';

extension ColumnIntX on ColumnInt {
  /// Agrega expresión compatible con Serverpod para operador SQL `IN`.
  Expression contains(List<int> values) {
    if (values.isEmpty) {
      return Expression('"$columnName" IS NOT NULL');
    } else {
      final valueList = values.join(',');
      return Expression('"$columnName" IN ($valueList)');
    }
  }
}
