import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/extensiones/usuario.dart';
import 'package:escuelas_flutter/features/dashboard/bloc_dashboard/bloc_dashboard.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/utilidades/enum_menu_opciones_comunicaciones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/elemento_lista.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template MenuOpcionesDeComunicaciones}
/// Muestra una lista de opciones de navegacion que el usuario ve segun
/// sus Comunicaciones
/// {@endtemplate}
class MenuOpcionesDeComunicaciones extends StatelessWidget {
  /// {@macro MenuOpcionesDeComunicaciones}
  const MenuOpcionesDeComunicaciones({super.key});

  /// Devuelve de acuerdo al usuario su lista de vistas permitidas.
  List<MenuOpcionesComunicaciones> _menusPermitidos(BuildContext context) {
    final usuario = context.read<BlocDashboard>().state.usuario;

    return MenuOpcionesComunicaciones.values
        .where(
          (opcion) => opcion.permisosRequeridos.every(
            usuario.tienePermisos,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    final menus = _menusPermitidos(context);

    return Column(
      children: menus
          .map(
            (menu) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.ph)
                  .copyWith(bottom: 15.ph),
              child: ElementoLista.menu(
                // TODO(SAM): Agregar para notif circulo rojo
                // widgetLateralDerecho:
                //     menu.name == MenuOpcionesDeInicio.notifPendientes.name &&
                //             state.hayUsuariosPendientes
                //         ? Padding(
                //             padding: EdgeInsets.only(right: 20.pw),
                //             child: Icon(
                //               Icons.circle,
                //               color: colores.error,
                //               size: 15.sw,
                //             ),
                //           )
                //         : null,
                nombreOpcion: menu.getTitulo(context),
                context: context,
                onTap: () => menu.redirigirAVista(context),
              ),
            ),
          )
          .toList(),
    );
  }
}
