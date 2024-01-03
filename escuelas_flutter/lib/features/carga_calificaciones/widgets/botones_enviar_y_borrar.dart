import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/asistencias/bloc_asistencias/bloc_asistencias_bloc.dart';
import 'package:escuelas_flutter/features/carga_calificaciones/bloc_carga_calificaciones/bloc_carga_calificaciones.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/escuelas_boton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template BotonesEnviarNotasYLimpiarNotas}
/// Botón para enviar las calificaciones y limpiar las notas.
/// {@endtemplate}
class BotonesEnviarNotasYLimpiarNotas extends StatelessWidget {
  /// {@macro BotonesEnviarNotasYLimpiarNotas}
  const BotonesEnviarNotasYLimpiarNotas({
    required this.calificacion,
    super.key,
  });

  //TODO(anyone): reemplazar modelo
  /// Modelo de calificación.
  final ModeloCalificacion? calificacion;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        EscuelasBoton.texto(
          context: context,
          estaHabilitado:
              calificacion?.alumnos.any((e) => e.calificacion != null) ?? false,
          onTap: () => context
              .read<BlocCargaCalificaciones>()
              .add(BlocCargaCalificacionesEventoVaciarCalificaciones()),
          color: colores.error,
          texto: 'BORRAR TODO', // TODO(mati): hacer l10n
        ),
        EscuelasBoton.texto(
          context: context,
          estaHabilitado:
              calificacion?.alumnos.every((e) => e.calificacion != null) ??
                  false,
          onTap: () => context
              .read<BlocCargaCalificaciones>()
              .add(BlocCargaCalificacionesEventoEnviarCalificaciones()),
          color: colores.azul,
          texto: 'CONFIRMAR', // TODO(mati): hacer l10n
        ),
      ],
    );
  }
}
