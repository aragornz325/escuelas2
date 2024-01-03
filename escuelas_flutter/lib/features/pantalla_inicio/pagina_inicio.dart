import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/pantalla_inicio/bloc/bloc_inicio.dart';
import 'package:escuelas_flutter/features/pantalla_inicio/celular/vista_celular_inicio.dart';
import 'package:escuelas_flutter/features/pantalla_inicio/escritorio/vista_escritorio_inicio.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaInicio}
/// Pagina de visualización Inicio, el usuario puede tener acceso
/// a las distintas opciones correspondientes a sus permisos, pudiendo
/// redirigirse.
/// {@endtemplate}
@RoutePage()
class PaginaInicio extends StatefulWidget {
  /// {@macro PaginaInicio}
  const PaginaInicio({
    super.key,
    this.userInfo,
  });
  final InfoUsuario? userInfo;

  @override
  State<PaginaInicio> createState() => _PaginaInicioState();
}

class _PaginaInicioState extends State<PaginaInicio> {
  @override
  void initState() {
    // TODO(SAM): Descomentar cuadno esten las route guards y lo de serverpod
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
    // infoUsuario = widget.userInfo ?? usuario;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocInicio>(
      create: (context) => BlocInicio(
        widget.userInfo ??
            InfoUsuario(
              nombre: 'Pepe Silva',
              permiso: [Permiso.directivo],
            ),
      ), // TODO(SAM): Remover luego, analizar como hacer.
      child: const FullResponsiveScreen(
        celular: VistaCelularInicio(),
        escritorio: VistaEscritorioInicio(),
      ),
    );
  }
}
