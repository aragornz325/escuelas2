import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/pantalla_inicio/bloc/bloc_inicio.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/elemento_lista.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        context: context,
        onTap: () => Navigator.of(context).pop(),
        titulo: l10n.commonDialogError,
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
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: state.listaEtiquetas
                    .map(
                      (etiqueta) => Padding(
                        padding: const EdgeInsets.all(8),
                        child: ElementoLista(
                          titulo: etiqueta.titulo,
                          colorFondo: colores.tertiary,
                          onTap: () => etiqueta.redirigirAVista(context),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        }
      },
    );
  }
}
