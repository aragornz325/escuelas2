// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:escuelas_flutter/features/asistencias/pagina_asistencias.dart'
    as _i4;
import 'package:escuelas_flutter/features/auth/asignacion_de_roles/pagina_asignacion_de_roles.dart'
    as _i1;
import 'package:escuelas_flutter/features/auth/kyc/formulario/pagina_formulario.dart'
    as _i3;
import 'package:escuelas_flutter/features/auth/kyc/pagina_kyc.dart' as _i6;
import 'package:escuelas_flutter/features/auth/kyc/seleccion_de_roles/pagina_seleccion_de_rol.dart'
    as _i9;
<<<<<<< HEAD
import 'package:escuelas_flutter/features/auth/login/pagina_login.dart' as _i6;
import 'package:escuelas_flutter/features/mis_cursos/pagina_mis_cursos.dart'
    as _i7;
=======
import 'package:escuelas_flutter/features/auth/login/pagina_login.dart' as _i7;
import 'package:escuelas_flutter/features/dashboard/pagina_dashboard.dart'
    as _i2;
>>>>>>> f33d3f8b903a031bdeafd6b0d4ea919d29260982
import 'package:escuelas_flutter/features/pantalla_inicio/bloc/bloc_inicio.dart'
    as _i12;
import 'package:escuelas_flutter/features/pantalla_inicio/pagina_inicio.dart'
    as _i5;
import 'package:escuelas_flutter/features/perfil_usuario/pagina_perfil_usuario.dart'
    as _i8;
import 'package:flutter/material.dart' as _i11;

abstract class $AppRouter extends _i10.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
<<<<<<< HEAD
    PaginaAsignacionDeRoles.name: (routeData) {
=======
    RutaAsignacionDeRoles.name: (routeData) {
>>>>>>> f33d3f8b903a031bdeafd6b0d4ea919d29260982
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.PaginaAsignacionDeRoles(),
      );
    },
<<<<<<< HEAD
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
=======
    RutaDashboard.name: (routeData) {
      final args = routeData.argsAs<RutaDashboardArgs>(
          orElse: () => const RutaDashboardArgs());
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.PaginaDashboard(
>>>>>>> f33d3f8b903a031bdeafd6b0d4ea919d29260982
          key: args.key,
          userInfo: args.userInfo,
        ),
      );
    },
<<<<<<< HEAD
    PaginaKyc.name: (routeData) {
=======
    RutaFormulario.name: (routeData) {
>>>>>>> f33d3f8b903a031bdeafd6b0d4ea919d29260982
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.PaginaFormulario(),
      );
    },
<<<<<<< HEAD
    PaginaLogin.name: (routeData) {
=======
    RutaInasistencia.name: (routeData) {
>>>>>>> f33d3f8b903a031bdeafd6b0d4ea919d29260982
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.PaginaInasistencia(),
      );
    },
<<<<<<< HEAD
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
=======
    RutaInicio.name: (routeData) {
      final args = routeData.argsAs<RutaInicioArgs>(
          orElse: () => const RutaInicioArgs());
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.PaginaInicio(
          key: args.key,
          userInfo: args.userInfo,
        ),
      );
    },
    RutaKyc.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.PaginaKyc(),
      );
    },
    RutaLogin.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.PaginaLogin(),
      );
    },
    RutaPerfilUsuario.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RutaPerfilUsuarioArgs>(
          orElse: () =>
              RutaPerfilUsuarioArgs(idUsuario: pathParams.getInt('idUsuario')));
>>>>>>> f33d3f8b903a031bdeafd6b0d4ea919d29260982
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.PaginaPerfilUsuario(
          idUsuario: args.idUsuario,
          key: args.key,
        ),
      );
    },
<<<<<<< HEAD
    PaginaSeleccionDeRol.name: (routeData) {
=======
    RutaSeleccionDeRol.name: (routeData) {
>>>>>>> f33d3f8b903a031bdeafd6b0d4ea919d29260982
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.PaginaSeleccionDeRol(),
      );
    },
  };
}

/// generated route for
/// [_i1.PaginaAsignacionDeRoles]
<<<<<<< HEAD
class PaginaAsignacionDeRoles extends _i10.PageRouteInfo<void> {
  const PaginaAsignacionDeRoles({List<_i10.PageRouteInfo>? children})
=======
class RutaAsignacionDeRoles extends _i10.PageRouteInfo<void> {
  const RutaAsignacionDeRoles({List<_i10.PageRouteInfo>? children})
>>>>>>> f33d3f8b903a031bdeafd6b0d4ea919d29260982
      : super(
          RutaAsignacionDeRoles.name,
          initialChildren: children,
        );

  static const String name = 'RutaAsignacionDeRoles';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
<<<<<<< HEAD
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
=======
/// [_i2.PaginaDashboard]
class RutaDashboard extends _i10.PageRouteInfo<RutaDashboardArgs> {
  RutaDashboard({
>>>>>>> f33d3f8b903a031bdeafd6b0d4ea919d29260982
    _i11.Key? key,
    _i12.InfoUsuario? userInfo,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          RutaDashboard.name,
          args: RutaDashboardArgs(
            key: key,
            userInfo: userInfo,
          ),
          initialChildren: children,
        );

  static const String name = 'RutaDashboard';

<<<<<<< HEAD
  static const _i10.PageInfo<PaginaInicioArgs> page =
      _i10.PageInfo<PaginaInicioArgs>(name);
=======
  static const _i10.PageInfo<RutaDashboardArgs> page =
      _i10.PageInfo<RutaDashboardArgs>(name);
>>>>>>> f33d3f8b903a031bdeafd6b0d4ea919d29260982
}

class RutaDashboardArgs {
  const RutaDashboardArgs({
    this.key,
    this.userInfo,
  });

