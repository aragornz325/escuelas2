// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:escuelas_flutter/features/asistencias/pagina_asistencias.dart'
    as _i5;
import 'package:escuelas_flutter/features/auth/asignacion_de_roles/pagina_asignacion_de_roles.dart'
    as _i1;
import 'package:escuelas_flutter/features/auth/kyc/formulario/pagina_formulario.dart'
    as _i4;
import 'package:escuelas_flutter/features/auth/kyc/pagina_kyc.dart' as _i7;
import 'package:escuelas_flutter/features/auth/kyc/seleccion_de_roles/pagina_seleccion_de_rol.dart'
    as _i12;
import 'package:escuelas_flutter/features/auth/login/pagina_login.dart' as _i9;
import 'package:escuelas_flutter/features/carga_calificaciones/pagina_carga_calificaciones.dart'
    as _i2;
import 'package:escuelas_flutter/features/dashboard/pagina_dashboard.dart'
    as _i3;
import 'package:escuelas_flutter/features/lista_cursos/lista_cursos.dart'
    as _i8;
import 'package:escuelas_flutter/features/mis_cursos/pagina_mis_cursos.dart'
    as _i10;
import 'package:escuelas_flutter/features/pantalla_inicio/bloc/bloc_inicio.dart'
    as _i15;
import 'package:escuelas_flutter/features/pantalla_inicio/pagina_inicio.dart'
    as _i6;
import 'package:escuelas_flutter/features/perfil_usuario/pagina_perfil_usuario.dart'
    as _i11;
import 'package:flutter/material.dart' as _i14;

abstract class $AppRouter extends _i13.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i13.PageFactory> pagesMap = {
    RutaAsignacionDeRoles.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.PaginaAsignacionDeRoles(),
      );
    },
    RutaCargaDeCalificaciones.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.PaginaCargaDeCalificaciones(),
      );
    },
    RutaDashboard.name: (routeData) {
      final args = routeData.argsAs<RutaDashboardArgs>(
          orElse: () => const RutaDashboardArgs());
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.PaginaDashboard(
          key: args.key,
          userInfo: args.userInfo,
        ),
      );
    },
    RutaFormulario.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.PaginaFormulario(),
      );
    },
    RutaInasistencia.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.PaginaInasistencia(),
      );
    },
    RutaInicio.name: (routeData) {
      final args = routeData.argsAs<RutaInicioArgs>(
          orElse: () => const RutaInicioArgs());
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.PaginaInicio(
          key: args.key,
          userInfo: args.userInfo,
        ),
      );
    },
    RutaKyc.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.PaginaKyc(),
      );
    },
    RutaListaCursos.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.PaginaListaCursos(),
      );
    },
    RutaLogin.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.PaginaLogin(),
      );
    },
    RutaMisCursos.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.PaginaMisCursos(),
      );
    },
    RutaPerfilUsuario.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RutaPerfilUsuarioArgs>(
          orElse: () =>
              RutaPerfilUsuarioArgs(idUsuario: pathParams.getInt('idUsuario')));
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.PaginaPerfilUsuario(
          idUsuario: args.idUsuario,
          key: args.key,
        ),
      );
    },
    RutaSeleccionDeRol.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.PaginaSeleccionDeRol(),
      );
    },
  };
}

/// generated route for
/// [_i1.PaginaAsignacionDeRoles]
class RutaAsignacionDeRoles extends _i13.PageRouteInfo<void> {
  const RutaAsignacionDeRoles({List<_i13.PageRouteInfo>? children})
      : super(
          RutaAsignacionDeRoles.name,
          initialChildren: children,
        );

  static const String name = 'RutaAsignacionDeRoles';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i2.PaginaCargaDeCalificaciones]
class RutaCargaDeCalificaciones extends _i13.PageRouteInfo<void> {
  const RutaCargaDeCalificaciones({List<_i13.PageRouteInfo>? children})
      : super(
          RutaCargaDeCalificaciones.name,
          initialChildren: children,
        );

  static const String name = 'RutaCargaDeCalificaciones';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i3.PaginaDashboard]
class RutaDashboard extends _i13.PageRouteInfo<RutaDashboardArgs> {
  RutaDashboard({
    _i14.Key? key,
    _i15.InfoUsuario? userInfo,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          RutaDashboard.name,
          args: RutaDashboardArgs(
            key: key,
            userInfo: userInfo,
          ),
          initialChildren: children,
        );

  static const String name = 'RutaDashboard';

  static const _i13.PageInfo<RutaDashboardArgs> page =
      _i13.PageInfo<RutaDashboardArgs>(name);
}

class RutaDashboardArgs {
  const RutaDashboardArgs({
    this.key,
    this.userInfo,
  });

