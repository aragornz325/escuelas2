// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i23;
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/features/auth/kyc/espera/pagina_espera.dart'
    as _i5;
import 'package:escuelas_flutter/features/auth/kyc/formulario/pagina_formulario.dart'
    as _i6;
import 'package:escuelas_flutter/features/auth/kyc/pagina_kyc.dart' as _i10;
import 'package:escuelas_flutter/features/auth/kyc/seleccion_de_roles/pagina_seleccion_de_rol.dart'
    as _i19;
import 'package:escuelas_flutter/features/auth/login/pagina_login.dart' as _i14;
import 'package:escuelas_flutter/features/dashboard/comunidad_academica/listado_comunidad/pagina_listado_comunidad.dart'
    as _i13;
import 'package:escuelas_flutter/features/dashboard/comunidad_academica/menu/pagina_menu_comunidad_academica.dart'
    as _i15;
import 'package:escuelas_flutter/features/dashboard/comunidad_academica/pagina_comunidad_academica.dart'
    as _i3;
import 'package:escuelas_flutter/features/dashboard/inasistencias/pagina_inasistencias.dart'
    as _i8;
import 'package:escuelas_flutter/features/dashboard/lista_cursos/carga_calificaciones/pagina_carga_calificaciones.dart'
    as _i1;
import 'package:escuelas_flutter/features/dashboard/lista_cursos/lista_cursos.dart'
    as _i11;
import 'package:escuelas_flutter/features/dashboard/lista_cursos/mis_cursos/pagina_mis_cursos.dart'
    as _i16;
import 'package:escuelas_flutter/features/dashboard/lista_de_comisiones/comisiones/pagina_comisiones.dart'
    as _i2;
import 'package:escuelas_flutter/features/dashboard/lista_de_comisiones/gestion_de_comision/pagina_gestion_de_comision.dart'
    as _i7;
import 'package:escuelas_flutter/features/dashboard/lista_de_comisiones/lista_de_comisiones.dart'
    as _i12;
import 'package:escuelas_flutter/features/dashboard/pagina_dashboard.dart'
    as _i4;
import 'package:escuelas_flutter/features/dashboard/pantalla_inicio/pagina_inicio.dart'
    as _i9;
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/pagina_perfil_usuario.dart'
    as _i17;
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/pagina_perfil_usuario_pendiente.dart'
    as _i18;
import 'package:escuelas_flutter/features/dashboard/supervision_comisiones/pagina_supervision_comisiones.dart'
    as _i20;
import 'package:escuelas_flutter/features/dashboard/supervision_envio_calificaciones/pagina_supervision_envio_calificaciones.dart'
    as _i21;
import 'package:escuelas_flutter/features/dashboard/usuarios_pendientes/pagina_usuarios_pendientes.dart'
    as _i22;
import 'package:flutter/material.dart' as _i24;
import 'package:serverpod_auth_client/module.dart' as _i25;