  final _i11.Key? key;

  final _i12.InfoUsuario? userInfo;

  @override
  String toString() {
    return 'RutaDashboardArgs{key: $key, userInfo: $userInfo}';
  }
}

/// generated route for
<<<<<<< HEAD
/// [_i5.PaginaKyc]
class PaginaKyc extends _i10.PageRouteInfo<void> {
  const PaginaKyc({List<_i10.PageRouteInfo>? children})
=======
/// [_i3.PaginaFormulario]
class RutaFormulario extends _i10.PageRouteInfo<void> {
  const RutaFormulario({List<_i10.PageRouteInfo>? children})
>>>>>>> f33d3f8b903a031bdeafd6b0d4ea919d29260982
      : super(
          RutaFormulario.name,
          initialChildren: children,
        );

  static const String name = 'RutaFormulario';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
<<<<<<< HEAD
/// [_i6.PaginaLogin]
class PaginaLogin extends _i10.PageRouteInfo<void> {
  const PaginaLogin({List<_i10.PageRouteInfo>? children})
=======
/// [_i4.PaginaInasistencia]
class RutaInasistencia extends _i10.PageRouteInfo<void> {
  const RutaInasistencia({List<_i10.PageRouteInfo>? children})
>>>>>>> f33d3f8b903a031bdeafd6b0d4ea919d29260982
      : super(
          RutaInasistencia.name,
          initialChildren: children,
        );

  static const String name = 'RutaInasistencia';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
<<<<<<< HEAD
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
=======
/// [_i5.PaginaInicio]
class RutaInicio extends _i10.PageRouteInfo<RutaInicioArgs> {
  RutaInicio({
    _i11.Key? key,
    _i12.InfoUsuario? userInfo,
>>>>>>> f33d3f8b903a031bdeafd6b0d4ea919d29260982
    List<_i10.PageRouteInfo>? children,
  }) : super(
          RutaInicio.name,
          args: RutaInicioArgs(
            key: key,
            userInfo: userInfo,
          ),
          initialChildren: children,
        );

  static const String name = 'RutaInicio';

  static const _i10.PageInfo<RutaInicioArgs> page =
      _i10.PageInfo<RutaInicioArgs>(name);
}

class RutaInicioArgs {
  const RutaInicioArgs({
    this.key,
    this.userInfo,
  });

  final _i11.Key? key;

  final _i12.InfoUsuario? userInfo;

  @override
  String toString() {
    return 'RutaInicioArgs{key: $key, userInfo: $userInfo}';
  }
}

/// generated route for
/// [_i6.PaginaKyc]
class RutaKyc extends _i10.PageRouteInfo<void> {
  const RutaKyc({List<_i10.PageRouteInfo>? children})
      : super(
          RutaKyc.name,
          initialChildren: children,
        );

  static const String name = 'RutaKyc';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i7.PaginaLogin]
class RutaLogin extends _i10.PageRouteInfo<void> {
  const RutaLogin({List<_i10.PageRouteInfo>? children})
      : super(
          RutaLogin.name,
          initialChildren: children,
        );

  static const String name = 'RutaLogin';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i8.PaginaPerfilUsuario]
class RutaPerfilUsuario extends _i10.PageRouteInfo<RutaPerfilUsuarioArgs> {
  RutaPerfilUsuario({
    required int idUsuario,
    _i11.Key? key,
    List<_i10.PageRouteInfo>? children,
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

<<<<<<< HEAD
  static const _i10.PageInfo<PaginaPerfilUsuarioArgs> page =
      _i10.PageInfo<PaginaPerfilUsuarioArgs>(name);
=======
  static const _i10.PageInfo<RutaPerfilUsuarioArgs> page =
      _i10.PageInfo<RutaPerfilUsuarioArgs>(name);
>>>>>>> f33d3f8b903a031bdeafd6b0d4ea919d29260982
}

class RutaPerfilUsuarioArgs {
  const RutaPerfilUsuarioArgs({
    required this.idUsuario,
    this.key,
  });

  final int idUsuario;

  final _i11.Key? key;

  @override
  String toString() {
    return 'RutaPerfilUsuarioArgs{idUsuario: $idUsuario, key: $key}';
  }
}

/// generated route for
/// [_i9.PaginaSeleccionDeRol]
<<<<<<< HEAD
class PaginaSeleccionDeRol extends _i10.PageRouteInfo<void> {
  const PaginaSeleccionDeRol({List<_i10.PageRouteInfo>? children})
=======
class RutaSeleccionDeRol extends _i10.PageRouteInfo<void> {
  const RutaSeleccionDeRol({List<_i10.PageRouteInfo>? children})
>>>>>>> f33d3f8b903a031bdeafd6b0d4ea919d29260982
      : super(
          RutaSeleccionDeRol.name,
          initialChildren: children,
        );

  static const String name = 'RutaSeleccionDeRol';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}
