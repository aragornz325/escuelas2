import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/features/auth/kyc/bloc/bloc_kyc.dart';
import 'package:escuelas_flutter/utilidades/cliente_serverpod.dart';
import 'package:escuelas_flutter/utilidades/funciones/cerrar_sesion_usuario.dart';
import 'package:escuelas_flutter/widgets/drawer/bloc/bloc_drawer.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template VistaEscritorioKyc}
/// Pagina de la pantalla 'Kyc'
/// {@endtemplate}
@RoutePage()
class PaginaKyc extends StatefulWidget {
  /// {@macro PaginaKyc}
  const PaginaKyc({super.key});

  @override
  State<PaginaKyc> createState() => _PaginaKycState();
}

class _PaginaKycState extends State<PaginaKyc> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // TODO(ANYONE): Cambiar luego a mejorar la arquitectura del KYC guard
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive) {
      cerrarSesionUsuario();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BlocDrawer>(
          create: (context) => BlocDrawer(),
        ),
        BlocProvider<BlocKyc>(
          create: (context) => BlocKyc()..add(const BlocKycEventoInicializar()),
        ),
      ],
      child: AutoRouter(
        builder: (context, content) {
          return EscuelasConfirmarCerrarApp(
            child: EscuelasScaffold(
              tieneDrawer: false,
              cuerpo: BlocListener<BlocKyc, BlocKycEstado>(
                listener: (context, state) {
                  if (state is BlocKycEstadoExitoSolicitudAprobada) {
                    context.replaceRoute(
                      RutaDashboard(
                        usuario: state.usuario,
                        userInfo: sessionManager.signedInUser!,
                      ),
                    );
                  }
                },
                child: switch (context.router.current.name) {
                  RutaSeleccionDeRol.name => content,
                  RutaFormulario.name => content,
                  RutaEspera.name => content,
                  _ => const SizedBox.shrink()
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
