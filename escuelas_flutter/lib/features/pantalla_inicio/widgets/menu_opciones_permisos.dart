import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/pantalla_inicio/bloc/bloc_inicio.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
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

  Future<void> _showDialogError(BuildContext context) {
    final l10n = context.l10n;
    return showDialog<void>(
      context: context,
      builder: (context) => EscuelasDialog.fallido(
        // TODO(anyone): Revisar si este container esta bien
        content: Column(
          children: [
            SizedBox(
              height: 20.ph,
            ),
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

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return BlocConsumer<BlocInicio, BlocInicioEstado>(
      listener: (context, state) {
        if (state is BlocInicioEstadoFallido) {
          _showDialogError(context);
        }
      },
      builder: (context, state) {
        if (state is BlocInicioEstadoCargando) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Column(
            children: state.listaEtiquetas
                .map(
                  (etiqueta) => Padding(
                    padding: EdgeInsets.only(bottom: 15.ph),
                    child: ElementoLista(
                      texto: Text(
                        etiqueta.titulo,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16.pf,
                          color: colores.onBackground,
                        ),
                      ),
                      colorFondo: colores.tertiary,
                      onTap: () => etiqueta.redirigirAVista(context),
                    ),
                  ),
                )
                .toList(),
          );
        }
      },
    );
  }
}
