part of 'bloc_drawer.dart';

/// {@template BlocDrawerEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
/// {@endtemplate}
class BlocDrawerEstado {
  /// {@macro BlocDrawerEstado}
  const BlocDrawerEstado._({
    this.cerroSesion = false,
    // this.pageDrawer = DrawerPage.home,
  });
// TODO(SAM): Analizar si descomentar pagedrawer.
  BlocDrawerEstado.desde(
    BlocDrawerEstado otro, {
    bool? cerroSesion,
    //DrawerPage? pageDrawer,
  }) : this._(
          cerroSesion: cerroSesion ?? otro.cerroSesion,
          //    pageDrawer: pageDrawer ?? otro.pageDrawer,
        );

  /// Indica si se cerro la sesion o no del usuario, se almacena en el bloc
  /// para redirigir a la vista login.
  final bool? cerroSesion;

  /// Page de Drawer seleccionado.
  // final DrawerPage pageDrawer;
}

/// {@template BlocAdministracionMarcasEstadoInicial}
/// Estado inicial de los componentes de la pantalla [BlocDrawer]
/// {@endtemplate}
class BlocDrawerEstadoInicial extends BlocDrawerEstado {
  /// {@macro BlocAdministracionMarcasEstadoInicial}
  const BlocDrawerEstadoInicial() : super._();
}

/// {@template BlocAdministracionMarcasEstadoCargando}
/// Estado de cargando de los componentes de la pantalla [BlocDrawer]
/// {@endtemplate}
class BlocDrawerEstadoCargando extends BlocDrawerEstado {
  /// {@macro BlocAdministracionMarcasEstadoCargando}
  BlocDrawerEstadoCargando.desde(
    super.otro,
  ) : super.desde();
}

/// {@template BlocAdministracionMarcasEstadoExitosoGeneral}
/// Estado exitoso general de los componentes de la pantalla [BlocDrawer]
/// {@endtemplate}
class BlocDrawerEstadoExitosoGeneral extends BlocDrawerEstado {
  /// {@macro BlocAdministracionMarcasEstadoExitosoGeneral}
  BlocDrawerEstadoExitosoGeneral.desde(
    super.otro, {
    super.cerroSesion,
    //   super.pageDrawer,
  }) : super.desde();
}

/// {@template BlocDrawerEstadoCambioDePagina}
/// Estado que indica el cambio de página dentro del dashboard.
/// {@endtemplate}
class BlocDrawerEstadoCambioDePagina extends BlocDrawerEstado {
  /// {@macro BlocDrawerEstadoCambioDePagina}
  BlocDrawerEstadoCambioDePagina.desde(
    super.otro,
//    required super.pageDrawer,
  ) : super.desde();
}

/// {@template BlocAdministracionMarcasEstadoError}
/// Estado de error de los componentes de la pantalla [BlocDrawer]
/// {@endtemplate}
class BlocDrawerEstadoError extends BlocDrawerEstado {
  /// {@macro BlocAdministracionMarcasEstadoError}
  BlocDrawerEstadoError.desde(super.otro) : super.desde();
}
