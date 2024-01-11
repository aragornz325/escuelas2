import 'package:auto_route/auto_route.dart';
import 'package:escuelas_client/escuelas_client.dart';

import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/utilidades/cliente_serverpod.dart';

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
      return router.push<void>(
        RutaDashboard(
          // TODO(SAM): Eliminar y luego agarrar de localstorage/isar/etc
          userInfo: sessionManager.signedInUser!,
          usuario: Usuario(
            id: 10,
            idUserInfo: 2,
            nombre: 'John',
            apellido: 'Doe',
            urlFotoDePerfil: 'https://example.com/profile.jpg',
            dni: '123456789',
          ),
        ),
      );
    }

    return resolver.next();
  }
}