  final _i14.Key? key;

  final _i15.InfoUsuario? userInfo;

  @override
  String toString() {
    return 'RutaDashboardArgs{key: $key, userInfo: $userInfo}';
  }
}

/// generated route for
/// [_i4.PaginaFormulario]
class RutaFormulario extends _i13.PageRouteInfo<void> {
  const RutaFormulario({List<_i13.PageRouteInfo>? children})
      : super(
          RutaFormulario.name,
          initialChildren: children,
        );

  static const String name = 'RutaFormulario';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i5.PaginaInasistencia]
class RutaInasistencia extends _i13.PageRouteInfo<void> {
  const RutaInasistencia({List<_i13.PageRouteInfo>? children})
      : super(
          RutaInasistencia.name,
          initialChildren: children,
        );

  static const String name = 'RutaInasistencia';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i6.PaginaInicio]
class RutaInicio extends _i13.PageRouteInfo<RutaInicioArgs> {
  RutaInicio({
    _i14.Key? key,
    _i15.InfoUsuario? userInfo,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          RutaInicio.name,
          args: RutaInicioArgs(
            key: key,
            userInfo: userInfo,
          ),
          initialChildren: children,
        );

  static const String name = 'RutaInicio';

  static const _i13.PageInfo<RutaInicioArgs> page =
      _i13.PageInfo<RutaInicioArgs>(name);
}

class RutaInicioArgs {
  const RutaInicioArgs({
    this.key,
    this.userInfo,
  });

  final _i14.Key? key;

  final _i15.InfoUsuario? userInfo;

  @override
  String toString() {
    return 'RutaInicioArgs{key: $key, userInfo: $userInfo}';
  }
}

/// generated route for
/// [_i7.PaginaKyc]
class RutaKyc extends _i13.PageRouteInfo<void> {
  const RutaKyc({List<_i13.PageRouteInfo>? children})
      : super(
          RutaKyc.name,
          initialChildren: children,
        );

  static const String name = 'RutaKyc';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i8.PaginaListaCursos]
class RutaListaCursos extends _i13.PageRouteInfo<void> {
  const RutaListaCursos({List<_i13.PageRouteInfo>? children})
      : super(
          RutaListaCursos.name,
          initialChildren: children,
        );

  static const String name = 'RutaListaCursos';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i9.PaginaLogin]
class RutaLogin extends _i13.PageRouteInfo<void> {
  const RutaLogin({List<_i13.PageRouteInfo>? children})
      : super(
          RutaLogin.name,
          initialChildren: children,
        );

  static const String name = 'RutaLogin';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i10.PaginaMisCursos]
class RutaMisCursos extends _i13.PageRouteInfo<void> {
  const RutaMisCursos({List<_i13.PageRouteInfo>? children})
      : super(
          RutaMisCursos.name,
          initialChildren: children,
        );

  static const String name = 'RutaMisCursos';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i11.PaginaPerfilUsuario]
class RutaPerfilUsuario extends _i13.PageRouteInfo<RutaPerfilUsuarioArgs> {
  RutaPerfilUsuario({
    required int idUsuario,
    _i14.Key? key,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          RutaPerfilUsuario.name,
          args: RutaPerfilUsuarioArgs(
            idUsuario: idUsuario,
            key: key,
          ),
          rawPathParams: {'idUsuario': idUsuario},
          initialChildren: children,
        );

  static const String name = 'RutaPerfilUsuario';

  static const _i13.PageInfo<RutaPerfilUsuarioArgs> page =
      _i13.PageInfo<RutaPerfilUsuarioArgs>(name);
}

class RutaPerfilUsuarioArgs {
  const RutaPerfilUsuarioArgs({
    required this.idUsuario,
    this.key,
  });

  final int idUsuario;

  final _i14.Key? key;

  @override
  String toString() {
    return 'RutaPerfilUsuarioArgs{idUsuario: $idUsuario, key: $key}';
  }
}

/// generated route for
/// [_i12.PaginaSeleccionDeRol]
class RutaSeleccionDeRol extends _i13.PageRouteInfo<void> {
  const RutaSeleccionDeRol({List<_i13.PageRouteInfo>? children})
      : super(
          RutaSeleccionDeRol.name,
          initialChildren: children,
        );

  static const String name = 'RutaSeleccionDeRol';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}
