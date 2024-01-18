// ignore_for_file: public_member_api_docs

import 'package:rolemissions/rolemissions.dart';

class Permisos extends RolemissionPermissions {
  Permisos() : super();

  Permisos.fromSerialization(super.serialization) : super.fromSerialization();

  Permisos.fromEnumList(super.permissions) : super.fromEnumList();

  @override
  List<List<Enum>> get allPermissions => [
        PermisoDeAsistencia.values,
        PermisoDeCalificacion.values,
        PermisoDeCurso.values,
        PermisoDeRol.values,
        PermisoDeUsuario.values,
        PermisoDeComision.values,
        PermisoDeAsignatura.values,
        PermisoDeSolicitud.values,
      ];
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

enum PermisoDeUsuario {
  verUsuario,
  editarUsuario,
  eliminarUsuario,
  crearUsuario,
}

enum PermisoDeComision {
  verComision,
  editarComision,
  eliminarComision,
  crearComision,
}

enum PermisoDeAsignatura {
  verAsignatura,
  editarAsignatura,
  eliminarAsignatura,
  crearAsignatura,
}

enum PermisoDeSolicitud {
  verSolicitud,
  editarSolicitud,
  eliminarSolicitud,
  crearSolicitud,
}
