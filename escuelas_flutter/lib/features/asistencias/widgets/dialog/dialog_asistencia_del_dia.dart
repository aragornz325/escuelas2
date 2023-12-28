import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/asistencias/bloc_asistencias/bloc_asistencias_bloc.dart';
import 'package:escuelas_flutter/features/asistencias/widgets/dialog/widgets/widget.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';
import 'package:intl/intl.dart';

/// {@template DialogAsistenciasDelDia}
/// Dialog que confirma la asistencia tomada del dia y muestra mas detalles
/// sobre dicho dia con la cantidad de alumnos que no asistieron y que estado
/// de asistencia tiene cada alumno.
/// {@endtemplate}
class DialogAsistenciasDelDia extends StatefulWidget {
  /// {@macro DialogAsistenciasDelDia}
  const DialogAsistenciasDelDia({
    required this.alumnos,
    required this.idCurso,
    required this.fecha,
    super.key,
  });

  /// Cantidad de alumnos que no asistieron esa fecha.
  final List<ModeloAlumno> alumnos;

  /// ID del curso.
  final int idCurso;

  /// Fecha en la cual se tomaron asistencias.
  final DateTime fecha;

  @override
  State<DialogAsistenciasDelDia> createState() =>
      _DialogAsistenciasDelDiaState();
}

class _DialogAsistenciasDelDiaState extends State<DialogAsistenciasDelDia> {
  /// Variable que indica si se desplega el ver mas o no muestra una lista mas
  /// detallada
  bool desplegarVerMas = false;

  /// Lista de Estados de los alumnos que solamente que tienen no asistieron.
  List<EstadoAsistencia> get alumnosAusentes => EstadoAsistencia.values
      .where(
        (estadoAsistencia) =>
            estadoAsistencia == EstadoAsistencia.ausente ||
            estadoAsistencia == EstadoAsistencia.mediaFalta ||
            estadoAsistencia == EstadoAsistencia.cuartoFalta,
      )
      .toList();

  /// Lista de alumnos filtradas por ausentismo
  List<ModeloAlumno> get alumnosFiltrados => widget.alumnos
      .where(
        (alumno) =>
            alumno.asistencia != EstadoAsistencia.presente &&
            alumno.asistencia != EstadoAsistencia.sinAsistencia,
      )
      .toList();

  /// Cantidad de alumnos que no asistieron
  int _cantidad(EstadoAsistencia estadoAsistencia) {
    return widget.alumnos
        .where((alumno) => alumno.asistencia == estadoAsistencia)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    final fecha = DateFormat('EEEE d MMMM', 'es').format(widget.fecha);

    final l10n = context.l10n;

    return EscuelasDialog(
      altura: desplegarVerMas ? max(300.ph, 300.sh) : max(160.ph, 160.sh),
      conIconoCerrar: false,
      onTapConfirmar: () {
        context.read<BlocAsistencias>().add(
              BlocAsistenciasFinalizarAsistencia(
                idCurso: widget.idCurso,
              ),
            );
        Navigator.of(context).pop();
      },
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: max(10.ph, 10.sh)),
          Text(
            l10n.dialogAttendanceOfDay,
            style: TextStyle(
              fontSize: 15.pf,
              fontWeight: FontWeight.w600,
              color: context.colores.grisSC,
            ),
          ),
          Text(
            // pone la primera letra en mayúscula.
            fecha[0].toUpperCase() + fecha.substring(1),
            style: TextStyle(
              fontSize: 16.pf,
              fontWeight: FontWeight.w700,
              color: context.colores.onBackground,
            ),
          ),
          SizedBox(height: max(15.ph, 15.sh)),
          ...alumnosAusentes.map(
            (estadoAsistencia) => _CantidadAusentes(
              cantidad: _cantidad(estadoAsistencia),
              estadoAsistencia: estadoAsistencia,
            ),
          ),
          SizedBox(height: max(15.ph, 15.sh)),
          if (desplegarVerMas) ...[
            ListaDeAlumnosAusentes(alumnosFiltrados: alumnosFiltrados),
          ],
          SizedBox(height: max(10.ph, 10.sh)),
          InkWell(
            onTap: () => setState(() => desplegarVerMas = !desplegarVerMas),
            child: Text(
              desplegarVerMas ? l10n.dialogSeeLess : l10n.dialogSeeMore,
              style: TextStyle(
                fontSize: 12.pf,
                fontWeight: FontWeight.w600,
                color: context.colores.onSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// {@template _CantidadAusentes}
/// Muestra el estado de asistencia de los alumnos que no asistieron y la
/// cantidad
/// {@endtemplate}
class _CantidadAusentes extends StatelessWidget {
  /// {@macro _CantidadAusentes}
  const _CantidadAusentes({
    required this.cantidad,
    required this.estadoAsistencia,
  });

  /// cantidad de ese estado de asistencia
  final int cantidad;

  final EstadoAsistencia estadoAsistencia;

  /// Indica los alumnos que tienen de estado media falta o cuarto falta.
  bool alumnosSinAusenteCompleto(EstadoAsistencia estadoAsistencia) =>
      estadoAsistencia == EstadoAsistencia.mediaFalta ||
      estadoAsistencia == EstadoAsistencia.cuartoFalta;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return RichText(
      text: TextSpan(
        text: '$cantidad ',
        style: TextStyle(
          fontSize: 13.pf,
          fontWeight: FontWeight.w400,
          color: colores.onBackground,
        ),
        children: [
          if (alumnosSinAusenteCompleto(estadoAsistencia))
            TextSpan(
              text: l10n.dialogAttendanceStateOfStudents,
              style: TextStyle(
                fontSize: 13.pf,
                fontWeight: FontWeight.w400,
                color: colores.grisSC,
              ),
            ),
          TextSpan(
            text: ' ${estadoAsistencia.nombreEstado(context).toUpperCase()}',
            style: TextStyle(
              fontSize: 13.pf,
              fontWeight: FontWeight.w400,
              color: estadoAsistencia.colorEstado(context),
            ),
          ),
        ],
      ),
    );
  }
}
