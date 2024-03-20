// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i34;
import 'package:escuelas_client/escuelas_client.dart' as _i36;
import 'package:escuelas_flutter/features/auth/kyc/espera/pagina_espera.dart'
    as _i13;
import 'package:escuelas_flutter/features/auth/kyc/formulario/pagina_formulario.dart'
    as _i14;
import 'package:escuelas_flutter/features/auth/kyc/pagina_kyc.dart' as _i18;
import 'package:escuelas_flutter/features/auth/kyc/seleccion_de_roles/pagina_seleccion_de_rol.dart'
    as _i30;
import 'package:escuelas_flutter/features/auth/login/pagina_login.dart' as _i22;
import 'package:escuelas_flutter/features/auth/registro/pagina_registro.dart'
    as _i29;
import 'package:escuelas_flutter/features/dashboard/alumno-calificaciones/calificaciones-anuales/pagina_calificaciones_anuales.dart'
    as _i2;
import 'package:escuelas_flutter/features/dashboard/alumno-calificaciones/calificaciones-mensuales/pagina_calificaciones_mensuales.dart'
    as _i3;
import 'package:escuelas_flutter/features/dashboard/comunicaciones/administrar_plantillas/pagina_administrar_plantillas.dart'
    as _i1;
import 'package:escuelas_flutter/features/dashboard/comunicaciones/cursos/lista_cursos/pagina_lista_cursos.dart'
    as _i9;
import 'package:escuelas_flutter/features/dashboard/comunicaciones/cursos/pagina_comunicaciones_cursos.dart'
    as _i7;
import 'package:escuelas_flutter/features/dashboard/comunicaciones/cursos/perfil_comunicados/pagina_perfil_comunicados.dart'
    as _i26;
import 'package:escuelas_flutter/features/dashboard/comunicaciones/general/page_comunicaciones_general.dart'
    as _i8;
import 'package:escuelas_flutter/features/dashboard/comunicaciones/menu_comunicaciones/page_menu_comunicaciones.dart'
    as _i23;
import 'package:escuelas_flutter/features/dashboard/comunicaciones/page_comunicaciones.dart'
    as _i6;
import 'package:escuelas_flutter/features/dashboard/comunicaciones/pendientes/page_comunicaciones_pendientes.dart'
    as _i10;
import 'package:escuelas_flutter/features/dashboard/comunidad_academica/listado_comunidad/pagina_listado_comunidad.dart'
    as _i21;
import 'package:escuelas_flutter/features/dashboard/comunidad_academica/menu/pagina_menu_comunidad_academica.dart'
    as _i24;
import 'package:escuelas_flutter/features/dashboard/comunidad_academica/pagina_comunidad_academica.dart'
    as _i11;
import 'package:escuelas_flutter/features/dashboard/inasistencias/pagina_inasistencias.dart'
    as _i16;
import 'package:escuelas_flutter/features/dashboard/lista_cursos/carga_calificaciones/pagina_carga_calificaciones.dart'
    as _i4;
import 'package:escuelas_flutter/features/dashboard/lista_cursos/lista_cursos.dart'
    as _i19;
import 'package:escuelas_flutter/features/dashboard/lista_cursos/mis_cursos/pagina_mis_cursos.dart'
    as _i25;
import 'package:escuelas_flutter/features/dashboard/lista_de_comisiones/comisiones/pagina_comisiones.dart'
    as _i5;
import 'package:escuelas_flutter/features/dashboard/lista_de_comisiones/gestion_de_comision/pagina_gestion_de_comision.dart'
    as _i15;
import 'package:escuelas_flutter/features/dashboard/lista_de_comisiones/lista_de_comisiones.dart'
    as _i20;
import 'package:escuelas_flutter/features/dashboard/pagina_dashboard.dart'
    as _i12;
import 'package:escuelas_flutter/features/dashboard/pantalla_inicio/pagina_inicio.dart'
    as _i17;
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/pagina_perfil_usuario.dart'
    as _i27;
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/pagina_perfil_usuario_pendiente.dart'
    as _i28;
import 'package:escuelas_flutter/features/dashboard/supervision_comisiones/pagina_supervision_comisiones.dart'
    as _i31;
import 'package:escuelas_flutter/features/dashboard/supervision_envio_calificaciones/pagina_supervision_envio_calificaciones.dart'
    as _i32;
import 'package:escuelas_flutter/features/dashboard/usuarios_pendientes/pagina_usuarios_pendientes.dart'
    as _i33;
