import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
// import 'package:escuelas_flutter/app/auto_route/router_guards.dart';
// import 'package:escuelas_flutter/utilidades/utilidades.dart';

@AutoRouterConfig(replaceInRouteName: 'Pagina,Ruta')
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
// TODO(ANYONE): En algun momento descomentar los guards
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          page: RutaLogin.page,
          path: '/login',
          initial: true,
          //    guards: [initialGuard],
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          path: '/dashboard',
          page: RutaDashboard.page,
          // initial: true,
          transitionsBuilder: TransitionsBuilders.noTransition,
          // guards: [initialGuard],
          children: [
            CustomRoute(
              page: RutaInicio.page,
              path: 'home',
              // guards: [initialGuard],
              transitionsBuilder: TransitionsBuilders.noTransition,
            ),
            CustomRoute(
              page: RutaPerfilUsuario.page,
              path: 'perfil-usuario/:idUsuario',
              // guards: [initialGuard],
              transitionsBuilder: TransitionsBuilders.noTransition,
            ),
            CustomRoute(
              page: RutaMisCursos.page,
              path: 'courses-list',
              // guards: [authGuard],
              transitionsBuilder: TransitionsBuilders.noTransition,
            ),
            CustomRoute(
              page: RutaAsignacionDeRoles.page,
              initial: true,
              path: 'role-assignment',
              // guards: [authGuard],
              transitionsBuilder: TransitionsBuilders.noTransition,
            ),
            CustomRoute(
              page: RutaKyc.page,
              path: 'kyc',
              // guards: [authGuard],
              transitionsBuilder: TransitionsBuilders.noTransition,
              children: [
                CustomRoute(
                  page: RutaSeleccionDeRol.page,
                  path: 'role-selection',
                  initial: true,
                  // guards: [initialGuard],
                  transitionsBuilder: TransitionsBuilders.noTransition,
                ),
                CustomRoute(
                  page: RutaFormulario.page,
                  path: 'form',
                  // guards: [initialGuard],
                  transitionsBuilder: TransitionsBuilders.noTransition,
                ),
              ],
            ),
            CustomRoute(
              page: RutaInasistencia.page,
              path: 'absences',
              // guards: [initialGuard],
              transitionsBuilder: TransitionsBuilders.noTransition,
            ),
          ],
        ),
      ];
}
