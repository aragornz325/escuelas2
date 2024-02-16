import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/lista_cursos/gestion_de_comision/bloc/bloc_gestion_de_comision.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template DialogConfirmarDocenteAsignatura}
/// Dialog para confirmar al asignar un docente a una comision
/// {@endtemplate}
class DialogConfirmarDocenteAsignatura extends StatelessWidget {
  /// {@macro DialogConfirmarDocenteAsignatura}
  const DialogConfirmarDocenteAsignatura({
    required this.docente,
    super.key,
  });

  /// docente a asignar.
  final Usuario docente;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return EscuelasDialog.solicitudDeAccion(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.sw),
      ),
      onTapConfirmar: () => context.read<BlocGestionDeComision>().add(
            BlocGestionDeComisionEventoAsignarDocente(
              idDocente: docente.id ?? 0,
            ),
          ),
      content: BlocBuilder<BlocGestionDeComision, BlocGestionDeComisionEstado>(
        builder: (context, state) {
          return Text(
            // TODO(mati): traduccion
            '¿Estás seguro que deseas asignar a ${docente.nombre.toUpperCase()} como'
            ' docente de ${state.asignatura?.nombre.toUpperCase()} '
            '${state.idComision}?',
            style: TextStyle(
              fontSize: 14.pf,
              fontWeight: FontWeight.w700,
              color: colores.secondary,
            ),
          );
        },
      ),
    );
  }
}
