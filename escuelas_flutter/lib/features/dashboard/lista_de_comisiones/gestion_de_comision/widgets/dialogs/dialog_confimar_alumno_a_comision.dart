import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/lista_de_comisiones/gestion_de_comision/bloc/bloc_gestion_de_comision.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template DialogConfirmarAgregarAlumnoAComision}
/// Dialog para confirmar al agregar un alumno a una comision.
/// {@endtemplate}
class DialogConfirmarAgregarAlumnoAComision extends StatelessWidget {
  /// {@macro DialogConfirmarAgregarAlumnoAComision}
  const DialogConfirmarAgregarAlumnoAComision({
    required this.usuario,
    super.key,
  });

  /// alumno a mostrar
  final Usuario usuario;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return EscuelasDialog.solicitudDeAccion(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.sw),
      ),
      onTapConfirmar: () {
        context.read<BlocGestionDeComision>().add(
              BlocGestionDeComisionEventoAgregarAlumno(
                alumno: usuario,
              ),
            );
        Navigator.of(context).pop();
      },
      content: BlocBuilder<BlocGestionDeComision, BlocGestionDeComisionEstado>(
        builder: (context, state) {
          return SizedBox(
            width: 210.pw,
            child: DefaultTextStyle(
              style: TextStyle(
                fontSize: 14.pf,
                fontWeight: FontWeight.w700,
                color: colores.onSecondary,
              ),
              child: Column(
                children: [
                  Text(
                    l10n.pageCourseManagementAddStudentConfirmation(
                      state.comision?.nombre.toUpperCase() ?? '',
                      usuario.nombre.toUpperCase(),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    // TODO(mati): hablar con louka para saber en que comision
                    // estaba el alumno
                    l10n.pageCourseManagementAddStudentConfirmationThisRemove(
                      usuario.comisiones?.last.comision?.nombre ?? '',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
