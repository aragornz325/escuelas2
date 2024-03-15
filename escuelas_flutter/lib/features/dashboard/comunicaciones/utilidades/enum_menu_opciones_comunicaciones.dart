import 'package:auto_route/auto_route.dart';
import 'package:escuelas_commons/permisos/permisos.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';

/// Menu donde se encuentran las vistas a redirigir dentro de la pagina
/// Comunicaciones que cada una requiere permisos especificos
/// del usuario para que las pueda ver.

enum MenuOpcionesComunicaciones {
  // TODO(ANYONE): Ajustar permisos cuando este, probablemente seria Directivo.
  comunicacionesPendientes([PermisoDeUsuario.verUsuario]),
  comunicacionesGeneral([PermisoDeUsuario.verUsuario]),
  comunicacionesCursos([PermisoDeUsuario.verUsuario]);

  const MenuOpcionesComunicaciones(this.permisosRequeridos);

  final List<Enum> permisosRequeridos;

  /// Redirige al usuario a esa vista
  void redirigirAVista(BuildContext context) {
    switch (this) {
      case comunicacionesPendientes:
        context.router.push(const RutaComunicacionesPendientes());
      case comunicacionesGeneral:
        context.router.push(const RutaComunicacionesGeneral());
      case comunicacionesCursos:
        context.router.push(const RutaComunicacionesCursos());
    }
  }

  /// Obtiene el titulo traducido de cada elemento de
  ///  MenuOpcionesComunicaciones
  String getTitulo(BuildContext context) {
    final l10n = context.l10n;

    switch (this) {
      case comunicacionesPendientes:
        return l10n.routeNamePendingCommunications.toUpperCase();
      case comunicacionesGeneral:
        return l10n.routeNameGeneralCommunications.toUpperCase();
      case comunicacionesCursos:
        return l10n.routeNameCourseCommunications.toUpperCase();
    }
  }
}
