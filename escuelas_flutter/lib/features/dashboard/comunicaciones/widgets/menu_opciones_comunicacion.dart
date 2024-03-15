import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/extensiones/usuario.dart';
import 'package:escuelas_flutter/features/dashboard/bloc_dashboard/bloc_dashboard.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/bloc_comunicaciones/bloc_comunicaciones.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/utilidades/enum_menu_opciones_comunicaciones.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/elemento_lista.dart';
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
    final menus = _menusPermitidos(context);

    final colores = context.colores;

    return BlocBuilder<BlocComunicaciones, BlocComunicacionesEstado>(
      builder: (context, state) {
        final cantidadNotificacionesPendientes = context
                .read<BlocComunicaciones>()
                .state
                .cantidadNotificacionesPendientes ??
            0;
        return Column(
          children: menus
              .map(
                (menu) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.ph)
                      .copyWith(bottom: 15.ph),
                  child: ElementoLista.menu(
                    nombreOpcion: menu.getTitulo(context),
                    context: context,
                    onTap: () => menu.redirigirAVista(context),
                    widgetLateralDerecho: menu.name ==
                                MenuOpcionesComunicaciones
                                    .comunicacionesPendientes.name &&
                            cantidadNotificacionesPendientes > 0
                        ? Padding(
                            padding: EdgeInsets.only(right: 20.pw),
                            child: Container(
                              width: 24.pw,
                              height: 24.ph,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colores.azulNotificacion,
                              ),
                              child: Center(
                                child: Text(
                                  cantidadNotificacionesPendientes.toString(),
                                  style: TextStyle(
                                    color: colores.marfilBackgroundDesktop,
                                    fontSize: 16.pf,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : null,
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
