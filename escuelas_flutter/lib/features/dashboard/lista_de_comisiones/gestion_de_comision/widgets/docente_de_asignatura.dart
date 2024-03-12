import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/lista_de_comisiones/gestion_de_comision/bloc/bloc_gestion_de_comision.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template DocenteDeLaAsignatura}
/// Docente de la asignatura muestra la informacion del docente en caso de que
/// exista uno asignado a esa asignatura o muestra un circulo vacio con un
/// mensaje indicando que no hay docente.
/// {@endtemplate}
class DocenteDeLaAsignatura extends StatelessWidget {
  /// {@macro DocenteDeLaAsignatura}
  const DocenteDeLaAsignatura({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return BlocBuilder<BlocGestionDeComision, BlocGestionDeComisionEstado>(
      builder: (context, state) {
        final usuarios = state.asignatura?.usuarios;

        final docente = usuarios != null && usuarios.isNotEmpty
            ? usuarios.last.usuario
            : null;

        if (docente != null) {
          return Row(
            children: [
              CircleAvatar(
                radius: 18.sw,
                backgroundColor: colores.secondary,
                backgroundImage: NetworkImage(docente.urlFotoDePerfil),
              ),
              SizedBox(width: 10.pw),
              Text(
                '${docente.nombre} ${docente.apellido}',
                style: TextStyle(
                  fontSize: 13.pf,
                  fontWeight: FontWeight.w400,
                  color: colores.secondary,
                ),
              ),
            ],
          );
        }
        return Row(
          children: [
            CircleAvatar(
              radius: 18.sw,
              backgroundColor: colores.secondary,
            ),
            SizedBox(width: 10.pw),
            Text(
              l10n.pageCourseManagementThereAreNoTeachersAssigned,
              style: TextStyle(
                fontSize: 13.pf,
                fontWeight: FontWeight.w400,
                color: colores.secondary,
              ),
            ),
          ],
        );
      },
    );
  }
}
