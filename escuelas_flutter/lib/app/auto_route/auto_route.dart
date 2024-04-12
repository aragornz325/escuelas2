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
          page: RutaRegistro.page,
          path: '/registro',
          guards: [initialGuard],
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
            CustomRoute(
              page: RutaPerfilUsuario.page,
              path: 'user-profile/:userId',
              transitionsBuilder: TransitionsBuilders.noTransition,
            ),
            CustomRoute(
              page: RutaPerfilUsuarioPendiente.page,
              path: 'pending-user-profile/:pendingUserId',
              transitionsBuilder: TransitionsBuilders.noTransition,
            ),
            CustomRoute(
              page: RutaEditarPerfil.page,
              path: 'edit-user-profile/:userId',
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
            AutoRoute(
              page: RutaListaDeComisiones.page,
              path: 'list-commissions',
              children: [
                AutoRoute(
                  page: RutaComisiones.page,
                  path: 'commissions',
                  initial: true,
                ),
                AutoRoute(
                  page: RutaGestionDeComision.page,
                  path: 'commission-management/:idComision/:idAsignatura',
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
              page: RutaCalificacionesMensuales.page,
              path: 'grades',
            ),
            AutoRoute(
              page: RutaComunicaciones.page,
              path: 'communications',
              children: [
                AutoRoute(
                  page: RutaMenuComunicaciones.page,
                  path: 'menu-communications',
                  initial: true,
                ),
                AutoRoute(
                  page: RutaComunicacionesPendientes.page,
                  path: 'pending-communications',
                ),
                AutoRoute(
                  page: RutaAdministrarPlantillas.page,
                  path: 'manage-templates',
                ),
                AutoRoute(
                  page: RutaComunicacionesGeneral.page,
                  path: 'general-communications',
                ),
                AutoRoute(
                  page: RutaComunicacionesCursos.page,
                  path: 'course-communications',
                  children: [
                    AutoRoute(
                      initial: true,
                      page: RutaComunicacionesListaCursos.page,
                      path: 'courses',
                    ),
                    AutoRoute(
                      page: RutaPerfilComunicados.page,
                      path: 'communication-profile/:nombreUsuario/:idUsuario',
                    ),
                  ],
                ),
              ],
            ),
            AutoRoute(
              page: RutaCalificacionesAnuales.page,
              path: 'anual-grades/:idAsignatura',
            ),
            AutoRoute(
              page: RutaSupervision.page,
              path: 'supervision',
              children: [
                AutoRoute(
                  page: RutaSupervisionComisiones.page,
                  path: 'course-supervision',
                  initial: true,
                ),
                AutoRoute(
                  page: RutaSupervisionEnvioCalificaciones.page,
                  path: 'grade-submission-supervision/:idComision/:fecha',
                ),
                AutoRoute(
                  page: RutaSupervisionAsignatura.page,
                  path: 'subject-supervision/:idAsignatura/:idComision/:fecha',
                ),
              ],
            ),
            AutoRoute(
              page: RutaAdministrarPlantillas.page,
              path: 'manage-templates',
            ),
          ],
        ),
      ];
}
