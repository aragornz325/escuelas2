import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:flutter/material.dart';

// TODO(ANYONE): Reemplazar por el nuevo sistema de roles

/// Distintas etiquetas que tienen un titulo, permisos asignados
/// y una funcion de redireccion. Que se usan para dibujar en la UI y que el
/// usuario pueda seleccionar entre ellas para navegar.
enum InfoDeRol {
  tomarInasistencia,
  listaCursos,
  usuariosPendientes,
  comunidadAcademica,
  supervision;

// TODO(Anyone): Ver si es inasistencias o asistencias.
  // TODO(Anyone): add funcion y pasarle context
  String get titulo {
    switch (this) {
      // TODO(Anyone): Cuando esten definidos los roles decidir si va Mis Cursos
      // o Lista de Cursos segun el rol
      case InfoDeRol.listaCursos:
        return 'LISTA DE CURSOS';
      case InfoDeRol.comunidadAcademica:
        return 'COMUNIDAD ACADEMICA';
      case InfoDeRol.tomarInasistencia:
        return 'TOMAR INASISTENCIA';
      case InfoDeRol.usuariosPendientes:
        return 'USUARIOS PENDIENTES';
      case InfoDeRol.supervision:
        return 'SUPERVISION DE CURSOS';
    }
  }

// TODO(anyone): Aca se ponen las ids de los roles que tienen acceso a esa vista
  List<int> get rolesAsignados {
    switch (this) {
      case InfoDeRol.tomarInasistencia:
        return [1, 2, 8];
      case InfoDeRol.listaCursos:
        return [1, 2, 8];
      case InfoDeRol.comunidadAcademica:
        return [1, 2, 8];
      case InfoDeRol.usuariosPendientes:
        return [1, 2, 8];
      case InfoDeRol.supervision:
        // TODO(ANYONE): para la entrega del MVP no es necesario 11/1/2024
        return [1, 2, 8];
    }
  }

  /// Redirige al usuario a esa vista
  void redirigirAVista(BuildContext context) {
    switch (this) {
      // TODO(ANYONE): Agregar redireccion de compensaciones
      case InfoDeRol.listaCursos:
        context.router.push(const RutaMisCursos());
      case InfoDeRol.comunidadAcademica:
        context.router.push(const RutaComunidadAcademica());
      case InfoDeRol.tomarInasistencia:
        context.router.push(const RutaInasistencia());
      case InfoDeRol.usuariosPendientes:
        context.router.push(const RutaAsignacionDeRoles());
      case InfoDeRol.supervision:
        context.router.push(const RutaSupervisionCursos());
    }
  }
}
