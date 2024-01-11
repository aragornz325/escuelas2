import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/inasistencias/bloc_inasistencias/bloc_inasistencias.dart';
import 'package:escuelas_flutter/features/inasistencias/widgets/dialog/dialog_asistencia_del_dia.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/escuelas_boton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template BotonFinalizarInasistencias}
/// Botón para finalizar las inasistencias
/// {@endtemplate}
class BotonFinalizarInasistencias extends StatelessWidget {
  /// {@macro BotonFinalizarInasistencias}
  const BotonFinalizarInasistencias({
    required this.comisionDeCurso,
    required this.fecha,
    required this.inasistencias,
    super.key,
  });

  /// Curso en el que se finalizaron las asistencias
  final ComisionDeCurso comisionDeCurso;

  /// Fecha en la que se finalizaron las asistencias
  final DateTime fecha;

  /// Inasistencias que se finalizaron
  final List<AsistenciaDiaria> inasistencias;

  /// Función que abre un Dialog para ver las informaciones de la asistencia.
  /// Con la cual muestra la cantidad de alumnos que no asistieron.
  ///
  /// También puede desplegar una lista mas detallada de que usuarios con nombre
  /// y el estado y un botón para finalizar la asistencias del dia.
  void _dialogFinalizarAsistencias(
    BuildContext context,
    ComisionDeCurso curso,
    List<AsistenciaDiaria> asistencias,
  ) {
    showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocInasistencias>(),
        child: DialogInasistenciasDelDia(
          inasistencias: asistencias,
          estudiantes: curso.estudiantes ?? [],
          idCurso: curso.cursoId,
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
      width: 180.pw,
      context: context,
      estaHabilitado:
          (comisionDeCurso.alumnosSinInasistencias(inasistencias)) &&
              (comisionDeCurso.estudiantes?.isNotEmpty ?? false),
      color: comisionDeCurso.alumnosSinInasistencias(inasistencias)
          ? colores.coralBotones
          : colores.secondary,
      onTap: comisionDeCurso.alumnosSinInasistencias(inasistencias)
          ? () => _dialogFinalizarAsistencias(
                context,
                comisionDeCurso,
                inasistencias,
              )
          : () {},
      texto: comisionDeCurso.alumnosSinInasistencias(inasistencias)
          ? l10n.pageAttendanceTitleFinishButtonToEndAttendance.toUpperCase()
          : l10n
              .pageAttendanceTitleDefinedMissingAmountComplete(
                comisionDeCurso.cantidadDeNoAusentes(
                  inasistencias,
                ),
                comisionDeCurso.estudiantes?.length ?? 0,
              )
              .toUpperCase(),
    );
  }
}
