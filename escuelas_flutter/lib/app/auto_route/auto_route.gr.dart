// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i20;
import 'package:escuelas_client/escuelas_client.dart' as _i22;
import 'package:escuelas_flutter/features/auth/kyc/espera/pagina_espera.dart'
    as _i4;
import 'package:escuelas_flutter/features/auth/kyc/formulario/pagina_formulario.dart'
    as _i5;
import 'package:escuelas_flutter/features/auth/kyc/pagina_kyc.dart' as _i8;
import 'package:escuelas_flutter/features/auth/kyc/seleccion_de_roles/pagina_seleccion_de_rol.dart'
    as _i16;
import 'package:escuelas_flutter/features/auth/login/pagina_login.dart' as _i11;
import 'package:escuelas_flutter/features/dashboard/carga_calificaciones/pagina_carga_calificaciones.dart'
    as _i1;
import 'package:escuelas_flutter/features/dashboard/comunidad_academica/listado_comunidad/pagina_listado_comunidad.dart'
    as _i10;
import 'package:escuelas_flutter/features/dashboard/comunidad_academica/menu/pagina_menu_comunidad_academica.dart'
    as _i12;
import 'package:escuelas_flutter/features/dashboard/comunidad_academica/pagina_comunidad_academica.dart'
    as _i2;
import 'package:escuelas_flutter/features/dashboard/inasistencias/pagina_inasistencias.dart'
    as _i6;
import 'package:escuelas_flutter/features/dashboard/lista_cursos/lista_cursos.dart'
    as _i9;
import 'package:escuelas_flutter/features/dashboard/mis_cursos/pagina_mis_cursos.dart'
    as _i13;
import 'package:escuelas_flutter/features/dashboard/pagina_dashboard.dart'
    as _i3;
import 'package:escuelas_flutter/features/dashboard/pantalla_inicio/pagina_inicio.dart'
    as _i7;
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/pagina_perfil_usuario.dart'
    as _i14;
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/pagina_perfil_usuario_pendiente.dart'
    as _i15;
import 'package:escuelas_flutter/features/dashboard/supervision_cursos/pagina_supervision_cursos.dart'
    as _i17;
import 'package:escuelas_flutter/features/dashboard/supervision_envio_calificaciones/pagina_supervision_envio_calificaciones.dart'
    as _i18;
import 'package:escuelas_flutter/features/dashboard/usuarios_pendientes/pagina_usuarios_pendientes.dart'
    as _i19;
import 'package:flutter/material.dart' as _i21;
import 'package:serverpod_auth_client/module.dart' as _i23;

abstract class $AppRouter extends _i20.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i20.PageFactory> pagesMap = {
    RutaCargaDeCalificaciones.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RutaCargaDeCalificacionesArgs>(
          orElse: () => RutaCargaDeCalificacionesArgs(
                nombreAsignatura: pathParams.getString('nombreAsignatura'),
                idAsignatura: pathParams.getInt('idAsignatura'),
                idComision: pathParams.getInt('idComision'),
                fecha: pathParams.getString('fecha'),
              ));
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.PaginaCargaDeCalificaciones(
          nombreAsignatura: args.nombreAsignatura,
          idAsignatura: args.idAsignatura,
          idComision: args.idComision,
          fecha: args.fecha,
          key: args.key,
        ),
      );
    },
    RutaComunidadAcademica.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.PaginaComunidadAcademica(),
      );
    },
    RutaDashboard.name: (routeData) {
      final args = routeData.argsAs<RutaDashboardArgs>();
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.PaginaDashboard(
          usuario: args.usuario,
          userInfo: args.userInfo,
          key: args.key,
        ),
      );
    },
    RutaEspera.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.PaginaEspera(),
      );
    },
    RutaFormulario.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.PaginaFormulario(),
      );
    },
    RutaInasistencia.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.PaginaInasistencia(),
      );
    },
    RutaInicio.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.PaginaInicio(),
      );
    },
    RutaKyc.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.PaginaKyc(),
      );
    },
    RutaListaCursos.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.PaginaListaCursos(),
      );
    },
    RutaListadoComunidad.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RutaListadoComunidadArgs>(
          orElse: () =>
              RutaListadoComunidadArgs(idRol: pathParams.getInt('idRol')));
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.PaginaListadoComunidad(
          idRol: args.idRol,
          key: args.key,
        ),
      );
    },
    RutaLogin.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.PaginaLogin(),
      );
    },
    RutaMenuComunidadAcademica.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.PaginaMenuComunidadAcademica(),
      );
    },
    RutaMisCursos.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.PaginaMisCursos(),
      );
    },
    RutaPerfilUsuario.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RutaPerfilUsuarioArgs>(
          orElse: () =>
              RutaPerfilUsuarioArgs(idUsuario: pathParams.getInt('userId')));
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.PaginaPerfilUsuario(
          idUsuario: args.idUsuario,
          key: args.key,
        ),
      );
    },
    RutaPerfilUsuarioPendiente.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RutaPerfilUsuarioPendienteArgs>(
          orElse: () => RutaPerfilUsuarioPendienteArgs(
              idUsuarioPendiente: pathParams.getInt('pendingUserId')));
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.PaginaPerfilUsuarioPendiente(
          idUsuarioPendiente: args.idUsuarioPendiente,
          key: args.key,
        ),
      );
    },
    RutaSeleccionDeRol.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.PaginaSeleccionDeRol(),
      );
    },
    RutaSupervisionCursos.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.PaginaSupervisionCursos(),
      );
    },
    RutaSupervisionEnvioCalificaciones.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RutaSupervisionEnvioCalificacionesArgs>(
          orElse: () => RutaSupervisionEnvioCalificacionesArgs(
                idCurso: pathParams.getInt('idCurso'),
                fecha: pathParams.getString('fecha'),
              ));
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.PaginaSupervisionEnvioCalificaciones(
          idCurso: args.idCurso,
          fecha: args.fecha,
          key: args.key,
        ),
      );
    },
    RutaUsuariosPendientes.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.PaginaUsuariosPendientes(),
      );
    },
  };
}