abstract class $AppRouter extends _i23.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i23.PageFactory> pagesMap = {
    RutaCargaDeCalificaciones.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RutaCargaDeCalificacionesArgs>(
          orElse: () => RutaCargaDeCalificacionesArgs(
                idAsignatura: pathParams.getInt('idAsignatura'),
                idComision: pathParams.getInt('idComision'),
                fecha: pathParams.getString('fecha'),
              ));
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.PaginaCargaDeCalificaciones(
          idAsignatura: args.idAsignatura,
          idComision: args.idComision,
          fecha: args.fecha,
          key: args.key,
        ),
      );
    },
    RutaComisiones.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.PaginaComisiones(),
      );
    },
    RutaComunidadAcademica.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.PaginaComunidadAcademica(),
      );
    },
    RutaDashboard.name: (routeData) {
      final args = routeData.argsAs<RutaDashboardArgs>();
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.PaginaDashboard(
          usuario: args.usuario,
          userInfo: args.userInfo,
          key: args.key,
        ),
      );
    },
    RutaEspera.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.PaginaEspera(),
      );
    },
    RutaFormulario.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.PaginaFormulario(),
      );
    },
    RutaGestionDeComision.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RutaGestionDeComisionArgs>(
          orElse: () => RutaGestionDeComisionArgs(
                idAsignatura: pathParams.getInt('idAsignatura'),
                idComision: pathParams.getInt('idComision'),
              ));
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.PaginaGestionDeComision(
          idAsignatura: args.idAsignatura,
          idComision: args.idComision,
          key: args.key,
        ),
      );
    },
    RutaInasistencia.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.PaginaInasistencia(),
      );
    },
    RutaInicio.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.PaginaInicio(),
      );
    },
    RutaKyc.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.PaginaKyc(),
      );
    },
    RutaListaCursos.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.PaginaListaCursos(),
      );
    },
    RutaListaDeComisiones.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.PaginaListaDeComisiones(),
      );
    },
    RutaListadoComunidad.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RutaListadoComunidadArgs>(
          orElse: () =>
              RutaListadoComunidadArgs(idRol: pathParams.getInt('idRol')));
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.PaginaListadoComunidad(
          idRol: args.idRol,
          key: args.key,
        ),
      );
    },
    RutaLogin.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.PaginaLogin(),
      );
    },
    RutaMenuComunidadAcademica.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.PaginaMenuComunidadAcademica(),
      );
    },
    RutaMisCursos.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.PaginaMisCursos(),
      );
    },
    RutaPerfilUsuario.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RutaPerfilUsuarioArgs>(
          orElse: () =>
              RutaPerfilUsuarioArgs(idUsuario: pathParams.getInt('userId')));
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.PaginaPerfilUsuario(
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
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.PaginaPerfilUsuarioPendiente(
          idUsuarioPendiente: args.idUsuarioPendiente,
          key: args.key,
        ),
      );
    },
    RutaSeleccionDeRol.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.PaginaSeleccionDeRol(),
      );
    },
    RutaSupervisionComisiones.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.PaginaSupervisionComisiones(),
      );
    },
    RutaSupervisionEnvioCalificaciones.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RutaSupervisionEnvioCalificacionesArgs>(
          orElse: () => RutaSupervisionEnvioCalificacionesArgs(
                idCurso: pathParams.getInt('idCurso'),
                fecha: pathParams.getString('fecha'),
              ));
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i21.PaginaSupervisionEnvioCalificaciones(
          idCurso: args.idCurso,
          fecha: args.fecha,
          key: args.key,
        ),
      );
    },
    RutaUsuariosPendientes.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i22.PaginaUsuariosPendientes(),
      );
    },
  };
}

