part of 'bloc_drawer.dart';

/// {@template BlocDrawerEvento}
/// Clase padre de los eventos de [BlocDrawer]
/// {@endtemplate}
abstract class BlocDrawerEvento {
  /// {@macro BlocDrawerEvento}
  const BlocDrawerEvento();
}

/// {@template BlocDrawerEventoCerrarSesion}
/// Cierra sesion del usuario.
/// {@endtemplate}
class BlocDrawerEventoCerrarSesion extends BlocDrawerEvento {}

/// {@template BlocDrawerEventCambiarDeDrawerPage}
/// Cambia de Page en el Drawer seleccionado.
/// {@endtemplate}
class BlocDrawerEventoCambiarDeDrawerPage extends BlocDrawerEvento {
  BlocDrawerEventoCambiarDeDrawerPage();
  // {required this.pageDrawer});
// TODO(SAM): Descomentar si usamos este drawer
  /// Page de Drawer seleccionado a cambiar.
  // final DrawerPage pageDrawer;
}
