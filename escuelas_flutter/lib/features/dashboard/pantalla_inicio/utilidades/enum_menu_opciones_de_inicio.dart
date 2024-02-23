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
  supervisionComision([PermisoDeUsuario.verUsuario]),
  comunicaciones([PermisoDeUsuario.verUsuario]),
  calificacionesAlumno([PermisoDeUsuario.verUsuario]);

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
        context.router.push(const RutaUsuariosPendientes());
      case supervisionComision:
        context.router.push(const RutaSupervisionComisiones());
      case calificacionesAlumno:
        context.router.push(const RutaCalificacionesMensuales());
      case comunicaciones:
        context.router.push(const RutaComunicaciones());
    }
  }

  /// Obtiene el titulo traducido de cada elemento de MenuInicio.
  String getTitulo(BuildContext context) {
    final l10n = context.l10n;

    switch (this) {
      case listaCursos:
        return l10n.routeNameCourses.toUpperCase();
      case comunidadAcademica:
        return l10n.routeNameAcademicCommunity.toUpperCase();
      case tomarInasistencia:
        return l10n.routeNameAbsences.toUpperCase();
      case usuariosPendientes:
        return l10n.routeNamePendingUsers.toUpperCase();
      case supervisionComision:
        return l10n.routeNameCommissionSupervision.toUpperCase();
      case calificacionesAlumno:
        return l10n.pageStudentGradesTitle.toUpperCase();
      case comunicaciones:
        return l10n.pageCommunicationsTitle.toUpperCase();
    }
  }
}
