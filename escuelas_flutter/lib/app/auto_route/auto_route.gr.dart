// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:escuelas_flutter/features/asistencias/pagina_asistencias.dart'
    as _i4;
import 'package:escuelas_flutter/features/auth/asignacion_de_roles/pagina_asignacion_de_roles.dart'
    as _i1;
import 'package:escuelas_flutter/features/auth/kyc/formulario/pagina_formulario.dart'
    as _i3;
import 'package:escuelas_flutter/features/auth/kyc/pagina_kyc.dart' as _i6;
import 'package:escuelas_flutter/features/auth/kyc/seleccion_de_roles/pagina_seleccion_de_rol.dart'
    as _i10;
import 'package:escuelas_flutter/features/auth/login/pagina_login.dart' as _i7;
import 'package:escuelas_flutter/features/dashboard/pagina_dashboard.dart'
    as _i2;
import 'package:escuelas_flutter/features/mis_cursos/pagina_mis_cursos.dart'
    as _i8;
import 'package:escuelas_flutter/features/pantalla_inicio/bloc/bloc_inicio.dart'
    as _i13;
import 'package:escuelas_flutter/features/pantalla_inicio/pagina_inicio.dart'
    as _i5;
import 'package:escuelas_flutter/features/perfil_usuario/pagina_perfil_usuario.dart'
    as _i9;
import 'package:flutter/material.dart' as _i12;

abstract class $AppRouter extends _i11.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    RutaAsignacionDeRoles.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.PaginaAsignacionDeRoles(),
      );
    },
    RutaDashboard.name: (routeData) {
      final args = routeData.argsAs<RutaDashboardArgs>(
          orElse: () => const RutaDashboardArgs());
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.PaginaDashboard(
          key: args.key,
          userInfo: args.userInfo,
        ),
      );
    },
    RutaFormulario.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.PaginaFormulario(),
      );
    },
    RutaInasistencia.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.PaginaInasistencia(),
      );
    },
    RutaInicio.name: (routeData) {
      final args = routeData.argsAs<RutaInicioArgs>(
          orElse: () => const RutaInicioArgs());
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.PaginaInicio(
          key: args.key,
          userInfo: args.userInfo,
        ),
      );
    },
    RutaKyc.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.PaginaKyc(),
      );
    },
    RutaLogin.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.PaginaLogin(),
      );
    },
    RutaMisCursos.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.PaginaMisCursos(),
      );
    },
    RutaPerfilUsuario.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RutaPerfilUsuarioArgs>(
          orElse: () =>
              RutaPerfilUsuarioArgs(idUsuario: pathParams.getInt('idUsuario')));
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.PaginaPerfilUsuario(
          idUsuario: args.idUsuario,
          key: args.key,
        ),
      );
    },
    RutaSeleccionDeRol.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.PaginaSeleccionDeRol(),
      );
    },
  };
}

/// generated route for
/// [_i1.PaginaAsignacionDeRoles]
class RutaAsignacionDeRoles extends _i11.PageRouteInfo<void> {
  const RutaAsignacionDeRoles({List<_i11.PageRouteInfo>? children})
      : super(
          RutaAsignacionDeRoles.name,
          initialChildren: children,
        );

  static const String name = 'RutaAsignacionDeRoles';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i2.PaginaDashboard]
class RutaDashboard extends _i11.PageRouteInfo<RutaDashboardArgs> {
  RutaDashboard({
    _i12.Key? key,
    _i13.InfoUsuario? userInfo,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          RutaDashboard.name,
          args: RutaDashboardArgs(
            key: key,
            userInfo: userInfo,
          ),
          initialChildren: children,
        );

  static const String name = 'RutaDashboard';

  static const _i11.PageInfo<RutaDashboardArgs> page =
      _i11.PageInfo<RutaDashboardArgs>(name);
}

class RutaDashboardArgs {
  const RutaDashboardArgs({
    this.key,
    this.userInfo,
  });

  final _i12.Key? key;

  final _i13.InfoUsuario? userInfo;

  @override
  String toString() {
    return 'RutaDashboardArgs{key: $key, userInfo: $userInfo}';
  }
}

/// generated route for
/// [_i3.PaginaFormulario]
class RutaFormulario extends _i11.PageRouteInfo<void> {
  const RutaFormulario({List<_i11.PageRouteInfo>? children})
      : super(
          RutaFormulario.name,
          initialChildren: children,
        );

  static const String name = 'RutaFormulario';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i4.PaginaInasistencia]
class RutaInasistencia extends _i11.PageRouteInfo<void> {
  const RutaInasistencia({List<_i11.PageRouteInfo>? children})
      : super(
          RutaInasistencia.name,
          initialChildren: children,
        );

  static const String name = 'RutaInasistencia';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i5.PaginaInicio]
class RutaInicio extends _i11.PageRouteInfo<RutaInicioArgs> {
  RutaInicio({
    _i12.Key? key,
    _i13.InfoUsuario? userInfo,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          RutaInicio.name,
          args: RutaInicioArgs(
            key: key,
            userInfo: userInfo,
          ),
          initialChildren: children,
        );

  static const String name = 'RutaInicio';

  static const _i11.PageInfo<RutaInicioArgs> page =
      _i11.PageInfo<RutaInicioArgs>(name);
}

class RutaInicioArgs {
  const RutaInicioArgs({
    this.key,
    this.userInfo,
  });

  final _i12.Key? key;

  final _i13.InfoUsuario? userInfo;

  @override
  String toString() {
    return 'RutaInicioArgs{key: $key, userInfo: $userInfo}';
  }
}

/// generated route for
/// [_i6.PaginaKyc]
class RutaKyc extends _i11.PageRouteInfo<void> {
  const RutaKyc({List<_i11.PageRouteInfo>? children})
      : super(
          RutaKyc.name,
          initialChildren: children,
        );

  static const String name = 'RutaKyc';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i7.PaginaLogin]
class RutaLogin extends _i11.PageRouteInfo<void> {
  const RutaLogin({List<_i11.PageRouteInfo>? children})
      : super(
          RutaLogin.name,
          initialChildren: children,
        );

  static const String name = 'RutaLogin';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i8.PaginaMisCursos]
class RutaMisCursos extends _i11.PageRouteInfo<void> {
  const RutaMisCursos({List<_i11.PageRouteInfo>? children})
      : super(
          RutaMisCursos.name,
          initialChildren: children,
        );

  static const String name = 'RutaMisCursos';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i9.PaginaPerfilUsuario]
class RutaPerfilUsuario extends _i11.PageRouteInfo<RutaPerfilUsuarioArgs> {
  RutaPerfilUsuario({
    required int idUsuario,
    _i12.Key? key,
    List<_i11.PageRouteInfo>? children,
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

  static const _i11.PageInfo<RutaPerfilUsuarioArgs> page =
      _i11.PageInfo<RutaPerfilUsuarioArgs>(name);
}

class RutaPerfilUsuarioArgs {
  const RutaPerfilUsuarioArgs({
    required this.idUsuario,
    this.key,
  });

  final int idUsuario;

  final _i12.Key? key;

  @override
  String toString() {
    return 'RutaPerfilUsuarioArgs{idUsuario: $idUsuario, key: $key}';
  }
}

/// generated route for
/// [_i10.PaginaSeleccionDeRol]
class RutaSeleccionDeRol extends _i11.PageRouteInfo<void> {
  const RutaSeleccionDeRol({List<_i11.PageRouteInfo>? children})
      : super(
          RutaSeleccionDeRol.name,
          initialChildren: children,
        );

  static const String name = 'RutaSeleccionDeRol';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}