import 'package:flutter/material.dart' as _i35;
import 'package:serverpod_auth_client/module.dart' as _i37;

abstract class $AppRouter extends _i34.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i34.PageFactory> pagesMap = {
    RutaAdministrarPlantillas.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.PaginaAdministrarPlantillas(),
      );
    },
    RutaCalificacionesAnuales.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RutaCalificacionesAnualesArgs>(
          orElse: () => RutaCalificacionesAnualesArgs(
              idAsignatura: pathParams.getInt('idAsignatura')));
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.PaginaCalificacionesAnuales(
          idAsignatura: args.idAsignatura,
          key: args.key,
        ),
      );
    },
    RutaCalificacionesMensuales.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.PaginaCalificacionesMensuales(),
      );
    },
    RutaCargaDeCalificaciones.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RutaCargaDeCalificacionesArgs>(
          orElse: () => RutaCargaDeCalificacionesArgs(
                idAsignatura: pathParams.getInt('idAsignatura'),
                idComision: pathParams.getInt('idComision'),
                fecha: pathParams.getString('fecha'),
              ));
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.PaginaCargaDeCalificaciones(
          idAsignatura: args.idAsignatura,
          idComision: args.idComision,
          fecha: args.fecha,
          key: args.key,
        ),
      );
    },
    RutaComisiones.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.PaginaComisiones(),
      );
    },
    RutaComunicaciones.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.PaginaComunicaciones(),
      );
    },
    RutaComunicacionesCursos.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.PaginaComunicacionesCursos(),
      );
    },
    RutaComunicacionesGeneral.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.PaginaComunicacionesGeneral(),
      );
    },
    RutaComunicacionesListaCursos.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.PaginaComunicacionesListaCursos(),
      );
    },
    RutaComunicacionesPendientes.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.PaginaComunicacionesPendientes(),
      );
    },
    RutaComunidadAcademica.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.PaginaComunidadAcademica(),
      );
    },
    RutaDashboard.name: (routeData) {
      final args = routeData.argsAs<RutaDashboardArgs>();
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.PaginaDashboard(
          usuario: args.usuario,
          userInfo: args.userInfo,
          key: args.key,
        ),
      );
    },
    RutaEspera.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.PaginaEspera(),
      );
    },
    RutaFormulario.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.PaginaFormulario(),
      );
    },
    RutaGestionDeComision.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RutaGestionDeComisionArgs>(
          orElse: () => RutaGestionDeComisionArgs(
                idAsignatura: pathParams.getInt('idAsignatura'),
                idComision: pathParams.getInt('idComision'),
              ));
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.PaginaGestionDeComision(
          idAsignatura: args.idAsignatura,
          idComision: args.idComision,
          key: args.key,
        ),
      );
    },
    RutaInasistencia.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.PaginaInasistencia(),
      );
    },
    RutaInicio.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.PaginaInicio(),
      );
    },
    RutaKyc.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.PaginaKyc(),
      );
    },
    RutaListaCursos.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.PaginaListaCursos(),
      );
    },
    RutaListaDeComisiones.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.PaginaListaDeComisiones(),
      );
    },
    RutaListadoComunidad.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RutaListadoComunidadArgs>(
          orElse: () =>
              RutaListadoComunidadArgs(idRol: pathParams.getInt('idRol')));
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i21.PaginaListadoComunidad(
          idRol: args.idRol,
          key: args.key,
        ),
      );
    },
    RutaLogin.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i22.PaginaLogin(),
      );
    },
    RutaMenuComunicaciones.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i23.PaginaMenuComunicaciones(),
      );
    },
    RutaMenuComunidadAcademica.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i24.PaginaMenuComunidadAcademica(),
      );
    },
    RutaMisCursos.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i25.PaginaMisCursos(),
      );
    },
    RutaPerfilComunicados.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RutaPerfilComunicadosArgs>(
          orElse: () => RutaPerfilComunicadosArgs(
                idUsuario: pathParams.getInt('idUsuario'),
                nombreUsuario: pathParams.getString('nombreUsuario'),
              ));
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i26.PaginaPerfilComunicados(
          idUsuario: args.idUsuario,
          nombreUsuario: args.nombreUsuario,
          key: args.key,
        ),
      );
    },
    RutaPerfilUsuario.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RutaPerfilUsuarioArgs>(
          orElse: () =>
              RutaPerfilUsuarioArgs(idUsuario: pathParams.getInt('userId')));
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i27.PaginaPerfilUsuario(
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
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i28.PaginaPerfilUsuarioPendiente(
          idUsuarioPendiente: args.idUsuarioPendiente,
          key: args.key,
        ),
      );
    },
    RutaRegistro.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i29.PaginaRegistro(),
      );
    },
    RutaSeleccionDeRol.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i30.PaginaSeleccionDeRol(),
      );
    },
    RutaSupervisionComisiones.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i31.PaginaSupervisionComisiones(),
      );
    },
    RutaSupervisionEnvioCalificaciones.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RutaSupervisionEnvioCalificacionesArgs>(
          orElse: () => RutaSupervisionEnvioCalificacionesArgs(
                idCurso: pathParams.getInt('idCurso'),
                fecha: pathParams.getString('fecha'),
              ));
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i32.PaginaSupervisionEnvioCalificaciones(
          idCurso: args.idCurso,
          fecha: args.fecha,
          key: args.key,
        ),
      );
    },
    RutaUsuariosPendientes.name: (routeData) {
      return _i34.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i33.PaginaUsuariosPendientes(),
      );
    },
  };
}

