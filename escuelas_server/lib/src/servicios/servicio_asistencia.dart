import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_asistencia.dart';
import 'package:escuelas_server/src/orms/orm_usuario.dart';
import 'package:escuelas_server/src/servicio.dart';
import 'package:escuelas_server/src/servicios/servicio_one_signal.dart';
import 'package:serverpod/serverpod.dart';

class ServicioAsistencia extends Servicio<OrmAsistencia> {
  @override
  OrmAsistencia get orm => OrmAsistencia();

  final _servicioOneSignal = ServicioOneSignal();

  /// Guardar la fecha actual como parámetro para mejor performance
  DateTime ahora = DateTime.now();

  /// La función `crearAsistenciasEnLote` crea múltiples registros de asistencia diaria en un lote.
  /// Y también envía las notificaciones al servicio de notificaciones de las inasistencias
  /// para poder mostrarle a los alumnos la notificación push de su inasistencia.
  ///
  /// Args:
  ///   session (Session):
  ///   asistencias (List<AsistenciaDiaria>): Una lista de objetos del tipo "AsistenciaDiaria".
  Future<List<AsistenciaDiaria>> crearAsistenciasEnLote(
    Session session, {
    required List<AsistenciaDiaria> asistencias,
  }) async {
    ahora = DateTime.now();

    for (var asistencia in asistencias) {
      asistencia.ultimaModificacion = ahora;
      asistencia.fechaCreacion = ahora;
    }

    final asistenciasCreadas = await ejecutarOperacion(
      () => orm.crearAsistenciasEnLote(
        session,
        asistencias: asistencias,
      ),
    );

    final inasistenciasFiltradas =
        asistenciasCreadas.where(_esInasistencia).where(_esDeHoy).toList();

    _servicioOneSignal.enviarNotificacionesDeInasistencia(
      inasistenciasFiltradas,
    );

    return asistenciasCreadas;
  }

  /// La función `traerAsistenciaPorDia` recupera la asistencia de un día en particular.
  /// Args:
  ///  session (Session): Un objeto de tipo "Session" que representa una conexión a una base de datos.
  /// idComision (int): Un número entero que representa el identificador único de la comisión.
  /// fecha (DateTime): Un objeto de tipo "DateTime" que representa la fecha de la asistencia.
  /// Returns:
  ///  El método `traerAsistenciaPorDia` devuelve un `Futuro<List<AsistenciaDiaria>>`.
  Future<List<AsistenciaDiaria>> traerAsistenciaPorDia(
    Session session, {
    required DateTime fecha,
  }) async {
    return await ejecutarOperacion(
      () => orm.traerAsistenciaPorDia(
        session,
        fecha: fecha,
      ),
    );
  }

  /// La función `actualizarAsistenciasEnLote` actualiza múltiples registros de asistencia diaria en un lote.
  /// Args:
  ///  session (Session):
  /// asistencias (List<AsistenciaDiaria>): Una lista de objetos del tipo "AsistenciaDiaria".
  /// Returns:
  /// El método `actualizarAsistenciasEnLote` devuelve un `Futuro<String>`.
  Future<List<AsistenciaDiaria>> actualizarAsistenciasEnLote(
    Session session, {
    required List<AsistenciaDiaria> asistencias,
  }) async {
    ahora = DateTime.now();
    for (var asistencia in asistencias) {
      asistencia.ultimaModificacion = ahora;
    }
    return await ejecutarOperacion(
      () => orm.actualizarAsistenciasEnLote(
        session,
        asistencias: asistencias,
      ),
    );
  }

  Future<double> obtenerCantidadDeInasistenciasDeUsuarioPorMesYAnio(
    Session session, {
    required int mes,
    required int anio,
  }) async {
    final infoUsuario = await OrmUsuario().obtenerInfoBasicaUsuario(
      session,
      idUserInfo: await obtenerIdDeUsuarioLogueado(session),
    );

    double cantidadDeInasistencias = 0;

    final inasistencias = await orm.listarRegistrosEnDbPorFiltro(
      session,
      filtroCondicional: AsistenciaDiaria.t.estadoDeAsistencia
              .notEquals(EstadoDeAsistencia.presente) &
          AsistenciaDiaria.t.estadoDeAsistencia
              .notEquals(EstadoDeAsistencia.sinEstado) &
          AsistenciaDiaria.t.estudianteId.equals(infoUsuario.id) &
          AsistenciaDiaria.t.fecha.between(
            DateTime(anio, mes, 1),
            DateTime(anio, mes + 1, 1).subtract(
              Duration(days: 1),
            ),
          ) &
          AsistenciaDiaria.t.fechaEliminacion.equals(null),
    );

    cantidadDeInasistencias += inasistencias
        .where((element) =>
            element.estadoDeAsistencia == EstadoDeAsistencia.ausente)
        .length;
    cantidadDeInasistencias += ((inasistencias
            .where((element) =>
                element.estadoDeAsistencia ==
                EstadoDeAsistencia.mediaInasistencia)
            .length) /
        2);
    cantidadDeInasistencias += ((inasistencias
            .where((element) =>
                element.estadoDeAsistencia ==
                EstadoDeAsistencia.cuartoDeInasistencia)
            .length) /
        4);

    return cantidadDeInasistencias;
  }

  bool _esDeHoy(AsistenciaDiaria asistencia) {
    return asistencia.fecha.difference(ahora) == const Duration(days: 0);
  }

  /// Filtra y devuelve una lista de AsistenciaDiaria que solo tiene inasistencias
  bool _esInasistencia(
    AsistenciaDiaria asistencia,
  ) {
    /// Estados que solo contienen inasistencia.
    const estadosInasistenciaFiltrados = [
      EstadoDeAsistencia.ausente,
      EstadoDeAsistencia.cuartoDeInasistencia,
      EstadoDeAsistencia.mediaInasistencia,
    ];

    return estadosInasistenciaFiltrados.contains(asistencia.estadoDeAsistencia);
  }
}
