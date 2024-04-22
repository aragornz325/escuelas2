import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/perfil_usuario/bloc/bloc_perfil_usuario.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/perfil_usuario/widget/radio_listtile_asignatura_comision.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template DialogQuitarAsignatura}
/// Dialogo para quitar una asignatura del docente
/// {@endtemplate}
class DialogQuitarAsignatura extends StatefulWidget {
  /// {@macro DialogQuitarAsignatura}

  const DialogQuitarAsignatura({
    required this.asignaturas,
    super.key,
  });

  /// Asignaturas del docente a listarse
  final List<RelacionAsignaturaUsuario> asignaturas;
  @override
  State<DialogQuitarAsignatura> createState() => _DialogQuitarAsignaturaState();
}

class _DialogQuitarAsignaturaState extends State<DialogQuitarAsignatura> {
  RelacionAsignaturaUsuario? selectedAsignatura;

  void _onQuitarAsignatura(BuildContext context) {
    final state = context.read<BlocPerfilUsuario>().state;
    context.read<BlocPerfilUsuario>().add(
          BlocPerfilUsuarioEventoQuitarAsignatura(
            asignatura: state.listaAsignaturas.firstWhere(
              (element) => element.id == selectedAsignatura?.asignaturaId,
            ),
            comision: state.listaComisiones.firstWhere(
              (element) => element.id == selectedAsignatura?.comisionId,
            ),
            idUsuario: state.usuario?.id ?? 0,
            idAsignatura: selectedAsignatura?.asignaturaId ?? 0,
            idComision: selectedAsignatura?.comisionId ?? 0,
          ),
        );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colores = context.colores;

    return EscuelasDialog.solicitudDeAccion(
      context: context,
      onTapConfirmar: () => _onQuitarAsignatura(context),
      content: Column(
        children: [
          Text(
            l10n.pageUserProfileSelectTheSubjectToDelete,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.colores.onBackground,
              fontSize: 16.pf,
              fontWeight: FontWeight.w900,
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.commonSubject),
              Text(l10n.commonCourse),
              Icon(
                Icons.delete_outline_outlined,
                color: colores.error,
                size: 20.sw,
              ),
            ],
          ),
          const Divider(),
          RadioListTileAsignaturaComision(
            asignaturas: widget.asignaturas,
            onChanged: (p0) => setState(() {
              selectedAsignatura = p0;
            }),
          ),
        ],
      ),
    );
  }
}
