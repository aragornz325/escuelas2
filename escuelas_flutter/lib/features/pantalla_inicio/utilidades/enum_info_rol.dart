import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/features/pantalla_inicio/bloc/bloc_inicio.dart';
import 'package:flutter/material.dart';

/// Distintas etiquetas que tienen un titulo, permisos asignados
/// y una funcion de redireccion. Que se usan para dibujar en la UI y que el
/// usuario pueda seleccionar entre ellas para navegar.
enum InfoDeRol {
  tomarInasistencia,
  listaCursos,
  usuariosPendientes,
  personal,
  supervision,
  kyc;

// TODO(Anyone): Ver si es inasistencias o asistencias.
  // TODO(SAM): add funcion y pasarle context
  String get titulo {
    switch (this) {
      // TODO(Anyone): Cuando esten definidos los roles decidir si va Mis Cursos
      // o Lista de Cursos segun el rol
      case InfoDeRol.listaCursos:
        return 'LISTA DE CURSOS';
      case InfoDeRol.personal:
        return 'PERSONAL';
      case InfoDeRol.tomarInasistencia:
        return 'TOMAR INASISTENCIA';
      case InfoDeRol.usuariosPendientes:
        return 'USUARIOS PENDIENTES';
      case InfoDeRol.supervision:
        return 'SUPERVISION DE CURSOS';
      case InfoDeRol.kyc:
        return 'KYC';
    }
  }

  List<Permiso> get permisosAsignados {
    switch (this) {
      case InfoDeRol.tomarInasistencia:
        return [Permiso.directivo, Permiso.docente];
      case InfoDeRol.listaCursos:
        return [Permiso.directivo, Permiso.docente];
      case InfoDeRol.personal:
        return [
          Permiso.directivo,
        ];
      case InfoDeRol.usuariosPendientes:
        return [
          Permiso.directivo,
        ];
      case InfoDeRol.supervision:
        return [
          Permiso.directivo,
        ];
      case InfoDeRol.kyc:
        return [
          Permiso.directivo,
          Permiso.alumno,
        ];
    }
  }

  /// Redirige al usuario a esa vista
  void redirigirAVista(BuildContext context) {
    switch (this) {
      // TODO(ANYONE): Agregar redirecciones adecuadas
      case InfoDeRol.listaCursos:
        context.router.push(const RutaMisCursos());
      case InfoDeRol.personal:
        context.router.push(RutaInicio());
      case InfoDeRol.tomarInasistencia:
        context.router.push(const RutaInasistencia());
      case InfoDeRol.usuariosPendientes:
        context.router.push(const RutaAsignacionDeRoles());
      case InfoDeRol.supervision:
        context.router.push(const RutaSupervisionCursos());
      case InfoDeRol.kyc:
        context.router.push(const RutaKyc());
    }
  }
}
