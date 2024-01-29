import 'dart:math';

import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/inasistencias/bloc_inasistencias/bloc_inasistencias.dart';
import 'package:escuelas_flutter/features/dashboard/inasistencias/widgets/dialog/widgets/lista_alumnos_ausentes.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';
import 'package:intl/intl.dart';

/// {@template DialogInasistenciasDelDia}
/// Dialog que confirma la asistencia tomada del dia y muestra mas detalles
/// sobre dicho dia con la cantidad de estudiantes que no asistieron y que
/// estado de asistencia tiene cada estudiante.
/// {@endtemplate}
class DialogInasistenciasDelDia extends StatefulWidget {
  /// {@macro DialogInasistenciasDelDia}
  const DialogInasistenciasDelDia({
    required this.estudiantes,
    required this.idComision,
    required this.fecha,
    required this.inasistencias,
    required this.esEditar,
    super.key,
  });

  /// Cantidad de estudiantes que no asistieron esa fecha.
  final List<RelacionComisionUsuario> estudiantes;

  /// ID del curso.
  final int idComision;

  /// Fecha en la cual se tomaron inasistencia.
  final DateTime fecha;

  /// Lista de inasistencias
  final List<AsistenciaDiaria> inasistencias;

  /// Indica si se intenta editar o crear un listado de inasistencias.
  final bool esEditar;

  @override
  State<DialogInasistenciasDelDia> createState() =>
      _DialogInasistenciasDelDiaState();
}

class _DialogInasistenciasDelDiaState extends State<DialogInasistenciasDelDia> {
  /// Variable que indica si se desplegó el ver mas o no muestra una lista mas
  /// detallada
  bool desplegarVerMas = false;

  /// Lista de Estados de los estudiantes que solamente que tienen no asistieron
  List<EstadoDeAsistencia> get alumnosAusentes => EstadoDeAsistencia.values
      .where(
        (estadoAsistencia) =>
            estadoAsistencia == EstadoDeAsistencia.ausente ||
            estadoAsistencia == EstadoDeAsistencia.mediaInasistencia ||
            estadoAsistencia == EstadoDeAsistencia.cuartoDeInasistencia,
      )
      .toList();

  /// Confirmar las asistencia
  void _confirmarInasistencias(BuildContext context) {
    if (widget.esEditar) {
      context.read<BlocInasistencias>().add(
            BlocInasistenciasEventoEditarInasistencias(
              idComision: widget.idComision,
              inasistencias: widget.inasistencias,
            ),
          );
    } else {
      context.read<BlocInasistencias>().add(
            BlocInasistenciasEventoCrearInasistencias(
              idComision: widget.idComision,
              inasistencias: widget.inasistencias,
            ),
          );
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final fecha = DateFormat('EEEE d MMMM', 'es').format(widget.fecha);

    final l10n = context.l10n;

    return EscuelasDialog(
      altura: desplegarVerMas ? max(300.ph, 300.sh) : max(200.ph, 200.sh),
      conIconoCerrar: false,
      onTapConfirmar: () => _confirmarInasistencias(context),
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
              cantidad: estadoAsistencia.cantidadDeAlumnos(
                widget.estudiantes,
                widget.inasistencias,
                estadoAsistencia,
              ),
              estadoAsistencia: estadoAsistencia,
            ),
          ),
          SizedBox(height: max(15.ph, 15.sh)),
          if (desplegarVerMas) ...[
            ListaDeAlumnosAusentes(
              usuarios: widget.estudiantes,
              asistencias: widget.inasistencias,
            ),
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

  final EstadoDeAsistencia estadoAsistencia;

  /// Indica los alumnos que tienen de estado media falta o cuarto falta.
  bool alumnosSinAusenteCompleto(EstadoDeAsistencia estadoAsistencia) =>
      estadoAsistencia == EstadoDeAsistencia.mediaInasistencia ||
      estadoAsistencia == EstadoDeAsistencia.cuartoDeInasistencia;

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
