import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';

/// {@template RouterObserver}
/// Esto se encarga de llamar a la funcion obtenerNombreRuta para poder poner
/// el titulo de cada page hija de Dashboard
/// {@endtemplate}
class DashboardRouterObserver extends AutoRouterObserver {
  /// {@macro DashboardRouterObserver}
  DashboardRouterObserver(this.context);

  final BuildContext context;
// TODO(ANYONE): Todavia no hace nada
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {}

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {}
}
