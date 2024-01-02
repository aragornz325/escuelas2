import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/asistencias/bloc_asistencias/bloc_asistencias.dart';
import 'package:escuelas_flutter/features/asistencias/widgets/dialog/dialog_asistencia_del_dia.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/escuelas_boton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template BotonFinalizarAsistencias}
/// Botón para finalizar las asistencias
/// {@endtemplate}
class BotonFinalizarAsistencias extends StatelessWidget {
  /// {@macro BotonFinalizarAsistencias}
  const BotonFinalizarAsistencias({
    required this.curso,
    required this.fecha,
  });

  /// Curso en el que se finalizaron las asistencias
  final ModeloCurso curso;

  /// Fecha en la que se finalizaron las asistencias
  final DateTime fecha;

  /// Función que abre un Dialog para ver las informaciones de la asistencia.
  /// Con la cual muestra la cantidad de alumnos que no asistieron.
  ///
  /// También puede desplegar una lista mas detallada de que usuarios con nombre
  /// y el estado y un botón para finalizar la asistencias del dia.
  void _dialogFinalizarAsistencias(
    BuildContext context,
    ModeloCurso curso,
  ) {
    showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocAsistencias>(),
        child: DialogAsistenciasDelDia(
          alumnos: curso.alumnos,
          idCurso: curso.id,
          fecha: fecha,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return EscuelasBoton.texto(
      width: 160.pw,
      context: context,
      estaHabilitado: true,
      color: curso.alumnosSinAsistencias()
          ? colores.coralBotones
          : colores.secondary,
      onTap: curso.alumnosSinAsistencias()
          ? () => _dialogFinalizarAsistencias(
                context,
                curso,
              )
          : () {},
      texto: curso.alumnosSinAsistencias()
          ? l10n.pageAttendanceTitleFinishButtonToEndAttendance.toUpperCase()
          : l10n
              .pageAttendanceTitleDefinedMissingAmountComplete(
                curso.cantidadDeNoAusentes(),
                curso.alumnos.length,
              )
              .toUpperCase(),
    );
  }
}
