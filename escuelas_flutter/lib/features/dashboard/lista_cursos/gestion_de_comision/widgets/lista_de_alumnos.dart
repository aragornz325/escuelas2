import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/comunidad_academica/listado_comunidad/widgets/elemento_listado_comunidad.dart';
import 'package:escuelas_flutter/features/dashboard/lista_cursos/gestion_de_comision/bloc/bloc_gestion_de_comision.dart';
import 'package:escuelas_flutter/features/dashboard/lista_cursos/gestion_de_comision/widgets/widgets.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularGestionDeComision}
/// Lista de alumnos ordenados alfabeticamente.
/// {@endtemplate}
class ListaDeAlumnosOrdenadasAlfabeticamente extends StatelessWidget {
  /// {@macro VistaCelularGestionDeComision}
  const ListaDeAlumnosOrdenadasAlfabeticamente({super.key});

  /// dialog que se va a mostrar en caso de exito al asignar docente a una
  /// asignatura o agregar un nuevo alumno a una comision
  void _dialogExitoso(BuildContext context, String titulo) => showDialog<void>(
        context: context,
        builder: (context) => DialogExitoso(
          titulo: titulo,
        ),
      ).then((value) => Navigator.of(context).pop());

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return BlocConsumer<BlocGestionDeComision, BlocGestionDeComisionEstado>(
      listener: (context, state) {
        if (state.exitoAlAsignarDocente) {
          _dialogExitoso(
            context,
            l10n.pageCourseManagementTeacherAsignedSuccessfully,
          );
        }

        if (state.exitoAlAgregarAlumnoAComision) {
          _dialogExitoso(
            context,
            l10n.pageCourseManagementStudentAddSuccessfully,
          );
        }
      },
      builder: (context, state) {
        if (state is BlocGestionDeComisionEstadoCargando) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.listaAlumnos?.usuariosListados.isEmpty ?? false) {
          return Center(
            child: Column(
              children: [
                Icon(
                  Icons.groups_3_outlined,
                  size: 100.pw,
                  color: colores.secondary,
                ),
                Text(
                  l10n.pageAcademicCommunityNoUsersToShow,
                  style: TextStyle(
                    color: colores.secondary,
                    fontSize: 16.pf,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }
        return Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: state.listaAlumnos?.usuariosListados
                      .map(
                        (e) => e.usuarios.isEmpty
                            ? Container()
                            : ElementoListadoComunidad(
                                ordenarPor: OrdenarPor.asignatura,
                                titulo: e.etiquetaDelIndexListado.toUpperCase(),
                                usuariosListados: e,
                                onTap: () {},
                              ),
                      )
                      .toList() ??
                  [],
            ),
          ),
        );
      },
    );
  }
}
