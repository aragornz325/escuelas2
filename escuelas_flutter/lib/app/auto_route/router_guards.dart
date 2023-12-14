// import 'package:auto_route/auto_route.dart';

// // ignore: depend_on_referenced_packages
// import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

// /// {@template AuthGuard}
// /// Esto se encarga de que el que navegue por la app verifique que
// /// este registrado en la app
// /// {@endtemplate}
// class AuthGuard extends AutoRouteGuard {
//   AuthGuard({
//     required SessionManager sessionManager,
//   }) : _sessionManager = sessionManager;

//   final SessionManager _sessionManager;

//   @override
//   Future<void> onNavigation(
//     NavigationResolver resolver,
//     StackRouter router,
//   ) async {
//     final isSignedIn = _sessionManager.isSignedIn;
//     // TODO(anyone) : aca tendria que esta la pagina principal del login
//     if (!isSignedIn) {
//       // ejemplo
//       // return router.replace<void>(const routeLogin());
//     }

//     return resolver.next();
//   }
// }

// /// {@template InitialGuard}
// /// Esto se encarga de que si entro alguien que esta logeado lo navegue al home
// /// de la app
// /// {@endtemplate}
// class InitialGuard extends AutoRouteGuard {
//   InitialGuard({
//     required SessionManager sessionManager,
//   }) : _sessionManager = sessionManager;

//   final SessionManager _sessionManager;

//   @override
//   Future<void> onNavigation(
//     NavigationResolver resolver,
//     StackRouter router,
//   ) async {
//     final isSignedIn = _sessionManager.isSignedIn;
//     // TODO(anyone) : aca tendria que esta la pagina principal que sea el dashboard
//     if (isSignedIn) {
//       //ejemplo:
//       // return router.push<void>(RouteDashboard());
//     }

//     return resolver.next();
//   }
// }
