import 'package:auto_route/auto_route.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/features/auth/kyc/bloc/bloc_kyc.dart';
import 'package:escuelas_flutter/features/dashboard/bloc_dashboard/bloc_dashboard.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/editar_perfil/bloc/bloc_editar_perfil.dart';
import 'package:escuelas_flutter/widgets/drawer/bloc/bloc_drawer.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serverpod_auth_client/module.dart';

/// {@template PaginaDashboard}
/// Pagina padre donde se manejan todas las rutas del usuario
/// una vez logueado, el body se va a dibujar segun la ruta en
/// la que se encuentre en este momento.
/// {@endtemplate}
@RoutePage()
class PaginaDashboard extends StatefulWidget {
  /// {@macro PaginaDashboard}
  const PaginaDashboard({
    required this.usuario,
    required this.userInfo,
    super.key,
  });

  /// Usuario de la base de datos, que tiene info referida a los roles
  /// y de la persona
  final Usuario usuario;

  /// Usuario de la sesion del cliente.
  final UserInfo userInfo;

  @override
  State<PaginaDashboard> createState() => _PaginaDashboardState();
}

class _PaginaDashboardState extends State<PaginaDashboard> {
  /// Cambia el index segun la ruta seleccionada
  int _indexSegunRuta(BuildContext context) {
    return switch (context.router.current.name) {
      RutaPerfilUsuario.name => 2,
      RutaEditarPerfil.name => 2,
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
          create: (context) => BlocDashboard(
            infoUsuario: widget.userInfo,
            usuario: widget.usuario,
          )..add(const BlocDashboardEventoInicializar()),
        ),
        BlocProvider<BlocKyc>(
          create: (context) => BlocKyc()..add(const BlocKycEventoInicializar()),
        ),
        BlocProvider<BlocEditarPerfil>(
          create: (context) => BlocEditarPerfil(),
        ),
      ],
      child: BlocBuilder<BlocDashboard, BlocDashboardEstado>(
        builder: (context, state) {
          return EscuelasConfirmarCerrarApp(
            child: AutoRouter(
              builder: (context, content) => EscuelasScaffold(
                tieneAppBar: true,
                tieneBottomNavBar: true,
                index: _indexSegunRuta(context),
                cuerpo: content,
              ),
            ),
          );
        },
      ),
    );
  }
}
