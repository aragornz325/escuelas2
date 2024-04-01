import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/editar_perfil/bloc/bloc_editar_perfil.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/editar_perfil/widgets/dialogs/dialogs.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/editar_perfil/widgets/widgets.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularEditarPerfil}
/// Vista para editar el perfil.
/// {@endtemplate}

class VistaCelularEditarPerfil extends StatelessWidget {
  /// {@macro VistaCelularEditarPerfil}
  const VistaCelularEditarPerfil({
    required this.dniUsuario,
    required this.idUsuario,
    super.key,
  });

  /// DNI del usuario
  final String dniUsuario;

  /// id del usuario
  final int idUsuario;

  /// dialog de exito al guardar los cambios en la BD
  void _dialogDeExitoAlGuardarCambios(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => const DialogExitoAlGuardarCambios(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocListener<BlocEditarPerfil, BlocEditarPerfilEstado>(
        listener: (context, state) {
          if (state is BlocEditarPerfilEstadoExitosoAlActualizar) {
            _dialogDeExitoAlGuardarCambios(context);
          }
          if (state is BlocEditarPerfilEstadoExitosoEditarPassword) {
            _dialogDeExitoAlGuardarCambios(context);
          }
        },
        child: ListView(
          children: [
            _DatosPersonalesAEditar(
              idUsuario: idUsuario,
              dniUsuario: dniUsuario,
            ),
            SizedBox(height: max(20.ph, 20.sh)),
            const BotonesGuardarYVolver(),
          ],
        ),
      ),
    );
  }
}

/// {@template _DatosPersonalesAEditar}
/// Datos personales a editar del usuario
/// {@endtemplate}
class _DatosPersonalesAEditar extends StatelessWidget {
  /// {@macro _DatosPersonalesAEditar}
  const _DatosPersonalesAEditar({
    required this.dniUsuario,
    required this.idUsuario,
  });

  final String dniUsuario;
  final int idUsuario;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.pw),
      child: Container(
        decoration: BoxDecoration(
          color: colores.tertiary,
          borderRadius: BorderRadius.all(Radius.circular(15.sw)),
        ),
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: max(10.ph, 10.sh)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.pw),
                child: Text(
                  l10n.pageRoleAssigmentPersonalInformation.toUpperCase(),
                  style: TextStyle(
                    fontSize: 13.pf,
                    fontWeight: FontWeight.w700,
                    color: colores.onBackground,
                  ),
                ),
              ),
              SizedBox(height: max(10.ph, 10.sh)),
              Divider(
                height: 0,
                color: colores.secondary,
              ),
              FormularioDePerfilUsuario(
                dniUsuario: dniUsuario,
                idUsuario: idUsuario,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
