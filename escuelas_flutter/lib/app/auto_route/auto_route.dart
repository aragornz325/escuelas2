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
        AutoRoute(
          page: RutaLogin.page,
          path: '/login',
          guards: [initialGuard],
          initial: true,
        ),
        AutoRoute(
          page: RutaKyc.page,
          path: '/kyc',
          // TODO(anyone): Agregar guard para que solo los usuarios no aprobados
          // puedan acceder (o que nadie pueda acceder cambiando el path)
          guards: [authGuard],
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
            AutoRoute(
              page: RutaEspera.page,
              path: 'await-approval',
            ),
          ],
        ),
        AutoRoute(
          path: '/dashboard',
          page: RutaDashboard.page,
          guards: [authGuard],
          children: [
            AutoRoute(
              page: RutaInicio.page,
              path: 'home',
              initial: true,
            ),
            AutoRoute(
              page: RutaPerfilUsuario.page,
              path: 'user-profile/:userId',
              children: [
                AutoRoute(
                  page: RutaKycEdicionUsuario.page,
                  path: 'kyc-edit-user/:userId',
                ),
              ],
            ),
            CustomRoute(
              page: RutaPerfilUsuarioPendiente.page,
              path: 'pending-user-profile/:pendingUserId',
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
              page: RutaUsuariosPendientes.page,
              path: 'pending-users',
              transitionsBuilder: TransitionsBuilders.noTransition,
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
            AutoRoute(
              page: RutaInasistencia.page,
              path: 'absences',
            ),
            AutoRoute(
              page: RutaSupervisionCursos.page,
              path: 'course-supervision',
            ),
            AutoRoute(
              page: RutaSupervisionEnvioCalificaciones.page,
              path: 'grade-submission-supervision/:idComision/:fecha',
            ),
          ],
        ),
      ];
}
