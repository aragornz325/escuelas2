import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/cursos/perfil_comunicados/bloc/bloc_perfil_comunicados.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/cursos/perfil_comunicados/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularPerfilComunicados}
/// Vista de celular de la pantalla 'Perfil de comunicados'
/// {@endtemplate}
class VistaCelularPerfilComunicados extends StatelessWidget {
  /// {@macro VistaCelularPerfilComunicados}
  const VistaCelularPerfilComunicados({super.key});

  /// Dialog de exito al crear una notificacion.
  void _dialogExitoAlCrearNotificacion(
    BuildContext context,
    String? tituloPlantilla,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) => DialogExitoAlCrearNotificacion(
        tituloPlantilla: tituloPlantilla,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.pw),
      child: SingleChildScrollView(
        child: BlocConsumer<BlocPerfilComunicados, BlocPerfilComunicadosEstado>(
          listener: (context, state) {
            if (state
                is BlocPerfilComunicadosEstadoExitosoAlCrearNotificacion) {
              _dialogExitoAlCrearNotificacion(
                context,
                state.tituloPlantilla,
              );
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.nombreUsuario,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16.pf,
                    color: colores.onBackground,
                  ),
                ),
                SizedBox(height: max(5.ph, 5.sh)),
                Divider(height: 0, color: colores.secondary),
                SizedBox(height: max(10.ph, 10.sh)),
                BotonesAgregarNuevaYMarcarTodosComoLeidos(
                  notificaciones: state.notificaciones,
                ),
                Column(
                  children: state is BlocPerfilComunicadosEstadoCargando
                      ? [
                          SizedBox(height: max(50.ph, 50.sh)),
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ]
                      : state.notificaciones
                          .map(
                            (notificacion) => ExpansionTileNotificaciones(
                              notificacion: notificacion,
                            ),
                          )
                          .toList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
