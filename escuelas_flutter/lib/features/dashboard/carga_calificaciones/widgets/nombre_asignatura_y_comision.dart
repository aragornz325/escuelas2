import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template NombreAsignaturaYComision}
/// Muestra en ui la asignatura y la comision de la que se estan cargando las
/// calificaciones
/// {@endtemplate}
class NombreAsignaturaYComision extends StatelessWidget {
  /// {@macro NombreAsignaturaYComision}
  const NombreAsignaturaYComision({
    required this.nombreAsignatura,
    required this.nombreComision,
    super.key,
  });

  final String nombreAsignatura;

  final String nombreComision;
  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 25.pw,
        vertical: 15.ph,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            nombreAsignatura.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 15.pf,
              color: colores.onBackground,
            ),
          ),
          Text(
            nombreComision,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 15.pf,
              color: colores.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
