import 'package:auto_route/auto_route.dart';
import 'package:escuelas_client/escuelas_client.dart';

import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/isar/isar_servicio.dart';
import 'package:escuelas_flutter/utilidades/cliente_serverpod.dart';
import 'package:escuelas_flutter/utilidades/funciones/cerrar_sesion_usuario.dart';

import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

/// {@template AuthGuard}
/// Esto se encarga de que el usuario que navegue por la app verifique que
/// el mismo este logueado en la app.
/// {@endtemplate}
class AuthGuard extends AutoRouteGuard {
  AuthGuard({
    required SessionManager sessionManager,
  }) : _sessionManager = sessionManager;

  final SessionManager _sessionManager;

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final isSignedIn = _sessionManager.isSignedIn;

    if (!isSignedIn) {
      return router.replace<void>(const RutaLogin());
    }

    return resolver.next();
  }
}

/// {@template InitialGuard}
/// Esto se encarga de que si entro alguien que esta logeado lo navegue al home
/// de la app
/// {@endtemplate}
class InitialGuard extends AutoRouteGuard {
  InitialGuard({
    required SessionManager sessionManager,
  }) : _sessionManager = sessionManager;

  final SessionManager _sessionManager;

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final isSignedIn = _sessionManager.isSignedIn;

    if (isSignedIn) {
      final usuarioLocal = await IsarServicio.traerUsuarioActual();

      if (usuarioLocal != null) {
        return router.push<void>(
          RutaDashboard(
            userInfo: sessionManager.signedInUser!,
            usuario: usuarioLocal,
          ),
        );
      }

      UsuarioPendiente usuarioPendiente;
      try {
        usuarioPendiente = await IsarServicio.traerUsuariosPendientes();
      } catch (e) {
        await cerrarSesionUsuario();
        return router.replace<void>(
          const RutaLogin(),
        );
      }

      switch (usuarioPendiente.estadoDeSolicitud) {
        case EstadoDeSolicitud.aprobado:
          return router.replace<void>(
            const RutaLogin(),
          );

        case EstadoDeSolicitud.pendiente:
          return router.replace<void>(
            const RutaEspera(),
          );
        case EstadoDeSolicitud.rechazado:
          await cerrarSesionUsuario();

          return router.replace<void>(
            const RutaLogin(),
          );
      }
    }

    return resolver.next();
  }
}
