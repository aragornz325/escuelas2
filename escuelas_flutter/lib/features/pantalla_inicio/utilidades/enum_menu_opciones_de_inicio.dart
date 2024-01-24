import 'package:auto_route/auto_route.dart';
import 'package:escuelas_commons/permisos/permisos.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';

/// Menu donde se encuentran las vistas a redirigir que cada una requiere
/// permisos especificos del usuario para que las pueda ver.
enum MenuOpcionesDeInicio {
  tomarInasistencia([PermisoDeAsistencia.verAsistencia]),
  listaCursos([PermisoDeCurso.verCurso]),
  usuariosPendientes([PermisoDeUsuario.verUsuario]),
  comunidadAcademica([PermisoDeUsuario.verUsuario]),
  supervision([PermisoDeComision.verComision]);

  const MenuOpcionesDeInicio(this.permisosRequeridos);
  
  final List<Enum> permisosRequeridos;

  /// Redirige al usuario a esa vista
  void redirigirAVista(BuildContext context) {
    switch (this) {
      case listaCursos:
        context.router.push(const RutaMisCursos());
      case comunidadAcademica:
        context.router.push(const RutaComunidadAcademica());
      case tomarInasistencia:
        context.router.push(const RutaInasistencia());
      case usuariosPendientes:
        context.router.push(const RutaAsignacionDeRoles());
      case supervision:
        context.router.push(const RutaSupervisionCursos());
    }
  }

  /// Obtiene el titulo traducido de cada elemento de MenuInicio.
  String getTitulo(BuildContext context) {
    final l10n = context.l10n;

    switch (this) {
      // TODO(Anyone): Ver si falta alguno
      case listaCursos:
        return l10n.commonCoursesList.toUpperCase();
      case comunidadAcademica:
        return l10n.commonAcademicCommunity.toUpperCase();
      case tomarInasistencia:
        return l10n.commonRecordAbsences.toUpperCase();
      case usuariosPendientes:
        return l10n.commonPendingUsers.toUpperCase();
      case supervision:
        return l10n.commonCoursesSupervision.toUpperCase();
    }
  }
}
