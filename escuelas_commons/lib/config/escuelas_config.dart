import 'package:escuelas_client/escuelas_client.dart';

// TODO(anyone): Antes de produccion chequear las configuraciones de las
// instancias

/// Configuraciones de escuelas
///
/// Esta clase es la encargada de proveer las configuraciones de las instancias.
sealed class ConfigsDeInstancia {
  const ConfigsDeInstancia._();

  int get diasDeAnticipacion => throw UnimplementedError();

  DateTime fechaDeEnvio(DateTime primeroDeMes) =>
      primeroDeMes.subtract(Duration(days: diasDeAnticipacion));

  List<Periodo> periodosDelAnioLectivo(int anio) => throw UnimplementedError();

  /// Obtiene una lista de los meses que pertenecen al mismo periodo que la
  /// fecha pasada como parametro.
  List<int> obtenerListaDeMesesPorPeriodo(DateTime fecha) {
    final periodos = periodosDelAnioLectivo(fecha.year);

    final periodoActual = periodos.firstWhere(
      (periodo) =>
          (fecha.isAfter(periodo.fechaInicio) ||
              fecha.isAtSameMomentAs(fecha)) &&
          fecha.isBefore(periodo.fechaFin),
      orElse: () => throw Exception('No se encontro el periodo'),
    );

    final meses = <int>[];

    for (var i = periodoActual.fechaInicio.month;
        i <= periodoActual.fechaFin.month;
        i++) {
      meses.add(i);
    }

    return meses.where((mes) => mes <= fecha.month).toList();
  }
}

/// Configuraciones para la escuela Redemptoris Missio
final class RedemptorisMissioConfigs extends ConfigsDeInstancia {
  ///
  const RedemptorisMissioConfigs() : super._();

  @override
  int get diasDeAnticipacion => 5;

  @override
  DateTime fechaDeEnvio(DateTime primeroDeMes) =>
      primeroDeMes.subtract(Duration(days: diasDeAnticipacion));

  @override
  List<Periodo> periodosDelAnioLectivo(int anio) {
    return [
      // TODO(anyone): REMOVER ANTES DE PRODUCCION
      Periodo(
        fechaInicio: DateTime(anio),
        fechaFin: DateTime(anio, 3).subtract(const Duration(days: 1)),
      ),
      Periodo(
        fechaInicio: DateTime(anio, 3),
        fechaFin: DateTime(anio, 7).subtract(const Duration(days: 1)),
      ),
      Periodo(
        fechaInicio: DateTime(anio, 7),
        fechaFin: DateTime(anio, 10).subtract(const Duration(days: 1)),
      ),
      Periodo(
        fechaInicio: DateTime(anio, 10),
        fechaFin: DateTime(anio + 1).subtract(const Duration(days: 1)),
      ),
    ];
  }
}
