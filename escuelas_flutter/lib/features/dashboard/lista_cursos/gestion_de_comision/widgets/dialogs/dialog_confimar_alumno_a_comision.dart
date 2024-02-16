import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/lista_cursos/gestion_de_comision/bloc/bloc_gestion_de_comision.dart';
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

    return EscuelasDialog.solicitudDeAccion(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.sw),
      ),
      onTapConfirmar: () => context.read<BlocGestionDeComision>().add(
            BlocGestionDeComisionEventoAgregarAlumno(
              alumno: usuario,
            ),
          ),
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
                    // TODO(mati): traduccion
                    '¿Estás seguro que deseas agregar a'
                    ' ${usuario.nombre.toUpperCase()} a ${state.idComision}?',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    // TODO(mati): traduccion
                    ' Esto lo quitará permanentemente de '
                    '${usuario.comisiones?.first.comision?.nombre}',
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
