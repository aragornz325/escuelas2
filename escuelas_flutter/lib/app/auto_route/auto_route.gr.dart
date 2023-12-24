// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:escuelas_flutter/features/auth/kyc/bloc/bloc_kyc.dart' as _i6;
import 'package:escuelas_flutter/features/auth/kyc/pagina_kyc.dart' as _i2;
import 'package:escuelas_flutter/features/auth/login/pagina_login.dart' as _i3;
import 'package:escuelas_flutter/features/auth/seleccion_de_rol/pagina_seleccion_de_rol.dart'
    as _i4;
import 'package:escuelas_flutter/features/pagina_ejemplo.dart' as _i1;
import 'package:flutter/material.dart' as _i7;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    PaginaEjemplo.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.PaginaEjemplo(),
      );
    },
    PaginaKyc.name: (routeData) {
      final args = routeData.argsAs<PaginaKycArgs>();
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.PaginaKyc(
          rolElegido: args.rolElegido,
          key: args.key,
        ),
      );
    },
    PaginaLogin.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.PaginaLogin(),
      );
    },
    PaginaSeleccionDeRol.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.PaginaSeleccionDeRol(),
      );
    },
  };
}

/// generated route for
/// [_i1.PaginaEjemplo]
class PaginaEjemplo extends _i5.PageRouteInfo<void> {
  const PaginaEjemplo({List<_i5.PageRouteInfo>? children})
      : super(
          PaginaEjemplo.name,
          initialChildren: children,
        );

  static const String name = 'PaginaEjemplo';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.PaginaKyc]
class PaginaKyc extends _i5.PageRouteInfo<PaginaKycArgs> {
  PaginaKyc({
    required _i6.Rol rolElegido,
    _i7.Key? key,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          PaginaKyc.name,
          args: PaginaKycArgs(
            rolElegido: rolElegido,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'PaginaKyc';

  static const _i5.PageInfo<PaginaKycArgs> page =
      _i5.PageInfo<PaginaKycArgs>(name);
}

class PaginaKycArgs {
  const PaginaKycArgs({
    required this.rolElegido,
    this.key,
  });

  final _i6.Rol rolElegido;

  final _i7.Key? key;

  @override
  String toString() {
    return 'PaginaKycArgs{rolElegido: $rolElegido, key: $key}';
  }
}

/// generated route for
/// [_i3.PaginaLogin]
class PaginaLogin extends _i5.PageRouteInfo<void> {
  const PaginaLogin({List<_i5.PageRouteInfo>? children})
      : super(
          PaginaLogin.name,
          initialChildren: children,
        );

  static const String name = 'PaginaLogin';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.PaginaSeleccionDeRol]
class PaginaSeleccionDeRol extends _i5.PageRouteInfo<void> {
  const PaginaSeleccionDeRol({List<_i5.PageRouteInfo>? children})
      : super(
          PaginaSeleccionDeRol.name,
          initialChildren: children,
        );

  static const String name = 'PaginaSeleccionDeRol';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
