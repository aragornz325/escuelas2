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
        AutoRoute(
          page: RutaPerfilUsuario.page,
          path: '/perfil-usuario/:idUsuario',
          // guards: [initialGuard],
        ),
        AutoRoute(
          page: RutaLogin.page,
          path: '/login',
          initial: true,
          //    guards: [initialGuard],
        ),
        CustomRoute(
          path: '/dashboard',
          page: RutaDashboard.page,
          // initial: true,
          transitionsBuilder: TransitionsBuilders.noTransition,
          // guards: [initialGuard],

          children: [
            AutoRoute(
              initial: true,
              page: RutaInicio.page,
              path: 'home',
              // guards: [initialGuard],
            ),
            CustomRoute(
              page: RutaFormulario.page,
              path: 'form',
              // guards: [authGuard],
              transitionsBuilder: TransitionsBuilders.noTransition,
            ),
            AutoRoute(
              page: RutaSeleccionDeRol.page,
              path: 'role-selection',
              //   initial: true,
              // guards: [initialGuard],
            ),
            AutoRoute(
              page: RutaKyc.page,
              path: 'kyc-form',
              // guards: [initialGuard],
            ),
            AutoRoute(
              page: RutaInasistencia.page,
              path: 'absences',
              // guards: [initialGuard],
            ),
          ],
        ),
      ];
}
