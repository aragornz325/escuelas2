import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/app/auto_route/router_guards.dart';
import 'package:escuelas_flutter/utilidades/cliente_serverpod.dart';
// import 'package:escuelas_flutter/app/auto_route/router_guards.dart';
// import 'package:escuelas_flutter/utilidades/utilidades.dart';

@AutoRouterConfig(replaceInRouteName: 'Pagina,Ruta')
class AppRouter extends $AppRouter {
  AppRouter();

  @override
  RouteType get defaultRouteType => const RouteType.material();

  // / Se encarga de proteger las rutas que requieren
  // / que el usuario este deslogueado, en caso de que
  // / el usuario este logueado y quiera dirigirse a este tipo
  // / de paginas, sera redireccionado a [RutaDashboard]
  InitialGuard get initialGuard => InitialGuard(
        sessionManager: sessionManager,
      );

  /// Se encarga de proteger las rutas que requieren
  /// que el usuario este loggeado, en caso de que
  /// el usuario este deslogueado y quiera dirigirse a este tipo
  /// de paginas, sera redireccionado a [RutaLogin]
  AuthGuard get authGuard => AuthGuard(
        sessionManager: sessionManager,
      );

  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          page: RutaLogin.page,
          path: '/login',
          // guards: [initialGuard],
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        AutoRoute(
          path: '/dashboard',
          initial: true,
          page: RutaDashboard.page,
          // guards: [authGuard],
          children: [
            AutoRoute(
              page: RutaInicio.page,
              initial: true,
              path: 'home',
            ),
            CustomRoute(
              page: RutaPerfilUsuario.page,
              path: 'perfil-usuario/:idUsuario',
              transitionsBuilder: TransitionsBuilders.noTransition,
            ),
            AutoRoute(
              page: RutaListaCursos.page,
              path: 'courses',
              children: [
                AutoRoute(
                  page: RutaMisCursos.page,
                  path: 'my-courses',
                  initial: true,
                ),
                AutoRoute(
                  page: RutaCargaDeCalificaciones.page,
                  path: 'upload-grades',
                ),
              ],
            ),
            CustomRoute(
              page: RutaAsignacionDeRoles.page,
              path: 'role-assignment',
              transitionsBuilder: TransitionsBuilders.noTransition,
            ),
            AutoRoute(
              page: RutaKyc.page,
              path: 'kyc',
              children: [
                AutoRoute(
                  page: RutaSeleccionDeRol.page,
                  path: 'role-selection',
                  initial: true,
                ),
                AutoRoute(
                  page: RutaFormulario.page,
                  path: 'form',
                ),
              ],
            ),
            AutoRoute(
              page: RutaComunidadAcademica.page,
              path: 'academic-community',
              children: [
                AutoRoute(
                  page: RutaMenuComunidadAcademica.page,
                  path: 'menu',
                  initial: true,
                ),
                AutoRoute(
                  page: RutaListadoComunidad.page,
                  path: 'list/:idRol',
                ),
              ],
            ),
            CustomRoute(
              page: RutaInasistencia.page,
              path: 'absences',
              transitionsBuilder: TransitionsBuilders.noTransition,
            ),
            AutoRoute(
              page: RutaSupervisionCursos.page,
              path: 'course-supervision',
            ),
            AutoRoute(
              page: RutaSupervisionEnvioCalificaciones.page,
              path: 'grade-submission-supervision/:idCurso/:fecha',
            ),
          ],
        ),
      ];
}
