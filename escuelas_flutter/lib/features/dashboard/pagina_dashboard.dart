import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/app/auto_route/dashboard_router_observer.dart';
import 'package:escuelas_flutter/features/auth/kyc/bloc/bloc_kyc.dart';

import 'package:escuelas_flutter/features/dashboard/bloc_dashboard/bloc_dashboard.dart';
import 'package:escuelas_flutter/features/pantalla_inicio/bloc/bloc_inicio.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';

import 'package:escuelas_flutter/widgets/drawer/bloc/bloc_drawer.dart';
import 'package:escuelas_flutter/widgets/selector_de_fecha/bloc/bloc_selector_de_fecha.dart';

import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template PaginaDashboard}
/// Pagina padre donde se manejan todas las rutas del usuario
/// una vez logueado, el body se va a dibujar segun la ruta en
/// la que se encuentre en este momento.
/// {@endtemplate}
@RoutePage()
class PaginaDashboard extends StatefulWidget {
  /// {@macro PaginaDashboard}
  const PaginaDashboard({
    super.key,
    this.userInfo,
  });
  final InfoUsuario? userInfo;
  // TODO(SAM): Analizar y ver que el usuario no sea nulo se lo paso por parametro.

  @override
  State<PaginaDashboard> createState() => _PaginaDashboardState();
}

class _PaginaDashboardState extends State<PaginaDashboard> {
  late final InfoUsuario infoUsuario;

  @override
  void initState() {
    super.initState();
    // TODO(ANYONE): Descomentar
    // final usuario = sessionManager.signedInUser;

    // if (usuario == null) {
    //   return onErrorCustom.call(
    //     ExcepcionCustom(
    //       titulo: 'User not found',
    //       mensaje: 'User not found, session null',
    //       tipoDeError: TipoExcepcion.noAutorizado,
    //       codigoError: 403,
    //     ),
    //   );
    // }
    infoUsuario = InfoUsuario(nombre: 'Leo', permiso: [Permiso.directivo]);
    // context.router.push(
    //         RutaInicio(),
    //       );
    // infoUsuario = widget.userInfo ?? usuario;
  }
  // TODO(SAM): Si es exitoso el KYC redirigir a ruta inicio.
  // TODO(SAM): Si no esta logueado lo checkea el guard, no hace falta redirigir.

  /// Se muestra este dialog cuando el usuario se registra, luego de completar
  /// los datos del KYC exitosamente y presionar el boton continue finalizando
  /// su registro, para redirigirlo a la home screen.
  void _showSuccessKYCDialog(BuildContext context) {
    final l10n = context.l10n;
    showDialog<void>(
      context: context,
      builder: (_) => EscuelasDialog.exitoso(
        content: Column(
          children: [
            SizedBox(
              height: 20.ph,
            ),
            Center(
              child: Text(
                l10n.pageKycSuccessDialogDescription,
                style: TextStyle(fontSize: 18.pf),
              ),
            ),
          ],
        ),
        context: context,
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  int indexSegunRuta(BuildContext context) {
    return switch (context.router.current.name) {
      RutaPerfilUsuario.name => 2,
      _ => 0
    };
  }

  @override
  Widget build(BuildContext context) {
    AutoRouter.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<BlocDrawer>(
          create: (context) => BlocDrawer(),
        ),
        BlocProvider<BlocDashboard>(
          create: (context) => BlocDashboard(infoUsuario)
            ..add(BlocDashboardEventoTraerInformacion()),
        ),
        BlocProvider<BlocSelectorDeFecha>(
          create: (context) => BlocSelectorDeFecha(),
        ),
        BlocProvider<BlocKyc>(
          create: (context) => BlocKyc()..add(const BlocKycEventoInicializar()),
        ),
      ],
      child: BlocListener<BlocKyc, BlocKycEstado>(
        listener: (context, state) {
          if (state is BlocKycEstadoExitoso) {
            context.read<BlocDashboard>().add(
                  // TODO(ANYONE): Verificar cual va todos estos eventos y cosas de usuario registracion
                  BlocDashboardEventoTraerInformacion(),
                  // BlocDashboardEventoActualizarInfoUsuario(
                  //   nombreCompletoUsuario: state.nombreCompleto,
                  // ),
                );

            _showSuccessKYCDialog(context);
          }
        },
        child: BlocConsumer<BlocDashboard, BlocDashboardEstado>(
          listener: (context, state) {
            // TODO(SAM): Verificar ruteo aca, cuando se llega de registro / login
            // if (state is BlocDashboardEstadoExitoso) {
            //   context.router.push(
            //     RutaInicio(),
            //   );
            // }

            if (state is BlocDashboardEstadoFaltaCompletarKyc) {
              context.router.replace(const RutaSeleccionDeRol());
            }
          },
          builder: (context, state) {
            return AutoRouter(
              navigatorObservers: () => [DashboardRouterObserver(context)],
              builder: (context, content) => EscuelasScaffold(
                index: indexSegunRuta(context),
                cuerpo: content,
              ),
            );
          },
        ),
      ),
    );
  }
}
