// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:escuelas_flutter/features/asistencias/pagina_asistencias.dart'
    as _i2;
import 'package:escuelas_flutter/features/auth/asignacion_de_roles/pagina_asignacion_de_roles.dart'
    as _i1;
import 'package:escuelas_flutter/features/auth/kyc/formulario/pagina_formulario.dart'
    as _i3;
import 'package:escuelas_flutter/features/auth/kyc/pagina_kyc.dart' as _i5;
import 'package:escuelas_flutter/features/auth/kyc/seleccion_de_roles/pagina_seleccion_de_rol.dart'
    as _i9;
import 'package:escuelas_flutter/features/auth/login/pagina_login.dart' as _i6;
import 'package:escuelas_flutter/features/mis_cursos/pagina_mis_cursos.dart'
    as _i7;
import 'package:escuelas_flutter/features/pantalla_inicio/bloc/bloc_inicio.dart'
    as _i12;
import 'package:escuelas_flutter/features/pantalla_inicio/pagina_inicio.dart'
    as _i4;
import 'package:escuelas_flutter/features/perfil_usuario/pagina_perfil_usuario.dart'
    as _i8;
import 'package:flutter/material.dart' as _i11;

abstract class $AppRouter extends _i10.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    PaginaAsignacionDeRoles.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.PaginaAsignacionDeRoles(),
      );
    },
    PaginaAsistencia.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.PaginaAsistencia(),
      );
    },
    PaginaFormulario.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.PaginaFormulario(),
      );
    },
    PaginaInicio.name: (routeData) {
      final args = routeData.argsAs<PaginaInicioArgs>(
          orElse: () => const PaginaInicioArgs());
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.PaginaInicio(
          key: args.key,
          userInfo: args.userInfo,
        ),
      );
    },
    PaginaKyc.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.PaginaKyc(),
      );
    },
    PaginaLogin.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.PaginaLogin(),
      );
    },
    PaginaMisCursos.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.PaginaMisCursos(),
      );
    },
    PaginaPerfilUsuario.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PaginaPerfilUsuarioArgs>(
          orElse: () => PaginaPerfilUsuarioArgs(
              idUsuario: pathParams.getInt('idUsuario')));
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.PaginaPerfilUsuario(
          idUsuario: args.idUsuario,
          key: args.key,
        ),
      );
    },
    PaginaSeleccionDeRol.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.PaginaSeleccionDeRol(),
      );
    },
  };
}

/// generated route for
/// [_i1.PaginaAsignacionDeRoles]
class PaginaAsignacionDeRoles extends _i10.PageRouteInfo<void> {
  const PaginaAsignacionDeRoles({List<_i10.PageRouteInfo>? children})
      : super(
          PaginaAsignacionDeRoles.name,
          initialChildren: children,
        );

  static const String name = 'PaginaAsignacionDeRoles';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i2.PaginaAsistencia]
class PaginaAsistencia extends _i10.PageRouteInfo<void> {
  const PaginaAsistencia({List<_i10.PageRouteInfo>? children})
      : super(
          PaginaAsistencia.name,
          initialChildren: children,
        );

  static const String name = 'PaginaAsistencia';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i3.PaginaFormulario]
class PaginaFormulario extends _i10.PageRouteInfo<void> {
  const PaginaFormulario({List<_i10.PageRouteInfo>? children})
      : super(
          PaginaFormulario.name,
          initialChildren: children,
        );

  static const String name = 'PaginaFormulario';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i4.PaginaInicio]
class PaginaInicio extends _i10.PageRouteInfo<PaginaInicioArgs> {
  PaginaInicio({
    _i11.Key? key,
    _i12.InfoUsuario? userInfo,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          PaginaInicio.name,
          args: PaginaInicioArgs(
            key: key,
            userInfo: userInfo,
          ),
          initialChildren: children,
        );

  static const String name = 'PaginaInicio';

  static const _i10.PageInfo<PaginaInicioArgs> page =
      _i10.PageInfo<PaginaInicioArgs>(name);
}

class PaginaInicioArgs {
  const PaginaInicioArgs({
    this.key,
    this.userInfo,
  });

  final _i11.Key? key;

  final _i12.InfoUsuario? userInfo;

  @override
  String toString() {
    return 'PaginaInicioArgs{key: $key, userInfo: $userInfo}';
  }
}

/// generated route for
/// [_i5.PaginaKyc]
class PaginaKyc extends _i10.PageRouteInfo<void> {
  const PaginaKyc({List<_i10.PageRouteInfo>? children})
      : super(
          PaginaKyc.name,
          initialChildren: children,
        );

  static const String name = 'PaginaKyc';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i6.PaginaLogin]
class PaginaLogin extends _i10.PageRouteInfo<void> {
  const PaginaLogin({List<_i10.PageRouteInfo>? children})
      : super(
          PaginaLogin.name,
          initialChildren: children,
        );

  static const String name = 'PaginaLogin';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i7.PaginaMisCursos]
class PaginaMisCursos extends _i10.PageRouteInfo<void> {
  const PaginaMisCursos({List<_i10.PageRouteInfo>? children})
      : super(
          PaginaMisCursos.name,
          initialChildren: children,
        );

  static const String name = 'PaginaMisCursos';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i8.PaginaPerfilUsuario]
class PaginaPerfilUsuario extends _i10.PageRouteInfo<PaginaPerfilUsuarioArgs> {
  PaginaPerfilUsuario({
    required int idUsuario,
    _i11.Key? key,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          PaginaPerfilUsuario.name,
          args: PaginaPerfilUsuarioArgs(
            idUsuario: idUsuario,
            key: key,
          ),
          rawPathParams: {'idUsuario': idUsuario},
          initialChildren: children,
        );

  static const String name = 'PaginaPerfilUsuario';

  static const _i10.PageInfo<PaginaPerfilUsuarioArgs> page =
      _i10.PageInfo<PaginaPerfilUsuarioArgs>(name);
}

class PaginaPerfilUsuarioArgs {
  const PaginaPerfilUsuarioArgs({
    required this.idUsuario,
    this.key,
  });

  final int idUsuario;

  final _i11.Key? key;

  @override
  String toString() {
    return 'PaginaPerfilUsuarioArgs{idUsuario: $idUsuario, key: $key}';
  }
}

/// generated route for
/// [_i9.PaginaSeleccionDeRol]
class PaginaSeleccionDeRol extends _i10.PageRouteInfo<void> {
  const PaginaSeleccionDeRol({List<_i10.PageRouteInfo>? children})
      : super(
          PaginaSeleccionDeRol.name,
          initialChildren: children,
        );

  static const String name = 'PaginaSeleccionDeRol';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}
