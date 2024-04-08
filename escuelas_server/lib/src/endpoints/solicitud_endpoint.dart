import 'package:escuelas_commons/escuelas_commons.dart';
import 'package:escuelas_server/src/controller.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/servicios/servicio_solicitud.dart';
import 'package:serverpod/serverpod.dart';

//TODO(Juanjo): asegurate q exista esta funcionalidad:

// !!! YA! corregir el metodo para q siempre sea upsert, nunca insert

// getSolicitudesPendientes(Usuario usuario) que se usa para ver desde el ppio del flujo las cosas q
// tiene pendientes el usuairo logueado (para ponerlo en la campanita, x ejemplo)
// funcionamiento: select * from solicitudes where fechaRealizacion is null and idUsuario = usuario.id

// NUNCA algo genérico tipo:
// ! ~crearSolicitud(Usuario usuario, Solicitud solicitud)~
// * crearSolicitudDeNotaMensual(Usuario usuario, SolicitudNotaMensual solicitudNotaMensual)

// despueeeesss... algo q limpie solicitudes viejas, q no se necesiten mas, q no se hayan realizado, etc

class SolicitudEndpoint extends Endpoint with Controller<ServicioSolicitud> {
  @override
  ServicioSolicitud get servicio => ServicioSolicitud();

  /// la funcion `crearSolicitud` crea un registro de solicitud en una base de datos y devuelve el
  /// registro creado.
  Future<Solicitud> crearSolicitud(
    Session session,
    Solicitud solicitud,
  ) async =>
      await ejecutarOperacionControlador(
        session,
        'crearSolicitud',
        () => servicio.crearSolicitud(
          session,
          solicitud: solicitud,
        ),
        permisoRequerido: PermisoDeSolicitud.crearSolicitud,
      );

  /// la funcion `actualizarSolicitud` actualiza un registro de solicitud en una base de datos y
  /// devuelve el registro actualizado.
  Future<Solicitud> actualizarSolicitud(
    Session session,
    Solicitud solicitud,
  ) async =>
      await ejecutarOperacionControlador(
        session,
        'actualizarSolicitud',
        () => servicio.actualizarSolicitud(
          session,
          solicitud: solicitud,
        ),
        permisoRequerido: PermisoDeSolicitud.editarSolicitud,
      );

  /// la funcion `obtenerSolicitudes` recupera una lista de solicitudes utilizando un objeto de sesión.
  /// Args:
  /// Session:
  Future<List<Solicitud>> obtenerSolicitudes(
    Session session,
  ) async =>
      await ejecutarOperacionControlador(
        session,
        'obtenerSolicitudes',
        () => servicio.obtenerSolicitudes(
          session,
        ),
        permisoRequerido: PermisoDeSolicitud.verSolicitud,
      );

  /// la funcion `obtenerSolicitudPorId` obtiene un registro de solicitud en una base de datos y
  /// devuelve el registro.
  /// Args:
  /// Session:
  /// id:
  Future<Solicitud> obtenerSolicitud(
    Session session,
    int id,
  ) async =>
      await ejecutarOperacionControlador(
        session,
        'obtenerSolicitud',
        () => servicio.obtenerSolicitudPorId(
          session,
          id: id,
        ),
        permisoRequerido: PermisoDeSolicitud.verSolicitud,
      );

  ///la funcion `obtenerSolicitudes` recupera una lista de solicitudes utilizando un objeto de sesión.
  /// Args:
  /// Session:
  Future<List<Solicitud>> obtenerSolicitudesPorIdUsuario(
    Session session,
    int idUsuario,
  ) async =>
      await ejecutarOperacionControlador(
        session,
        'obtenerSolicitudesPorIdUsuario',
        () => servicio.obtenerSolicitudes(
          session,
        ),
        permisoRequerido: PermisoDeSolicitud.verSolicitud,
      );

  /// la funcion `eliminarSolicitud` elimina un registro de solicitud de una base de datos utilizando
  /// un objeto de sesión y un parámetro `id`.
  /// Args:
  /// Session:
  /// id:
  /// Returns:
  /// un `Future<int>`.
  Future<int> eliminarSolicitud(
    Session session,
    int id,
  ) async =>
      await ejecutarOperacionControlador(
        session,
        'eliminarSolicitud',
        () => servicio.eliminarSolicitud(
          session,
          id: id,
        ),
        permisoRequerido: PermisoDeSolicitud.eliminarSolicitud,
      );

  Future<List<Solicitud>> obtenerSolicitudesPendientes(
    Session session,
  ) async =>
      ejecutarOperacionControlador(
        session,
        'obtenerSolicitudesPendientes',
        () => servicio.obtenerSolicitudesPendientes(session),
        permisoRequerido: PermisoDeSolicitud.verSolicitud,
      );

  Future<List<SolicitudCalificacionMensual>>
      obtenerSolicitudesCalificacionMensual(
    Session session, {
    required int numeroDeMes,
  }) async =>
          ejecutarOperacionControlador(
            session,
            'obtenerSolicitudesCalificacionMensual',
            () => servicio.obtenerSolicitudesCalificacionMensual(
              session,
              numeroDeMes: numeroDeMes,
            ),
            permisoRequerido: PermisoDeSolicitud.verSolicitud,
          );
}
