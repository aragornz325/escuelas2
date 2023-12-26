// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:escuelas_flutter/features/auth/kyc/formulario/pagina_kyc.dart'
    as _i3;
import 'package:escuelas_flutter/features/auth/kyc/seleccion_de_roles/pagina_seleccion_de_rol.dart'
    as _i5;
import 'package:escuelas_flutter/features/auth/login/pagina_login.dart' as _i4;
import 'package:escuelas_flutter/features/auth/modelos_temporales.dart' as _i9;
import 'package:escuelas_flutter/features/pagina_ejemplo.dart' as _i1;
import 'package:escuelas_flutter/features/pantalla_inicio/bloc/bloc_inicio.dart'
    as _i8;
import 'package:escuelas_flutter/features/pantalla_inicio/pagina_inicio.dart'
    as _i2;
import 'package:flutter/material.dart' as _i7;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    PaginaEjemplo.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.PaginaEjemplo(),
      );
    },
    PaginaInicio.name: (routeData) {
      final args = routeData.argsAs<PaginaInicioArgs>(
          orElse: () => const PaginaInicioArgs());
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.PaginaInicio(
          key: args.key,
          userInfo: args.userInfo,
        ),
      );
    },
    PaginaKyc.name: (routeData) {
      final args = routeData.argsAs<PaginaKycArgs>();
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.PaginaKyc(
          rolElegido: args.rolElegido,
          key: args.key,
        ),
      );
    },
    PaginaLogin.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.PaginaLogin(),
      );
    },
    PaginaSeleccionDeRol.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.PaginaSeleccionDeRol(),
      );
    },
  };
}

/// generated route for
/// [_i1.PaginaEjemplo]
class PaginaEjemplo extends _i6.PageRouteInfo<void> {
  const PaginaEjemplo({List<_i6.PageRouteInfo>? children})
      : super(
          PaginaEjemplo.name,
          initialChildren: children,
        );

  static const String name = 'PaginaEjemplo';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.PaginaInicio]
class PaginaInicio extends _i6.PageRouteInfo<PaginaInicioArgs> {
  PaginaInicio({
    _i7.Key? key,
    _i8.InfoUsuario? userInfo,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          PaginaInicio.name,
          args: PaginaInicioArgs(
            key: key,
            userInfo: userInfo,
          ),
          initialChildren: children,
        );

  static const String name = 'PaginaInicio';

  static const _i6.PageInfo<PaginaInicioArgs> page =
      _i6.PageInfo<PaginaInicioArgs>(name);
}

class PaginaInicioArgs {
  const PaginaInicioArgs({
    this.key,
    this.userInfo,
  });

  final _i7.Key? key;

  final _i8.InfoUsuario? userInfo;

  @override
  String toString() {
    return 'PaginaInicioArgs{key: $key, userInfo: $userInfo}';
  }
}

/// generated route for
/// [_i3.PaginaKyc]
class PaginaKyc extends _i6.PageRouteInfo<PaginaKycArgs> {
  PaginaKyc({
    required _i9.Rol rolElegido,
    _i7.Key? key,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          PaginaKyc.name,
          args: PaginaKycArgs(
            rolElegido: rolElegido,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'PaginaKyc';

  static const _i6.PageInfo<PaginaKycArgs> page =
      _i6.PageInfo<PaginaKycArgs>(name);
}

class PaginaKycArgs {
  const PaginaKycArgs({
    required this.rolElegido,
    this.key,
  });

  final _i9.Rol rolElegido;

  final _i7.Key? key;

  @override
  String toString() {
    return 'PaginaKycArgs{rolElegido: $rolElegido, key: $key}';
  }
}

/// generated route for
/// [_i4.PaginaLogin]
class PaginaLogin extends _i6.PageRouteInfo<void> {
  const PaginaLogin({List<_i6.PageRouteInfo>? children})
      : super(
          PaginaLogin.name,
          initialChildren: children,
        );

  static const String name = 'PaginaLogin';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.PaginaSeleccionDeRol]
class PaginaSeleccionDeRol extends _i6.PageRouteInfo<void> {
  const PaginaSeleccionDeRol({List<_i6.PageRouteInfo>? children})
      : super(
          PaginaSeleccionDeRol.name,
          initialChildren: children,
        );

  static const String name = 'PaginaSeleccionDeRol';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}