/// generated route for
/// [_i1.PaginaCargaDeCalificaciones]
class RutaCargaDeCalificaciones
    extends _i23.PageRouteInfo<RutaCargaDeCalificacionesArgs> {
  RutaCargaDeCalificaciones({
    required int idAsignatura,
    required int idComision,
    required String fecha,
    _i24.Key? key,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          RutaCargaDeCalificaciones.name,
          args: RutaCargaDeCalificacionesArgs(
            idAsignatura: idAsignatura,
            idComision: idComision,
            fecha: fecha,
            key: key,
          ),
          rawPathParams: {
            'idAsignatura': idAsignatura,
            'idComision': idComision,
            'fecha': fecha,
          },
          initialChildren: children,
        );

  static const String name = 'RutaCargaDeCalificaciones';

  static const _i23.PageInfo<RutaCargaDeCalificacionesArgs> page =
      _i23.PageInfo<RutaCargaDeCalificacionesArgs>(name);
}

class RutaCargaDeCalificacionesArgs {
  const RutaCargaDeCalificacionesArgs({
    required this.idAsignatura,
    required this.idComision,
    required this.fecha,
    this.key,
  });

  final int idAsignatura;

  final int idComision;

  final String fecha;

  final _i24.Key? key;

  @override
  String toString() {
    return 'RutaCargaDeCalificacionesArgs{idAsignatura: $idAsignatura, idComision: $idComision, fecha: $fecha, key: $key}';
  }
}

/// generated route for
/// [_i2.PaginaComisiones]
class RutaComisiones extends _i23.PageRouteInfo<void> {
  const RutaComisiones({List<_i23.PageRouteInfo>? children})
      : super(
          RutaComisiones.name,
          initialChildren: children,
        );

  static const String name = 'RutaComisiones';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i3.PaginaComunidadAcademica]
class RutaComunidadAcademica extends _i23.PageRouteInfo<void> {
  const RutaComunidadAcademica({List<_i23.PageRouteInfo>? children})
      : super(
          RutaComunidadAcademica.name,
          initialChildren: children,
        );

  static const String name = 'RutaComunidadAcademica';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i4.PaginaDashboard]
class RutaDashboard extends _i23.PageRouteInfo<RutaDashboardArgs> {
  RutaDashboard({
    required Usuario usuario,
    required _i25.UserInfo userInfo,
    _i24.Key? key,
    List<_i23.PageRouteInfo>? children,
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

  static const _i23.PageInfo<RutaDashboardArgs> page =
      _i23.PageInfo<RutaDashboardArgs>(name);
}

class RutaDashboardArgs {
  const RutaDashboardArgs({
    required this.usuario,
    required this.userInfo,
    this.key,
  });

  final Usuario usuario;

  final _i25.UserInfo userInfo;

  final _i24.Key? key;

  @override
  String toString() {
    return 'RutaDashboardArgs{usuario: $usuario, userInfo: $userInfo, key: $key}';
  }
}

/// generated route for
/// [_i5.PaginaEspera]
class RutaEspera extends _i23.PageRouteInfo<void> {
  const RutaEspera({List<_i23.PageRouteInfo>? children})
      : super(
          RutaEspera.name,
          initialChildren: children,
        );

  static const String name = 'RutaEspera';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i6.PaginaFormulario]
class RutaFormulario extends _i23.PageRouteInfo<void> {
  const RutaFormulario({List<_i23.PageRouteInfo>? children})
      : super(
          RutaFormulario.name,
          initialChildren: children,
        );

  static const String name = 'RutaFormulario';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i7.PaginaGestionDeComision]
class RutaGestionDeComision
    extends _i23.PageRouteInfo<RutaGestionDeComisionArgs> {
  RutaGestionDeComision({
    required int idAsignatura,
    required int idComision,
    _i24.Key? key,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          RutaGestionDeComision.name,
          args: RutaGestionDeComisionArgs(
            idAsignatura: idAsignatura,
            idComision: idComision,
            key: key,
          ),
          rawPathParams: {
            'idAsignatura': idAsignatura,
            'idComision': idComision,
          },
          initialChildren: children,
        );

  static const String name = 'RutaGestionDeComision';

  static const _i23.PageInfo<RutaGestionDeComisionArgs> page =
      _i23.PageInfo<RutaGestionDeComisionArgs>(name);
}

class RutaGestionDeComisionArgs {
  const RutaGestionDeComisionArgs({
    required this.idAsignatura,
    required this.idComision,
    this.key,
  });

  final int idAsignatura;

  final int idComision;

  final _i24.Key? key;

  @override
  String toString() {
    return 'RutaGestionDeComisionArgs{idAsignatura: $idAsignatura, idComision: $idComision, key: $key}';
  }
}

/// generated route for
/// [_i8.PaginaInasistencia]
class RutaInasistencia extends _i23.PageRouteInfo<void> {
  const RutaInasistencia({List<_i23.PageRouteInfo>? children})
      : super(
          RutaInasistencia.name,
          initialChildren: children,
        );

  static const String name = 'RutaInasistencia';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i9.PaginaInicio]
class RutaInicio extends _i23.PageRouteInfo<void> {
  const RutaInicio({List<_i23.PageRouteInfo>? children})
      : super(
          RutaInicio.name,
          initialChildren: children,
        );

  static const String name = 'RutaInicio';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i10.PaginaKyc]
class RutaKyc extends _i23.PageRouteInfo<void> {
  const RutaKyc({List<_i23.PageRouteInfo>? children})
      : super(
          RutaKyc.name,
          initialChildren: children,
        );

  static const String name = 'RutaKyc';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i11.PaginaListaCursos]
class RutaListaCursos extends _i23.PageRouteInfo<void> {
  const RutaListaCursos({List<_i23.PageRouteInfo>? children})
      : super(
          RutaListaCursos.name,
          initialChildren: children,
        );

  static const String name = 'RutaListaCursos';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i12.PaginaListaDeComisiones]
class RutaListaDeComisiones extends _i23.PageRouteInfo<void> {
  const RutaListaDeComisiones({List<_i23.PageRouteInfo>? children})
      : super(
          RutaListaDeComisiones.name,
          initialChildren: children,
        );

  static const String name = 'RutaListaDeComisiones';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i13.PaginaListadoComunidad]
class RutaListadoComunidad
    extends _i23.PageRouteInfo<RutaListadoComunidadArgs> {
  RutaListadoComunidad({
    required int idRol,
    _i24.Key? key,
    List<_i23.PageRouteInfo>? children,
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

  static const _i23.PageInfo<RutaListadoComunidadArgs> page =
      _i23.PageInfo<RutaListadoComunidadArgs>(name);
}

class RutaListadoComunidadArgs {
  const RutaListadoComunidadArgs({
    required this.idRol,
    this.key,
  });

  final int idRol;

  final _i24.Key? key;

  @override
  String toString() {
    return 'RutaListadoComunidadArgs{idRol: $idRol, key: $key}';
  }
}

/// generated route for
/// [_i14.PaginaLogin]
class RutaLogin extends _i23.PageRouteInfo<void> {
  const RutaLogin({List<_i23.PageRouteInfo>? children})
      : super(
          RutaLogin.name,
          initialChildren: children,
        );

  static const String name = 'RutaLogin';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i15.PaginaMenuComunidadAcademica]
class RutaMenuComunidadAcademica extends _i23.PageRouteInfo<void> {
  const RutaMenuComunidadAcademica({List<_i23.PageRouteInfo>? children})
      : super(
          RutaMenuComunidadAcademica.name,
          initialChildren: children,
        );

  static const String name = 'RutaMenuComunidadAcademica';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i16.PaginaMisCursos]
class RutaMisCursos extends _i23.PageRouteInfo<void> {
  const RutaMisCursos({List<_i23.PageRouteInfo>? children})
      : super(
          RutaMisCursos.name,
          initialChildren: children,
        );

  static const String name = 'RutaMisCursos';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i17.PaginaPerfilUsuario]
class RutaPerfilUsuario extends _i23.PageRouteInfo<RutaPerfilUsuarioArgs> {
  RutaPerfilUsuario({
    required int idUsuario,
    _i24.Key? key,
    List<_i23.PageRouteInfo>? children,
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

  static const _i23.PageInfo<RutaPerfilUsuarioArgs> page =
      _i23.PageInfo<RutaPerfilUsuarioArgs>(name);
}

class RutaPerfilUsuarioArgs {
  const RutaPerfilUsuarioArgs({
    required this.idUsuario,
    this.key,
  });

  final int idUsuario;

  final _i24.Key? key;

  @override
  String toString() {
    return 'RutaPerfilUsuarioArgs{idUsuario: $idUsuario, key: $key}';
  }
}

/// generated route for
/// [_i18.PaginaPerfilUsuarioPendiente]
class RutaPerfilUsuarioPendiente
    extends _i23.PageRouteInfo<RutaPerfilUsuarioPendienteArgs> {
  RutaPerfilUsuarioPendiente({
    required int idUsuarioPendiente,
    _i24.Key? key,
    List<_i23.PageRouteInfo>? children,
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

  static const _i23.PageInfo<RutaPerfilUsuarioPendienteArgs> page =
      _i23.PageInfo<RutaPerfilUsuarioPendienteArgs>(name);
}

class RutaPerfilUsuarioPendienteArgs {
  const RutaPerfilUsuarioPendienteArgs({
    required this.idUsuarioPendiente,
    this.key,
  });

  final int idUsuarioPendiente;

  final _i24.Key? key;

  @override
  String toString() {
    return 'RutaPerfilUsuarioPendienteArgs{idUsuarioPendiente: $idUsuarioPendiente, key: $key}';
  }
}

/// generated route for
/// [_i19.PaginaSeleccionDeRol]
class RutaSeleccionDeRol extends _i23.PageRouteInfo<void> {
  const RutaSeleccionDeRol({List<_i23.PageRouteInfo>? children})
      : super(
          RutaSeleccionDeRol.name,
          initialChildren: children,
        );

  static const String name = 'RutaSeleccionDeRol';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i20.PaginaSupervisionComisiones]
class RutaSupervisionComisiones extends _i23.PageRouteInfo<void> {
  const RutaSupervisionComisiones({List<_i23.PageRouteInfo>? children})
      : super(
          RutaSupervisionComisiones.name,
          initialChildren: children,
        );

  static const String name = 'RutaSupervisionComisiones';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i21.PaginaSupervisionEnvioCalificaciones]
class RutaSupervisionEnvioCalificaciones
    extends _i23.PageRouteInfo<RutaSupervisionEnvioCalificacionesArgs> {
  RutaSupervisionEnvioCalificaciones({
    required int idCurso,
    required String fecha,
    _i24.Key? key,
    List<_i23.PageRouteInfo>? children,
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

  static const _i23.PageInfo<RutaSupervisionEnvioCalificacionesArgs> page =
      _i23.PageInfo<RutaSupervisionEnvioCalificacionesArgs>(name);
}

class RutaSupervisionEnvioCalificacionesArgs {
  const RutaSupervisionEnvioCalificacionesArgs({
    required this.idCurso,
    required this.fecha,
    this.key,
  });

  final int idCurso;

  final String fecha;

  final _i24.Key? key;

  @override
  String toString() {
    return 'RutaSupervisionEnvioCalificacionesArgs{idCurso: $idCurso, fecha: $fecha, key: $key}';
  }
}

/// generated route for
/// [_i22.PaginaUsuariosPendientes]
class RutaUsuariosPendientes extends _i23.PageRouteInfo<void> {
  const RutaUsuariosPendientes({List<_i23.PageRouteInfo>? children})
      : super(
          RutaUsuariosPendientes.name,
          initialChildren: children,
        );

  static const String name = 'RutaUsuariosPendientes';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}
