import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/lista_cursos/carga_calificaciones/widgets/tarjeta_carga_calificacion/dialogs/dialogs.dart';
import 'package:escuelas_flutter/features/dashboard/supervision/supervision_asignatura/bloc/bloc_supervision_asignatura.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template BotonCargaCalificacion}
/// Botón para cargar una calificación
/// {@endtemplate}
class BotonCargaCalificacion extends StatelessWidget {
  /// {@macro BotonCargaCalificacion}
  const BotonCargaCalificacion({
    required this.idAlumno,
    required this.calificacion,
    required this.esEditable,
    super.key,
  });

  /// Id del alumno para modificarlo
  final int idAlumno;

  /// Calificacion del alumno
  final String calificacion;

  /// Indica si se puede modificar o no.
  final bool esEditable;

  /// Muestra el dialog para elegir una calificación
  Future<void> _dialogElegirCalificacion(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocSupervisionAsignatura>(),
        child: DialogElegirCalificacion(
          onSelected: (value) {
            context.read<BlocSupervisionAsignatura>().add(
                  BlocCargaCalificacionesEventoAgregarCalificacion(
                    idAlumno: idAlumno,
                    calificacion: value,
                  ),
                );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    final l10n = context.l10n;

    return GestureDetector(
      onTap: () {
        if (esEditable) {
          _dialogElegirCalificacion(context);
        }
      },
      child: Container(
        width: 55.sw,
        height: 55.sh,
        margin: EdgeInsets.symmetric(horizontal: 10.pw),
        decoration: BoxDecoration(
          color: calificacion == l10n.commonUnrated
              ? colores.tertiary
              : colores.azul,
          borderRadius: BorderRadius.circular(100.sw),
        ),
        child: Center(
          child: Text(
            calificacion,
            style: TextStyle(
              color: calificacion == l10n.commonUnrated
                  ? colores.onBackground
                  : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.pf,
            ),
          ),
        ),
      ),
    );
  }
}
