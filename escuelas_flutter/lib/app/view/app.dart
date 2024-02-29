import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route_observer.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/one_signal/one_signal_servicio.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_app.g.dart';
import 'package:escuelas_flutter/theming/tema/tema_default_light_escuelas.dart';

import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return FullResponsiveApp(
      child: const AppView(),
    );
  }
}

/// {@template AppView}
/// Es la estructura general de la aplicación.También
/// inicializa `AppRouter` para fines de manejo de rutas/routes.
/// {@endtemplate}
class AppView extends StatefulWidget {
  /// {@macro AppView}
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  late AppRouter appRouter;

  @override
  void initState() {
    super.initState();
    appRouter = AppRouter();
    OneSignalServicio.notificationHandler(appRouter: appRouter);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: AutoRouterDelegate(
        appRouter,
        navigatorObservers: () => [RouterObserver()],
        // TODO(ANYONE): Carry over, por el momento este builder no esta funcionando
        // (redirigir a la ruta o frenar con breakpoint)
        // Es posible que sea por GitHub pages y con un link real si ande,
        // habria que testear en un dispositivo real.
        // Tambien una vez que ande probar de agregar Switch.
        deepLinkBuilder: (deepLink) {
          // Redirige a esa ruta si empieza con /absences
          if (deepLink.path.contains('absences')) {
            // TODO(ANYONE): Poner la ruta a la cual redirigir, por el momento no permite ir a inasistencia pero si a KYC.
            return const DeepLink([RutaInasistencia()]);
          } else {
            // Ruta default del deeplink
            return const DeepLink([RutaLogin()]);
          }
        },
      ),
      theme: temaPorDefectoEscuelas,
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ScrollConfiguration(
        behavior: NoGlowBehavior(),
        child: child!,
      ),
      routeInformationParser: appRouter.defaultRouteParser(),
      localizationsDelegates: const [
        ...AppLocalizations.localizationsDelegates,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

/// {@template no_glow_behavior}
/// sirve para sacar el efecto de la ola azul del inico y final
/// en los scrollView
/// {@endtemplate}
class NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) =>
      child;
}
