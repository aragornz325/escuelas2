import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
// import 'package:escuelas_flutter/app/auto_route/router_guards.dart';
// import 'package:escuelas_flutter/utilidades/utilidades.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  AppRouter();

  @override
  RouteType get defaultRouteType => const RouteType.material();

  /// Se encarga de proteger las rutas que requieren
  /// que el usuario este deslogueado, en caso de que
  /// el usuario este logueado y quiera dirigirse a este tipo
  /// de paginas, sera redireccionado a [RutaDashboard]
  // InitialGuard get initialGuard => InitialGuard(
  //       sessionManager: sessionManager,
  //     );

  // /// Se encarga de proteger las rutas que requieren
  // /// que el usuario este loggeado, en caso de que
  // /// el usuario este deslogueado y quiera dirigirse a este tipo
  // /// de paginas, sera redireccionado a [RutaLogin]
  // AuthGuard get authGuard => AuthGuard(
  //       sessionManager: sessionManager,
  //     );

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          initial: true,
          page: PaginaLogin.page,
          path: '/login',
          // guards: [initialGuard],
        ),
        CustomRoute(
          page: PaginaKyc.page,
          path: '/kyc',
          // guards: [initialGuard],
          transitionsBuilder: TransitionsBuilders.noTransition,
          children: [
            CustomRoute(
              page: PaginaSeleccionDeRol.page,
              initial: true,
              path: 'role-selection',
              // guards: [authGuard],
              transitionsBuilder: TransitionsBuilders.noTransition,
            ),
            CustomRoute(
              page: PaginaFormulario.page,
              path: 'form',
              // guards: [authGuard],
              transitionsBuilder: TransitionsBuilders.noTransition,
            ),
          ],
        ),
        AutoRoute(
          page: PaginaPerfilUsuario.page,
          path: '/perfil-usuario/:idUsuario',
          // guards: [initialGuard],
        ),
        AutoRoute(
          page: PaginaAsistencia.page,
          path: '/Attendance',
          // guards: [initialGuard],
        ),
      ];
}