/// generated route for
/// [_i1.PaginaAdministrarPlantillas]
class RutaAdministrarPlantillas extends _i34.PageRouteInfo<void> {
  const RutaAdministrarPlantillas({List<_i34.PageRouteInfo>? children})
      : super(
          RutaAdministrarPlantillas.name,
          initialChildren: children,
        );

  static const String name = 'RutaAdministrarPlantillas';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i2.PaginaCalificacionesAnuales]
class RutaCalificacionesAnuales
    extends _i34.PageRouteInfo<RutaCalificacionesAnualesArgs> {
  RutaCalificacionesAnuales({
    required int idAsignatura,
    _i35.Key? key,
    List<_i34.PageRouteInfo>? children,
  }) : super(
          RutaCalificacionesAnuales.name,
          args: RutaCalificacionesAnualesArgs(
            idAsignatura: idAsignatura,
            key: key,
          ),
          rawPathParams: {'idAsignatura': idAsignatura},
          initialChildren: children,
        );

  static const String name = 'RutaCalificacionesAnuales';

  static const _i34.PageInfo<RutaCalificacionesAnualesArgs> page =
      _i34.PageInfo<RutaCalificacionesAnualesArgs>(name);
}

class RutaCalificacionesAnualesArgs {
  const RutaCalificacionesAnualesArgs({
    required this.idAsignatura,
    this.key,
  });

  final int idAsignatura;

  final _i35.Key? key;

  @override
  String toString() {
    return 'RutaCalificacionesAnualesArgs{idAsignatura: $idAsignatura, key: $key}';
  }
}

/// generated route for
/// [_i3.PaginaCalificacionesMensuales]
class RutaCalificacionesMensuales extends _i34.PageRouteInfo<void> {
  const RutaCalificacionesMensuales({List<_i34.PageRouteInfo>? children})
      : super(
          RutaCalificacionesMensuales.name,
          initialChildren: children,
        );

  static const String name = 'RutaCalificacionesMensuales';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i4.PaginaCargaDeCalificaciones]
