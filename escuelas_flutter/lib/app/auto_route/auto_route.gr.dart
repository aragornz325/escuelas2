// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
<<<<<<< HEAD
import 'package:escuelas_flutter/features/asignacion_de_roles/pagina_asignacion_de_roles.dart'
    as _i1;
import 'package:escuelas_flutter/features/pagina_ejemplo.dart' as _i2;
=======
import 'package:escuelas_flutter/features/auth/login/pagina_login.dart' as _i2;
import 'package:escuelas_flutter/features/pagina_ejemplo.dart' as _i1;
>>>>>>> df51a3250e9484758077d83587b9e89b03e84812

abstract class $AppRouter extends _i3.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
<<<<<<< HEAD
    PaginaAsignacionDeRoles.name: (routeData) {
=======
    PaginaEjemplo.name: (routeData) {
>>>>>>> df51a3250e9484758077d83587b9e89b03e84812
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.PaginaAsignacionDeRoles(),
      );
    },
<<<<<<< HEAD
    PaginaEjemplo.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.PaginaEjemplo(),
=======
    PaginaLogin.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.PaginaLogin(),
>>>>>>> df51a3250e9484758077d83587b9e89b03e84812
      );
    },
  };
}

/// generated route for
<<<<<<< HEAD
/// [_i1.PaginaAsignacionDeRoles]
class PaginaAsignacionDeRoles extends _i3.PageRouteInfo<void> {
  const PaginaAsignacionDeRoles({List<_i3.PageRouteInfo>? children})
      : super(
          PaginaAsignacionDeRoles.name,
          initialChildren: children,
        );

  static const String name = 'PaginaAsignacionDeRoles';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}

/// generated route for
/// [_i2.PaginaEjemplo]
=======
/// [_i1.PaginaEjemplo]
>>>>>>> df51a3250e9484758077d83587b9e89b03e84812
class PaginaEjemplo extends _i3.PageRouteInfo<void> {
  const PaginaEjemplo({List<_i3.PageRouteInfo>? children})
      : super(
          PaginaEjemplo.name,
          initialChildren: children,
        );

  static const String name = 'PaginaEjemplo';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
<<<<<<< HEAD
=======
}

/// generated route for
/// [_i2.PaginaLogin]
class PaginaLogin extends _i3.PageRouteInfo<void> {
  const PaginaLogin({List<_i3.PageRouteInfo>? children})
      : super(
          PaginaLogin.name,
          initialChildren: children,
        );

  static const String name = 'PaginaLogin';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
>>>>>>> df51a3250e9484758077d83587b9e89b03e84812
}
