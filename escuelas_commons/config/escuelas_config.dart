import 'package:escuelas_client/src/protocol/periodo.dart';

import 'configs_de_escuelas.dart';

// TODO(anyone): Antes de produccion chequear las configuraciones de las
// instancias

/// Configuraciones para la escuela Redemptoris Missio
class RedemptorisMissioConfigs extends ConfigsDeInstancia {
  @override
  int get diasDeAnticipacion => 5;

  @override
  DateTime fechaDeEnvio(DateTime primeroDeMes) =>
      primeroDeMes.subtract(Duration(days: diasDeAnticipacion));

  @override
  List<Periodo> periodosDelAnioLectivo(int anio) {
    return [
      Periodo(
        fechaInicio: DateTime(anio, 3),
        fechaFin: DateTime(anio, 3, 31),
        ultimaModificacion: DateTime.now(),
        fechaCreacion: DateTime.now(),
      ),
      Periodo(
        fechaInicio: DateTime(anio, 4),
        fechaFin: DateTime(anio, 4, 30),
        ultimaModificacion: DateTime.now(),
        fechaCreacion: DateTime.now(),
      ),
      Periodo(
        fechaInicio: DateTime(anio, 5),
        fechaFin: DateTime(anio, 5, 31),
        ultimaModificacion: DateTime.now(),
        fechaCreacion: DateTime.now(),
      ),
      Periodo(
        fechaInicio: DateTime(anio, 6),
        fechaFin: DateTime(anio, 6, 30),
        ultimaModificacion: DateTime.now(),
        fechaCreacion: DateTime.now(),
      ),
      Periodo(
        fechaInicio: DateTime(anio, 7),
        fechaFin: DateTime(anio, 7, 31),
        ultimaModificacion: DateTime.now(),
        fechaCreacion: DateTime.now(),
      ),
      Periodo(
        fechaInicio: DateTime(anio, 8),
        fechaFin: DateTime(anio, 8, 31),
        ultimaModificacion: DateTime.now(),
        fechaCreacion: DateTime.now(),
      ),
      Periodo(
        fechaInicio: DateTime(anio, 9),
        fechaFin: DateTime(anio, 9, 30),
        ultimaModificacion: DateTime.now(),
        fechaCreacion: DateTime.now(),
      ),
      Periodo(
        fechaInicio: DateTime(anio, 10),
        fechaFin: DateTime(anio, 10, 31),
        ultimaModificacion: DateTime.now(),
        fechaCreacion: DateTime.now(),
      ),
      Periodo(
        fechaInicio: DateTime(anio, 11),
        fechaFin: DateTime(anio, 11, 30),
        ultimaModificacion: DateTime.now(),
        fechaCreacion: DateTime.now(),
      ),
      Periodo(
        fechaInicio: DateTime(anio, 12),
        fechaFin: DateTime(anio + 1),
        ultimaModificacion: DateTime.now(),
        fechaCreacion: DateTime.now(),
      ),
    ];
  }
}
