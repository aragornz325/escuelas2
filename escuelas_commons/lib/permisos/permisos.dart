// ignore_for_file: public_member_api_docs

import 'package:rolemissions/rolemissions.dart';

enum PermisoDeAsignatura {
  verAsignatura,
  editarAsignatura,
  eliminarAsignatura,
  crearAsignatura,
  asignarDocenteAAsignatura,
  accesoPublico,
}

enum PermisoDeAsistencia {
  verAsistencia,
  editarAsistencia,
  eliminarAsistencia,
  crearAsistencia,
  accesoPublico,
}

enum PermisoDeCalificacion {
  verCalificacion,
  editarCalificacion,
  eliminarCalificacion,
  crearCalificacion,
  accesoPublico,
}

enum PermisoDeComision {
  verComision,
  editarComision,
  eliminarComision,
  crearComision,
  asignarAlumnosAComision,
  accesoPublico,
}

enum PermisoDeCurso {
  verCurso,
  editarCurso,
  eliminarCurso,
  crearCurso,
  accesoPublico,
}

enum PermisoDeRol {
  verRol,
  editarRol,
  eliminarRol,
  crearRol,
  accesoPublico,
}

enum PermisoDeSolicitud {
  verSolicitud,
  editarSolicitud,
  eliminarSolicitud,
  crearSolicitud,
  accesoPublico,
}

enum PermisoDeUsuario {
  verUsuario,
  editarUsuario,
  eliminarUsuario,
  crearUsuario,
  responderSolicitudDeRegistro,
  cambiarPasswordDeUsuarioDirectivo,
  accesoPublico,
}

/// Los permisos sirven para controlar el acceso a los recursos
///  de la aplicación.
///
/// Los permisos se pueden asignar a los usuarios a través de
/// los roles o de los privilegios.
class Permisos extends RolemissionPermissions {
  Permisos.fromEnumList(super.permissions) : super.fromEnumList();

  Permisos.fromSerialization(super.serialization) : super.fromSerialization();

  @override
  List<List<Enum>> get allPermissions => [
        PermisoDeAsignatura.values,
        PermisoDeAsistencia.values,
        PermisoDeCalificacion.values,
        PermisoDeComision.values,
        PermisoDeCurso.values,
        PermisoDeRol.values,
        PermisoDeSolicitud.values,
        PermisoDeUsuario.values,
      ];
}
