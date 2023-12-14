import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route_observer.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_app.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return FullResponsiveApp(
      child: MultiBlocProvider(
        providers: const [
          /// TODO: Add providers
        ],
        child: const AppView(),
      ),
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
    appRouter = AppRouter();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ScrollConfiguration(
        behavior: NoGlowBehavior(),
        child: child!,
      ),
      routerDelegate: AutoRouterDelegate(
        appRouter,
        navigatorObservers: () => [RouterObserver()],
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