class RutaCargaDeCalificaciones
    extends _i34.PageRouteInfo<RutaCargaDeCalificacionesArgs> {
  RutaCargaDeCalificaciones({
    required int idAsignatura,
    required int idComision,
    required String fecha,
    _i35.Key? key,
    List<_i34.PageRouteInfo>? children,
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

  static const _i34.PageInfo<RutaCargaDeCalificacionesArgs> page =
      _i34.PageInfo<RutaCargaDeCalificacionesArgs>(name);
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

  final _i35.Key? key;

  @override
  String toString() {
    return 'RutaCargaDeCalificacionesArgs{idAsignatura: $idAsignatura, idComision: $idComision, fecha: $fecha, key: $key}';
  }
}

/// generated route for
/// [_i5.PaginaComisiones]
class RutaComisiones extends _i34.PageRouteInfo<void> {
  const RutaComisiones({List<_i34.PageRouteInfo>? children})
      : super(
          RutaComisiones.name,
          initialChildren: children,
        );

  static const String name = 'RutaComisiones';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i6.PaginaComunicaciones]
class RutaComunicaciones extends _i34.PageRouteInfo<void> {
  const RutaComunicaciones({List<_i34.PageRouteInfo>? children})
      : super(
          RutaComunicaciones.name,
          initialChildren: children,
        );

  static const String name = 'RutaComunicaciones';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i7.PaginaComunicacionesCursos]
class RutaComunicacionesCursos extends _i34.PageRouteInfo<void> {
  const RutaComunicacionesCursos({List<_i34.PageRouteInfo>? children})
      : super(
          RutaComunicacionesCursos.name,
          initialChildren: children,
        );

  static const String name = 'RutaComunicacionesCursos';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i8.PaginaComunicacionesGeneral]
class RutaComunicacionesGeneral extends _i34.PageRouteInfo<void> {
  const RutaComunicacionesGeneral({List<_i34.PageRouteInfo>? children})
      : super(
          RutaComunicacionesGeneral.name,
          initialChildren: children,
        );

  static const String name = 'RutaComunicacionesGeneral';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i9.PaginaComunicacionesListaCursos]
class RutaComunicacionesListaCursos extends _i34.PageRouteInfo<void> {
  const RutaComunicacionesListaCursos({List<_i34.PageRouteInfo>? children})
      : super(
          RutaComunicacionesListaCursos.name,
          initialChildren: children,
        );

  static const String name = 'RutaComunicacionesListaCursos';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i10.PaginaComunicacionesPendientes]
class RutaComunicacionesPendientes extends _i34.PageRouteInfo<void> {
  const RutaComunicacionesPendientes({List<_i34.PageRouteInfo>? children})
      : super(
          RutaComunicacionesPendientes.name,
          initialChildren: children,
        );

  static const String name = 'RutaComunicacionesPendientes';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i11.PaginaComunidadAcademica]
class RutaComunidadAcademica extends _i34.PageRouteInfo<void> {
  const RutaComunidadAcademica({List<_i34.PageRouteInfo>? children})
      : super(
          RutaComunidadAcademica.name,
          initialChildren: children,
        );

  static const String name = 'RutaComunidadAcademica';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i12.PaginaDashboard]
class RutaDashboard extends _i34.PageRouteInfo<RutaDashboardArgs> {
  RutaDashboard({
    required _i36.Usuario usuario,
    required _i37.UserInfo userInfo,
    _i35.Key? key,
    List<_i34.PageRouteInfo>? children,
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

  static const _i34.PageInfo<RutaDashboardArgs> page =
      _i34.PageInfo<RutaDashboardArgs>(name);
}

class RutaDashboardArgs {
  const RutaDashboardArgs({
    required this.usuario,
    required this.userInfo,
    this.key,
  });

  final _i36.Usuario usuario;

  final _i37.UserInfo userInfo;

  final _i35.Key? key;

  @override
  String toString() {
    return 'RutaDashboardArgs{usuario: $usuario, userInfo: $userInfo, key: $key}';
  }
}

/// generated route for
/// [_i13.PaginaEspera]
class RutaEspera extends _i34.PageRouteInfo<void> {
  const RutaEspera({List<_i34.PageRouteInfo>? children})
      : super(
          RutaEspera.name,
          initialChildren: children,
        );

  static const String name = 'RutaEspera';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i14.PaginaFormulario]
class RutaFormulario extends _i34.PageRouteInfo<void> {
  const RutaFormulario({List<_i34.PageRouteInfo>? children})
      : super(
          RutaFormulario.name,
          initialChildren: children,
        );

  static const String name = 'RutaFormulario';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i15.PaginaGestionDeComision]
class RutaGestionDeComision
    extends _i34.PageRouteInfo<RutaGestionDeComisionArgs> {
  RutaGestionDeComision({
    required int idAsignatura,
    required int idComision,
    _i35.Key? key,
    List<_i34.PageRouteInfo>? children,
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

  static const _i34.PageInfo<RutaGestionDeComisionArgs> page =
      _i34.PageInfo<RutaGestionDeComisionArgs>(name);
}

class RutaGestionDeComisionArgs {
  const RutaGestionDeComisionArgs({
    required this.idAsignatura,
    required this.idComision,
    this.key,
  });

  final int idAsignatura;

  final int idComision;

  final _i35.Key? key;

  @override
  String toString() {
    return 'RutaGestionDeComisionArgs{idAsignatura: $idAsignatura, idComision: $idComision, key: $key}';
  }
}

/// generated route for
/// [_i16.PaginaInasistencia]
class RutaInasistencia extends _i34.PageRouteInfo<void> {
  const RutaInasistencia({List<_i34.PageRouteInfo>? children})
      : super(
          RutaInasistencia.name,
          initialChildren: children,
        );

  static const String name = 'RutaInasistencia';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i17.PaginaInicio]
class RutaInicio extends _i34.PageRouteInfo<void> {
  const RutaInicio({List<_i34.PageRouteInfo>? children})
      : super(
          RutaInicio.name,
          initialChildren: children,
        );

  static const String name = 'RutaInicio';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i18.PaginaKyc]
class RutaKyc extends _i34.PageRouteInfo<void> {
  const RutaKyc({List<_i34.PageRouteInfo>? children})
      : super(
          RutaKyc.name,
          initialChildren: children,
        );

  static const String name = 'RutaKyc';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i19.PaginaListaCursos]
class RutaListaCursos extends _i34.PageRouteInfo<void> {
  const RutaListaCursos({List<_i34.PageRouteInfo>? children})
      : super(
          RutaListaCursos.name,
          initialChildren: children,
        );

  static const String name = 'RutaListaCursos';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i20.PaginaListaDeComisiones]
class RutaListaDeComisiones extends _i34.PageRouteInfo<void> {
  const RutaListaDeComisiones({List<_i34.PageRouteInfo>? children})
      : super(
          RutaListaDeComisiones.name,
          initialChildren: children,
        );

  static const String name = 'RutaListaDeComisiones';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i21.PaginaListadoComunidad]
class RutaListadoComunidad
    extends _i34.PageRouteInfo<RutaListadoComunidadArgs> {
  RutaListadoComunidad({
    required int idRol,
    _i35.Key? key,
    List<_i34.PageRouteInfo>? children,
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

  static const _i34.PageInfo<RutaListadoComunidadArgs> page =
      _i34.PageInfo<RutaListadoComunidadArgs>(name);
}

class RutaListadoComunidadArgs {
  const RutaListadoComunidadArgs({
    required this.idRol,
    this.key,
  });

  final int idRol;

  final _i35.Key? key;

  @override
  String toString() {
    return 'RutaListadoComunidadArgs{idRol: $idRol, key: $key}';
  }
}

/// generated route for
/// [_i22.PaginaLogin]
class RutaLogin extends _i34.PageRouteInfo<void> {
  const RutaLogin({List<_i34.PageRouteInfo>? children})
      : super(
          RutaLogin.name,
          initialChildren: children,
        );

  static const String name = 'RutaLogin';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i23.PaginaMenuComunicaciones]
class RutaMenuComunicaciones extends _i34.PageRouteInfo<void> {
  const RutaMenuComunicaciones({List<_i34.PageRouteInfo>? children})
      : super(
          RutaMenuComunicaciones.name,
          initialChildren: children,
        );

  static const String name = 'RutaMenuComunicaciones';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i24.PaginaMenuComunidadAcademica]
class RutaMenuComunidadAcademica extends _i34.PageRouteInfo<void> {
  const RutaMenuComunidadAcademica({List<_i34.PageRouteInfo>? children})
      : super(
          RutaMenuComunidadAcademica.name,
          initialChildren: children,
        );

  static const String name = 'RutaMenuComunidadAcademica';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i25.PaginaMisCursos]
class RutaMisCursos extends _i34.PageRouteInfo<void> {
  const RutaMisCursos({List<_i34.PageRouteInfo>? children})
      : super(
          RutaMisCursos.name,
          initialChildren: children,
        );

  static const String name = 'RutaMisCursos';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i26.PaginaPerfilComunicados]
class RutaPerfilComunicados
    extends _i34.PageRouteInfo<RutaPerfilComunicadosArgs> {
  RutaPerfilComunicados({
    required int idUsuario,
    required String nombreUsuario,
    _i35.Key? key,
    List<_i34.PageRouteInfo>? children,
  }) : super(
          RutaPerfilComunicados.name,
          args: RutaPerfilComunicadosArgs(
            idUsuario: idUsuario,
            nombreUsuario: nombreUsuario,
            key: key,
          ),
          rawPathParams: {
            'idUsuario': idUsuario,
            'nombreUsuario': nombreUsuario,
          },
          initialChildren: children,
        );

  static const String name = 'RutaPerfilComunicados';

  static const _i34.PageInfo<RutaPerfilComunicadosArgs> page =
      _i34.PageInfo<RutaPerfilComunicadosArgs>(name);
}

class RutaPerfilComunicadosArgs {
  const RutaPerfilComunicadosArgs({
    required this.idUsuario,
    required this.nombreUsuario,
    this.key,
  });

  final int idUsuario;

  final String nombreUsuario;

  final _i35.Key? key;

  @override
  String toString() {
    return 'RutaPerfilComunicadosArgs{idUsuario: $idUsuario, nombreUsuario: $nombreUsuario, key: $key}';
  }
}

/// generated route for
/// [_i27.PaginaPerfilUsuario]
class RutaPerfilUsuario extends _i34.PageRouteInfo<RutaPerfilUsuarioArgs> {
  RutaPerfilUsuario({
    required int idUsuario,
    _i35.Key? key,
    List<_i34.PageRouteInfo>? children,
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

  static const _i34.PageInfo<RutaPerfilUsuarioArgs> page =
      _i34.PageInfo<RutaPerfilUsuarioArgs>(name);
}

class RutaPerfilUsuarioArgs {
  const RutaPerfilUsuarioArgs({
    required this.idUsuario,
    this.key,
  });

  final int idUsuario;

  final _i35.Key? key;

  @override
  String toString() {
    return 'RutaPerfilUsuarioArgs{idUsuario: $idUsuario, key: $key}';
  }
}

/// generated route for
/// [_i28.PaginaPerfilUsuarioPendiente]
class RutaPerfilUsuarioPendiente
    extends _i34.PageRouteInfo<RutaPerfilUsuarioPendienteArgs> {
  RutaPerfilUsuarioPendiente({
    required int idUsuarioPendiente,
    _i35.Key? key,
    List<_i34.PageRouteInfo>? children,
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

  static const _i34.PageInfo<RutaPerfilUsuarioPendienteArgs> page =
      _i34.PageInfo<RutaPerfilUsuarioPendienteArgs>(name);
}

class RutaPerfilUsuarioPendienteArgs {
  const RutaPerfilUsuarioPendienteArgs({
    required this.idUsuarioPendiente,
    this.key,
  });

  final int idUsuarioPendiente;

  final _i35.Key? key;

  @override
  String toString() {
    return 'RutaPerfilUsuarioPendienteArgs{idUsuarioPendiente: $idUsuarioPendiente, key: $key}';
  }
}

/// generated route for
/// [_i29.PaginaRegistro]
class RutaRegistro extends _i34.PageRouteInfo<void> {
  const RutaRegistro({List<_i34.PageRouteInfo>? children})
      : super(
          RutaRegistro.name,
          initialChildren: children,
        );

  static const String name = 'RutaRegistro';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i30.PaginaSeleccionDeRol]
class RutaSeleccionDeRol extends _i34.PageRouteInfo<void> {
  const RutaSeleccionDeRol({List<_i34.PageRouteInfo>? children})
      : super(
          RutaSeleccionDeRol.name,
          initialChildren: children,
        );

  static const String name = 'RutaSeleccionDeRol';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i31.PaginaSupervisionComisiones]
class RutaSupervisionComisiones extends _i34.PageRouteInfo<void> {
  const RutaSupervisionComisiones({List<_i34.PageRouteInfo>? children})
      : super(
          RutaSupervisionComisiones.name,
          initialChildren: children,
        );

  static const String name = 'RutaSupervisionComisiones';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}

/// generated route for
/// [_i32.PaginaSupervisionEnvioCalificaciones]
class RutaSupervisionEnvioCalificaciones
    extends _i34.PageRouteInfo<RutaSupervisionEnvioCalificacionesArgs> {
  RutaSupervisionEnvioCalificaciones({
    required int idCurso,
    required String fecha,
    _i35.Key? key,
    List<_i34.PageRouteInfo>? children,
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

  static const _i34.PageInfo<RutaSupervisionEnvioCalificacionesArgs> page =
      _i34.PageInfo<RutaSupervisionEnvioCalificacionesArgs>(name);
}

class RutaSupervisionEnvioCalificacionesArgs {
  const RutaSupervisionEnvioCalificacionesArgs({
    required this.idCurso,
    required this.fecha,
    this.key,
  });

  final int idCurso;

  final String fecha;

  final _i35.Key? key;

  @override
  String toString() {
    return 'RutaSupervisionEnvioCalificacionesArgs{idCurso: $idCurso, fecha: $fecha, key: $key}';
  }
}

/// generated route for
/// [_i33.PaginaUsuariosPendientes]
class RutaUsuariosPendientes extends _i34.PageRouteInfo<void> {
  const RutaUsuariosPendientes({List<_i34.PageRouteInfo>? children})
      : super(
          RutaUsuariosPendientes.name,
          initialChildren: children,
        );

  static const String name = 'RutaUsuariosPendientes';

  static const _i34.PageInfo<void> page = _i34.PageInfo<void>(name);
}
