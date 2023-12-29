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
  misCursos,
  inasistencias,
  enviarJustificativo,
  usuariosPendientes,
  calificaciones,
  personal;

  String get titulo {
    switch (this) {
      case InfoDeRol.tomarInasistencia:
        return 'TOMAR INASISTENCIA';
      case InfoDeRol.listaCursos:
        return 'LISTA DE CURSOS';
      case InfoDeRol.inasistencias:
        return 'INASISTENCIAS';
      case InfoDeRol.misCursos:
        return 'MIS CURSOS';
      case InfoDeRol.calificaciones:
        return 'CALIFICACIONES';
      case InfoDeRol.enviarJustificativo:
        return 'ENVIAR JUSTIFICATIVO';
      case InfoDeRol.usuariosPendientes:
        return 'USUARIOS PENDIENTES';
      case InfoDeRol.personal:
        return 'PERSONAL';
    }
  }

  List<Permiso> get permisosAsignados {
    switch (this) {
      case InfoDeRol.tomarInasistencia:
        return [Permiso.directivo, Permiso.profesor];
      case InfoDeRol.listaCursos:
        return [Permiso.directivo, Permiso.profesor];
      case InfoDeRol.inasistencias:
        return [
          Permiso.alumno,
          Permiso.profesor,
          Permiso.directivo,
        ];
      case InfoDeRol.misCursos:
        return [Permiso.profesor];
      case InfoDeRol.enviarJustificativo:
        return [Permiso.alumno];
      case InfoDeRol.usuariosPendientes:
        return [
          Permiso.directivo,
        ];
      case InfoDeRol.calificaciones:
        return [Permiso.alumno];
      case InfoDeRol.personal:
        return [
          Permiso.directivo,
        ];
    }
  }

  /// Redirige al usuario a esa vista
  void redirigirAVista(BuildContext context) {
    switch (this) {
      // TODO(ANYONE): Agregar redirecciones adecuadas
      case InfoDeRol.tomarInasistencia:
        context.router.push(PaginaInicio());
      case InfoDeRol.listaCursos:
        context.router.push(PaginaInicio());
      case InfoDeRol.inasistencias:
        context.router.push(PaginaInicio());
      case InfoDeRol.misCursos:
        context.router.push(PaginaInicio());
      case InfoDeRol.enviarJustificativo:
        context.router.push(PaginaInicio());
      case InfoDeRol.usuariosPendientes:
        context.router.push(PaginaInicio());
      case InfoDeRol.calificaciones:
        context.router.push(PaginaInicio());
      case InfoDeRol.personal:
        context.router.push(PaginaInicio());
    }
  }
}
