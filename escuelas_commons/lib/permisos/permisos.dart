// ignore_for_file: public_member_api_docs

import 'package:rolemissions/rolemissions.dart';

enum PermisoDeAsignatura {
  verAsignatura,
  editarAsignatura,
  eliminarAsignatura,
  crearAsignatura,
  asignarDocenteAAsignatura,
}

enum PermisoDeAsistencia {
  verAsistencia,
  editarAsistencia,
  eliminarAsistencia,
  crearAsistencia,
}

enum PermisoDeCalificacion {
  verCalificacion,
  editarCalificacion,
  eliminarCalificacion,
  crearCalificacion,
}

enum PermisoDeComision {
  verComision,
  editarComision,
  eliminarComision,
  crearComision,
  asignarAlumnosAComision,
}

enum PermisoDeCurso {
  verCurso,
  editarCurso,
  eliminarCurso,
  crearCurso,
}

enum PermisoDeRol {
  verRol,
  editarRol,
  eliminarRol,
  crearRol,
}

enum PermisoDeSolicitud {
  verSolicitud,
  editarSolicitud,
  eliminarSolicitud,
  crearSolicitud,
}

enum PermisoDeUsuario {
  verUsuario,
  editarUsuario,
  eliminarUsuario,
  crearUsuario,
  responderSolicitudDeRegistro,
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
