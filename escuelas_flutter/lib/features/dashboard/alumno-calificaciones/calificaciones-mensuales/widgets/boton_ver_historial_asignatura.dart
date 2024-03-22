import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template BotonVerHistorialAsignatura }
/// Al presionarlo permite la redireccion a la pagina de la asignatura
/// especifica visualizando el promedio y las calificaciones de cada mes.
/// {@endtemplate}
class BotonVerHistorialAsignatura extends StatelessWidget {
  /// {@macro BotonVerHistorialAsignatura}
  const BotonVerHistorialAsignatura({
    required this.idAsignatura,
    super.key,
  });

  /// Id de la asignatura para mostrar el historial de calificaciones en el año.
  final int idAsignatura;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return GestureDetector(
      onTap: () => context.router
          .push(RutaCalificacionesAnuales(idAsignatura: idAsignatura)),
      child: Container(
        width: 40.sw,
        height: 40.sh,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: colores.violetaOscuroBottomNav,
            width: 2.pw,
          ),
        ),
        child: Center(
          child: Icon(
            Icons.chevron_right_rounded,
            color: colores.violetaOscuroBottomNav,
          ),
        ),
      ),
    );
  }
}
