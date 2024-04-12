import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
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

  final int idAlumno;

  final String calificacion;

  final bool esEditable;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return GestureDetector(
      onTap: () => EscuelasDialog.featNoDisponible(context: context),
      child: Container(
        width: 55.sw,
        height: 55.sh,
        margin: EdgeInsets.symmetric(horizontal: 10.pw),
        decoration: BoxDecoration(
          color: calificacion == 'S/C' ? colores.tertiary : colores.azul,
          borderRadius: BorderRadius.circular(100.sw),
        ),
        child: Center(
          child: Text(
            calificacion,
            style: TextStyle(
              color:
                  calificacion == 'S/C' ? colores.onBackground : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
