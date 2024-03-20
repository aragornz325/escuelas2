import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/extensiones/usuario.dart';
import 'package:escuelas_flutter/features/dashboard/bloc_dashboard/bloc_dashboard.dart';
import 'package:escuelas_flutter/features/dashboard/pantalla_inicio/bloc/bloc_inicio.dart';
import 'package:escuelas_flutter/features/dashboard/pantalla_inicio/utilidades/enum_menu_opciones_de_inicio.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/elemento_lista.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template MenuOpcionesPermisos}
/// Muestra una lista de opciones de navegacion que el usuario ve segun
/// sus permisos
/// {@endtemplate}
class MenuOpcionesPermisos extends StatelessWidget {
  /// {@macro MenuOpcionesPermisos}
  const MenuOpcionesPermisos({super.key});

  /// Muestra dialog de error
  Future<void> _showDialogError(BuildContext context) {
    final l10n = context.l10n;

    return showDialog<void>(
      context: context,
      builder: (context) => EscuelasDialog.fallido(
        content: Column(
          children: [
            SizedBox(height: 20.ph),
            Center(
              child: Text(
                l10n.commonDialogError,
                style: TextStyle(fontSize: 18.pf),
              ),
            ),
          ],
        ),
        onTap: () => Navigator.of(context).pop(),
      ),
    );
  }

  /// Devuelve de acuerdo al usuario su lista de vistas permitidas.
  List<MenuOpcionesDeInicio> _menusPermitidos(BuildContext context) {
    final usuario = context.read<BlocDashboard>().state.usuario;
    return MenuOpcionesDeInicio.values
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

    return BlocConsumer<BlocInicio, BlocInicioEstado>(
      listener: (context, state) {
        if (state is BlocInicioEstadoFallido) {
          _showDialogError(context);
        }
      },
      builder: (context, state) {
        if (state is BlocInicioEstadoCargando) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 150.ph),
              const Center(child: CircularProgressIndicator()),
            ],
          );
        }
        if (state is BlocInicioEstadoExitoso && menus.isEmpty) {
          return Center(
            child: Text(
              l10n.pageHomeNoOptionsMenu,
              style: TextStyle(
                color: colores.onBackground,
                fontWeight: FontWeight.w600,
                fontSize: 14.pf,
              ),
            ),
          );
        }
        if (state is BlocInicioEstadoExitoso && menus.isEmpty) {
          return Center(
            child: Text(
              l10n.pageHomeNoOptionsMenu,
              style: TextStyle(
                color: colores.onBackground,
                fontWeight: FontWeight.w600,
                fontSize: 14.pf,
              ),
            ),
          );
        }

        return Column(
          children: menus.map(
            (menu) {
              final tieneUsuariosPendientesYLaRutaTieneEseNombre =
                  menu.name == MenuOpcionesDeInicio.usuariosPendientes.name &&
                      state.hayUsuariosPendientes;

              final tieneMasDeUnaNotificacionPendiente =
                  menu.name == MenuOpcionesDeInicio.comunicaciones.name &&
                      state.cantidadNotificacionesPendientes > 0;

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.ph)
                    .copyWith(bottom: 15.ph),
                child: ElementoLista.menu(
                  widgetLateralDerecho:
                      tieneUsuariosPendientesYLaRutaTieneEseNombre
                          ? Padding(
                              padding: EdgeInsets.only(right: 20.pw),
                              child: Icon(
                                Icons.circle,
                                color: colores.error,
                                size: 15.sw,
                              ),
                            )
                          : (tieneMasDeUnaNotificacionPendiente
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
                                        state.cantidadNotificacionesPendientes
                                            .toString(),
                                        style: TextStyle(
                                          color:
                                              colores.marfilBackgroundDesktop,
                                          fontSize: 16.pf,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : null),
                  nombreOpcion: menu.getTitulo(context),
                  context: context,
                  onTap: () => menu.redirigirAVista(context),
                ),
              );
            },
          ).toList(),
        );
      },
    );
  }
}
