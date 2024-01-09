import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/comision_de_curso.dart';
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
/// Botón para finalizar las asistencias
/// {@endtemplate}
class BotonFinalizarInasistencias extends StatelessWidget {
  /// {@macro BotonFinalizarInasistencias}
  const BotonFinalizarInasistencias({
    required this.curso,
    required this.fecha,
    required this.asistencias,
    super.key,
  });

  /// Curso en el que se finalizaron las asistencias
  final ComisionDeCurso curso;

  /// Fecha en la que se finalizaron las asistencias
  final DateTime fecha;

  final List<AsistenciaDiaria> asistencias;

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
          asistencias: asistencias,
          alumnos: curso.estudiantes!.map((e) => e.usuario!).toList(),
          idCurso: curso.idCurso,
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
      estaHabilitado: true,
      color:
          curso.alumnosSinInasistencias(asistencias) //TODO(mati) revisar esto
              ? colores.coralBotones
              : colores.secondary,
      onTap:
          curso.alumnosSinInasistencias(asistencias) //TODO(mati) revisar esto
              ? () => _dialogFinalizarAsistencias(
                    context,
                    curso,
                    asistencias,
                  )
              : () {},
      texto: curso
              .alumnosSinInasistencias(asistencias) //TODO(mati) revisar esto
          ? l10n.pageAttendanceTitleFinishButtonToEndAttendance.toUpperCase()
          : l10n
              .pageAttendanceTitleDefinedMissingAmountComplete(
                curso.cantidadDeNoAusentes(
                  asistencias,
                ), //TODO(mati) revisar esto
                curso.estudiantes?.length ?? 0,
              )
              .toUpperCase(),
    );
  }
}
