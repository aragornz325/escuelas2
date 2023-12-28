// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:escuelas_flutter/features/auth/kyc/formulario/pagina_formulario.dart'
    as _i2;
import 'package:escuelas_flutter/features/auth/kyc/pagina_kyc.dart' as _i3;
import 'package:escuelas_flutter/features/auth/kyc/seleccion_de_roles/pagina_seleccion_de_rol.dart'
    as _i5;
import 'package:escuelas_flutter/features/auth/login/pagina_login.dart' as _i4;
import 'package:escuelas_flutter/features/pagina_ejemplo.dart' as _i1;

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
    PaginaFormulario.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.PaginaFormulario(),
      );
    },
    PaginaKyc.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.PaginaKyc(),
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
/// [_i2.PaginaFormulario]
class PaginaFormulario extends _i6.PageRouteInfo<void> {
  const PaginaFormulario({List<_i6.PageRouteInfo>? children})
      : super(
          PaginaFormulario.name,
          initialChildren: children,
        );

  static const String name = 'PaginaFormulario';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.PaginaKyc]
class PaginaKyc extends _i6.PageRouteInfo<void> {
  const PaginaKyc({List<_i6.PageRouteInfo>? children})
      : super(
          PaginaKyc.name,
          initialChildren: children,
        );

  static const String name = 'PaginaKyc';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
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
