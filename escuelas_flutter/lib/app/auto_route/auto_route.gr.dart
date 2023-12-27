// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:escuelas_flutter/features/auth/asignacion_de_roles/pagina_asignacion_de_roles.dart'
    as _i1;
import 'package:escuelas_flutter/features/auth/kyc/formulario/pagina_kyc.dart'
    as _i4;
import 'package:escuelas_flutter/features/auth/kyc/seleccion_de_roles/pagina_seleccion_de_rol.dart'
    as _i7;
import 'package:escuelas_flutter/features/auth/login/pagina_login.dart' as _i5;
import 'package:escuelas_flutter/features/auth/modelos_temporales.dart' as _i11;
import 'package:escuelas_flutter/features/pagina_ejemplo.dart' as _i2;
import 'package:escuelas_flutter/features/pantalla_inicio/bloc/bloc_inicio.dart'
    as _i10;
import 'package:escuelas_flutter/features/pantalla_inicio/pagina_inicio.dart'
    as _i3;
import 'package:escuelas_flutter/features/perfil_usuario/pagina_perfil_usuario.dart'
    as _i6;
import 'package:flutter/material.dart' as _i9;

abstract class $AppRouter extends _i8.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    PaginaAsignacionDeRoles.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.PaginaAsignacionDeRoles(),
      );
    },
    PaginaEjemplo.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.PaginaEjemplo(),
      );
    },
    PaginaInicio.name: (routeData) {
      final args = routeData.argsAs<PaginaInicioArgs>(
          orElse: () => const PaginaInicioArgs());
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.PaginaInicio(
          key: args.key,
          userInfo: args.userInfo,
        ),
      );
    },
    PaginaKyc.name: (routeData) {
      final args = routeData.argsAs<PaginaKycArgs>();
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.PaginaKyc(
          rolElegido: args.rolElegido,
          key: args.key,
        ),
      );
    },
    PaginaLogin.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.PaginaLogin(),
      );
    },
    PaginaPerfilUsuario.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PaginaPerfilUsuarioArgs>(
          orElse: () => PaginaPerfilUsuarioArgs(
              idUsuario: pathParams.getInt('idUsuario')));
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.PaginaPerfilUsuario(
          idUsuario: args.idUsuario,
          key: args.key,
        ),
      );
    },
    PaginaSeleccionDeRol.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.PaginaSeleccionDeRol(),
      );
    },
  };
}

/// generated route for
/// [_i1.PaginaAsignacionDeRoles]
class PaginaAsignacionDeRoles extends _i8.PageRouteInfo<void> {
  const PaginaAsignacionDeRoles({List<_i8.PageRouteInfo>? children})
      : super(
          PaginaAsignacionDeRoles.name,
          initialChildren: children,
        );

  static const String name = 'PaginaAsignacionDeRoles';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i2.PaginaEjemplo]
class PaginaEjemplo extends _i8.PageRouteInfo<void> {
  const PaginaEjemplo({List<_i8.PageRouteInfo>? children})
      : super(
          PaginaEjemplo.name,
          initialChildren: children,
        );

  static const String name = 'PaginaEjemplo';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i3.PaginaInicio]
class PaginaInicio extends _i8.PageRouteInfo<PaginaInicioArgs> {
  PaginaInicio({
    _i9.Key? key,
    _i10.InfoUsuario? userInfo,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          PaginaInicio.name,
          args: PaginaInicioArgs(
            key: key,
            userInfo: userInfo,
          ),
          initialChildren: children,
        );

  static const String name = 'PaginaInicio';

  static const _i8.PageInfo<PaginaInicioArgs> page =
      _i8.PageInfo<PaginaInicioArgs>(name);
}

class PaginaInicioArgs {
  const PaginaInicioArgs({
    this.key,
    this.userInfo,
  });

  final _i9.Key? key;

  final _i10.InfoUsuario? userInfo;

  @override
  String toString() {
    return 'PaginaInicioArgs{key: $key, userInfo: $userInfo}';
  }
}

/// generated route for
/// [_i4.PaginaKyc]
class PaginaKyc extends _i8.PageRouteInfo<PaginaKycArgs> {
  PaginaKyc({
    required _i11.Rol rolElegido,
    _i9.Key? key,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          PaginaKyc.name,
          args: PaginaKycArgs(
            rolElegido: rolElegido,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'PaginaKyc';

  static const _i8.PageInfo<PaginaKycArgs> page =
      _i8.PageInfo<PaginaKycArgs>(name);
}

class PaginaKycArgs {
  const PaginaKycArgs({
    required this.rolElegido,
    this.key,
  });

  final _i11.Rol rolElegido;

  final _i9.Key? key;

  @override
  String toString() {
    return 'PaginaKycArgs{rolElegido: $rolElegido, key: $key}';
  }
}

/// generated route for
/// [_i5.PaginaLogin]
class PaginaLogin extends _i8.PageRouteInfo<void> {
  const PaginaLogin({List<_i8.PageRouteInfo>? children})
      : super(
          PaginaLogin.name,
          initialChildren: children,
        );

  static const String name = 'PaginaLogin';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i6.PaginaPerfilUsuario]
class PaginaPerfilUsuario extends _i8.PageRouteInfo<PaginaPerfilUsuarioArgs> {
  PaginaPerfilUsuario({
    required int idUsuario,
    _i9.Key? key,
    List<_i8.PageRouteInfo>? children,
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

  static const _i8.PageInfo<PaginaPerfilUsuarioArgs> page =
      _i8.PageInfo<PaginaPerfilUsuarioArgs>(name);
}

class PaginaPerfilUsuarioArgs {
  const PaginaPerfilUsuarioArgs({
    required this.idUsuario,
    this.key,
  });

  final int idUsuario;

  final _i9.Key? key;

  @override
  String toString() {
    return 'PaginaPerfilUsuarioArgs{idUsuario: $idUsuario, key: $key}';
  }
}

/// generated route for
/// [_i7.PaginaSeleccionDeRol]
class PaginaSeleccionDeRol extends _i8.PageRouteInfo<void> {
  const PaginaSeleccionDeRol({List<_i8.PageRouteInfo>? children})
      : super(
          PaginaSeleccionDeRol.name,
          initialChildren: children,
        );

  static const String name = 'PaginaSeleccionDeRol';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}