/// generated route for
/// [_i1.PaginaCargaDeCalificaciones]
class RutaCargaDeCalificaciones
    extends _i20.PageRouteInfo<RutaCargaDeCalificacionesArgs> {
  RutaCargaDeCalificaciones({
    required String nombreAsignatura,
    required int idAsignatura,
    required int idComision,
    required String fecha,
    _i21.Key? key,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          RutaCargaDeCalificaciones.name,
          args: RutaCargaDeCalificacionesArgs(
            nombreAsignatura: nombreAsignatura,
            idAsignatura: idAsignatura,
            idComision: idComision,
            fecha: fecha,
            key: key,
          ),
          rawPathParams: {
            'nombreAsignatura': nombreAsignatura,
            'idAsignatura': idAsignatura,
            'idComision': idComision,
            'fecha': fecha,
          },
          initialChildren: children,
        );

  static const String name = 'RutaCargaDeCalificaciones';

  static const _i20.PageInfo<RutaCargaDeCalificacionesArgs> page =
      _i20.PageInfo<RutaCargaDeCalificacionesArgs>(name);
}

class RutaCargaDeCalificacionesArgs {
  const RutaCargaDeCalificacionesArgs({
    required this.nombreAsignatura,
    required this.idAsignatura,
    required this.idComision,
    required this.fecha,
    this.key,
  });

  final String nombreAsignatura;

  final int idAsignatura;

  final int idComision;

  final String fecha;

  final _i21.Key? key;

  @override
  String toString() {
    return 'RutaCargaDeCalificacionesArgs{nombreAsignatura: $nombreAsignatura, idAsignatura: $idAsignatura, idComision: $idComision, fecha: $fecha, key: $key}';
  }
}

/// generated route for
/// [_i2.PaginaComunidadAcademica]
class RutaComunidadAcademica extends _i20.PageRouteInfo<void> {
  const RutaComunidadAcademica({List<_i20.PageRouteInfo>? children})
      : super(
          RutaComunidadAcademica.name,
          initialChildren: children,
        );

  static const String name = 'RutaComunidadAcademica';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i3.PaginaDashboard]
class RutaDashboard extends _i20.PageRouteInfo<RutaDashboardArgs> {
  RutaDashboard({
    required _i22.Usuario usuario,
    required _i23.UserInfo userInfo,
    _i21.Key? key,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          RutaDashboard.name,
          args: RutaDashboardArgs(
            usuario: usuario,
            userInfo: userInfo,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'RutaDashboard';

  static const _i20.PageInfo<RutaDashboardArgs> page =
      _i20.PageInfo<RutaDashboardArgs>(name);
}

class RutaDashboardArgs {
  const RutaDashboardArgs({
    required this.usuario,
    required this.userInfo,
    this.key,
  });

  final _i22.Usuario usuario;

  final _i23.UserInfo userInfo;

  final _i21.Key? key;

  @override
  String toString() {
    return 'RutaDashboardArgs{usuario: $usuario, userInfo: $userInfo, key: $key}';
  }
}

/// generated route for
/// [_i4.PaginaEspera]
class RutaEspera extends _i20.PageRouteInfo<void> {
  const RutaEspera({List<_i20.PageRouteInfo>? children})
      : super(
          RutaEspera.name,
          initialChildren: children,
        );

  static const String name = 'RutaEspera';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i5.PaginaFormulario]
class RutaFormulario extends _i20.PageRouteInfo<void> {
  const RutaFormulario({List<_i20.PageRouteInfo>? children})
      : super(
          RutaFormulario.name,
          initialChildren: children,
        );

  static const String name = 'RutaFormulario';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i6.PaginaInasistencia]
class RutaInasistencia extends _i20.PageRouteInfo<void> {
  const RutaInasistencia({List<_i20.PageRouteInfo>? children})
      : super(
          RutaInasistencia.name,
          initialChildren: children,
        );

  static const String name = 'RutaInasistencia';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i7.PaginaInicio]
class RutaInicio extends _i20.PageRouteInfo<void> {
  const RutaInicio({List<_i20.PageRouteInfo>? children})
      : super(
          RutaInicio.name,
          initialChildren: children,
        );

  static const String name = 'RutaInicio';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i8.PaginaKyc]
class RutaKyc extends _i20.PageRouteInfo<void> {
  const RutaKyc({List<_i20.PageRouteInfo>? children})
      : super(
          RutaKyc.name,
          initialChildren: children,
        );

  static const String name = 'RutaKyc';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i9.PaginaListaCursos]
class RutaListaCursos extends _i20.PageRouteInfo<void> {
  const RutaListaCursos({List<_i20.PageRouteInfo>? children})
      : super(
          RutaListaCursos.name,
          initialChildren: children,
        );

  static const String name = 'RutaListaCursos';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i10.PaginaListadoComunidad]
class RutaListadoComunidad
    extends _i20.PageRouteInfo<RutaListadoComunidadArgs> {
  RutaListadoComunidad({
    required int idRol,
    _i21.Key? key,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          RutaListadoComunidad.name,
          args: RutaListadoComunidadArgs(
            idRol: idRol,
            key: key,
          ),
          rawPathParams: {'idRol': idRol},
          initialChildren: children,
        );

  static const String name = 'RutaListadoComunidad';

  static const _i20.PageInfo<RutaListadoComunidadArgs> page =
      _i20.PageInfo<RutaListadoComunidadArgs>(name);
}

class RutaListadoComunidadArgs {
  const RutaListadoComunidadArgs({
    required this.idRol,
    this.key,
  });

  final int idRol;

  final _i21.Key? key;

  @override
  String toString() {
    return 'RutaListadoComunidadArgs{idRol: $idRol, key: $key}';
  }
}

/// generated route for
/// [_i11.PaginaLogin]
class RutaLogin extends _i20.PageRouteInfo<void> {
  const RutaLogin({List<_i20.PageRouteInfo>? children})
      : super(
          RutaLogin.name,
          initialChildren: children,
        );

  static const String name = 'RutaLogin';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i12.PaginaMenuComunidadAcademica]
class RutaMenuComunidadAcademica extends _i20.PageRouteInfo<void> {
  const RutaMenuComunidadAcademica({List<_i20.PageRouteInfo>? children})
      : super(
          RutaMenuComunidadAcademica.name,
          initialChildren: children,
        );

  static const String name = 'RutaMenuComunidadAcademica';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i13.PaginaMisCursos]
class RutaMisCursos extends _i20.PageRouteInfo<void> {
  const RutaMisCursos({List<_i20.PageRouteInfo>? children})
      : super(
          RutaMisCursos.name,
          initialChildren: children,
        );

  static const String name = 'RutaMisCursos';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i14.PaginaPerfilUsuario]
class RutaPerfilUsuario extends _i20.PageRouteInfo<RutaPerfilUsuarioArgs> {
  RutaPerfilUsuario({
    required int idUsuario,
    _i21.Key? key,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          RutaPerfilUsuario.name,
          args: RutaPerfilUsuarioArgs(
            idUsuario: idUsuario,
            key: key,
          ),
          rawPathParams: {'userId': idUsuario},
          initialChildren: children,
        );

  static const String name = 'RutaPerfilUsuario';

  static const _i20.PageInfo<RutaPerfilUsuarioArgs> page =
      _i20.PageInfo<RutaPerfilUsuarioArgs>(name);
}

class RutaPerfilUsuarioArgs {
  const RutaPerfilUsuarioArgs({
    required this.idUsuario,
    this.key,
  });

  final int idUsuario;

  final _i21.Key? key;

  @override
  String toString() {
    return 'RutaPerfilUsuarioArgs{idUsuario: $idUsuario, key: $key}';
  }
}

/// generated route for
/// [_i15.PaginaPerfilUsuarioPendiente]
class RutaPerfilUsuarioPendiente
    extends _i20.PageRouteInfo<RutaPerfilUsuarioPendienteArgs> {
  RutaPerfilUsuarioPendiente({
    required int idUsuarioPendiente,
    _i21.Key? key,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          RutaPerfilUsuarioPendiente.name,
          args: RutaPerfilUsuarioPendienteArgs(
            idUsuarioPendiente: idUsuarioPendiente,
            key: key,
          ),
          rawPathParams: {'pendingUserId': idUsuarioPendiente},
          initialChildren: children,
        );

  static const String name = 'RutaPerfilUsuarioPendiente';

  static const _i20.PageInfo<RutaPerfilUsuarioPendienteArgs> page =
      _i20.PageInfo<RutaPerfilUsuarioPendienteArgs>(name);
}

class RutaPerfilUsuarioPendienteArgs {
  const RutaPerfilUsuarioPendienteArgs({
    required this.idUsuarioPendiente,
    this.key,
  });

  final int idUsuarioPendiente;

  final _i21.Key? key;

  @override
  String toString() {
    return 'RutaPerfilUsuarioPendienteArgs{idUsuarioPendiente: $idUsuarioPendiente, key: $key}';
  }
}

/// generated route for
/// [_i16.PaginaSeleccionDeRol]
class RutaSeleccionDeRol extends _i20.PageRouteInfo<void> {
  const RutaSeleccionDeRol({List<_i20.PageRouteInfo>? children})
      : super(
          RutaSeleccionDeRol.name,
          initialChildren: children,
        );

  static const String name = 'RutaSeleccionDeRol';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i17.PaginaSupervisionCursos]
class RutaSupervisionCursos extends _i20.PageRouteInfo<void> {
  const RutaSupervisionCursos({List<_i20.PageRouteInfo>? children})
      : super(
          RutaSupervisionCursos.name,
          initialChildren: children,
        );

  static const String name = 'RutaSupervisionCursos';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i18.PaginaSupervisionEnvioCalificaciones]
class RutaSupervisionEnvioCalificaciones
    extends _i20.PageRouteInfo<RutaSupervisionEnvioCalificacionesArgs> {
  RutaSupervisionEnvioCalificaciones({
    required int idCurso,
    required String fecha,
    _i21.Key? key,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          RutaSupervisionEnvioCalificaciones.name,
          args: RutaSupervisionEnvioCalificacionesArgs(
            idCurso: idCurso,
            fecha: fecha,
            key: key,
          ),
          rawPathParams: {
            'idCurso': idCurso,
            'fecha': fecha,
          },
          initialChildren: children,
        );

  static const String name = 'RutaSupervisionEnvioCalificaciones';

  static const _i20.PageInfo<RutaSupervisionEnvioCalificacionesArgs> page =
      _i20.PageInfo<RutaSupervisionEnvioCalificacionesArgs>(name);
}

class RutaSupervisionEnvioCalificacionesArgs {
  const RutaSupervisionEnvioCalificacionesArgs({
    required this.idCurso,
    required this.fecha,
    this.key,
  });

  final int idCurso;

  final String fecha;

  final _i21.Key? key;

  @override
  String toString() {
    return 'RutaSupervisionEnvioCalificacionesArgs{idCurso: $idCurso, fecha: $fecha, key: $key}';
  }
}

/// generated route for
/// [_i19.PaginaUsuariosPendientes]
class RutaUsuariosPendientes extends _i20.PageRouteInfo<void> {
  const RutaUsuariosPendientes({List<_i20.PageRouteInfo>? children})
      : super(
          RutaUsuariosPendientes.name,
          initialChildren: children,
        );

  static const String name = 'RutaUsuariosPendientes';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}
