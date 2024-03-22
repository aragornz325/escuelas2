import 'package:escuelas_flutter/features/dashboard/bloc_dashboard/bloc_dashboard.dart';
import 'package:escuelas_flutter/features/dashboard/lista_de_comisiones/gestion_de_comision/bloc/bloc_gestion_de_comision.dart';
import 'package:escuelas_flutter/features/dashboard/lista_de_comisiones/gestion_de_comision/widgets/widgets.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularGestionDeComision}
/// Vista celular de gestion de comision.
/// {@endtemplate}
class VistaCelularGestionDeComision extends StatefulWidget {
  /// {@macro VistaCelularGestionDeComision}
  const VistaCelularGestionDeComision({super.key});

  @override
  State<VistaCelularGestionDeComision> createState() =>
      _VistaCelularGestionDeComisionState();
}

class _VistaCelularGestionDeComisionState
    extends State<VistaCelularGestionDeComision> {
  @override
  void initState() {
    super.initState();

    final state = context.read<BlocGestionDeComision>().state;

    /// Se obtienen las asignaturas y comisiones para el appbar.
    context.read<BlocDashboard>().add(
          BlocDashboardEventoObtenerAsignaturaYComision(
            idAsignatura: state.idAsignatura,
            idComision: state.idComision,
          ),
        );
  }

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
          value: context.read<BlocGestionDeComision>(),
          child: BottomSheetFiltrado(
            esAsignarDocente: esAsignarDocente,
            idRol: idRol,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.pw),
      child: Column(
        children: [
          BlocBuilder<BlocGestionDeComision, BlocGestionDeComisionEstado>(
            builder: (context, state) {
              final usuarios = state.asignatura?.usuarios;

              final docente = usuarios != null && usuarios.isNotEmpty
                  ? usuarios.last.usuario
                  : null;

              return ComponenteDependiendoElRol(
                tituloDeRol: '${l10n.commonTeacher}:',
                icono: docente != null
                    ? Icons.edit
                    : Icons.person_add_alt_outlined,
                esOutline: docente != null,
                onTap: () => _bottomSheetAsignarOAgregarUsuario(
                  esAsignarDocente: true,
                  context: context,

                  // TODO(anyone): cambiar el hardcodeo de idRol del docente cuando
                  // se soporte la customizacion de roles
                  idRol: 2,
                ),
                tituloBoton: docente != null
                    ? l10n.pageCourseManagementReplaceTeacher
                    : l10n.pageCourseManagementAssignTeacher,
              );
            },
          ),
          const DocenteDeLaAsignatura(),
          ComponenteDependiendoElRol(
            tituloDeRol: '${l10n.commonStudent}:',
            onTap: () => _bottomSheetAsignarOAgregarUsuario(
              context: context,
              // TODO(anyone): cambiar el hardcodeo de idRol del alumno cuando
              // se soporte la customizacion de roles
              idRol: 1,
            ),
            tituloBoton: l10n.pageCourseManagementAddStudent,
          ),
          const ListaDeAlumnosOrdenadasAlfabeticamente(),
        ],
      ),
    );
  }
}
