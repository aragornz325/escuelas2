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
/// TODO(mati): documentar
/// {@endtemplate}
class VistaCelularGestionDeComision extends StatelessWidget {
  /// {@macro VistaCelularGestionDeComision}
  const VistaCelularGestionDeComision({super.key});

  /// dialog que se va a mostrar en caso de exito al asignar docente a una
  /// asignatura o agregar un nuevo alumno a una comision
  void _dialogExitoso(BuildContext context, String titulo) => showDialog<void>(
        context: context,
        builder: (context) => DialogExitoso(
          titulo: titulo,
        ),
      );

  /// bottomsheet que se va a mostrar en caso de filtrar por nombre, y para
  /// asignar docente a una asignatura o agregar un alumno a una comision
  void _bottomSheetAsignarOAgregarUsuario({
    required BuildContext context,
    required int idRol,
    bool esAsignarDocente = false,
  }) =>
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (_) => BlocProvider.value(
          value: context.read<BlocGestionDeComision>()
            ..add(
              BlocGestionDeComisionEventoFiltrarPorNombre(idRol: idRol),
            ),
          child: BottomSheetFiltrado(esAsignarDocente: esAsignarDocente),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.pw),
      child: Column(
        children: [
          ComponenteDependiendoElRol(
            tituloDeRol: '${l10n.commonTeacher}:',
            onTap: () => _bottomSheetAsignarOAgregarUsuario(
              esAsignarDocente: true,
              context: context,
              idRol: 2,
            ),
            tituloBoton: l10n.pageManagementOfCourseAssignTeacher,
          ),
          const DocenteDeLaAsignatura(),
          ComponenteDependiendoElRol(
            tituloDeRol: '${l10n.commonStudent}:',
            onTap: () => _bottomSheetAsignarOAgregarUsuario(
              context: context,
              idRol: 1,
            ),
            tituloBoton: l10n.pageManagementOfCourseAddStudent,
          ),
          BlocConsumer<BlocGestionDeComision, BlocGestionDeComisionEstado>(
            listener: (context, state) {
              if (state.exitoAlAsignarDocente) {
                // TODO(mati): traduccion
                _dialogExitoso(context, '¡Docente asignado con exito!');
              }

              if (state.exitoAlAgregarAlumnoAComision) {
                // TODO(mati): traduccion
                _dialogExitoso(context, '¡Alumno agregado con exito!');
              }
            },
            builder: (context, state) {
              // TODO(mati): hacer vista de no usuarios
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
                                      titulo: e.etiquetaDelIndexListado
                                          .toUpperCase(),
                                      usuariosListados: e,
                                    ),
                            )
                            .toList() ??
                        [],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
