import 'dart:math';

import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/editar_perfil/bloc/bloc_editar_perfil.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/editar_perfil/widgets/botones_guardar_y_volver.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/editar_perfil/widgets/dialogs/dialog_editar_password.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template _FormularioDePerfilUsuario}
/// Formulario para editar el perfil.
/// {@endtemplate}
class FormularioDePerfilUsuario extends StatefulWidget {
  /// {@macro _FormularioDePerfilUsuario}
  const FormularioDePerfilUsuario({
    this.usuario,
    super.key,
  });

  final Usuario? usuario;

  @override
  State<FormularioDePerfilUsuario> createState() =>
      _FormularioDePerfilUsuarioState();
}

class _FormularioDePerfilUsuarioState extends State<FormularioDePerfilUsuario> {
  /// Controller del telefono
  final _controllerTelefono = TextEditingController();

  /// Controller del Email
  final _controllerEmail = TextEditingController();

  /// Controller del DNI
  final _controllerDNI = TextEditingController();

  /// key del form para las validaciones
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _controllerTelefono.text =
        widget.usuario?.numerosDeTelefono?.firstOrNull?.numeroDeTelefono ?? '';
    _controllerEmail.text =
        widget.usuario?.direccionesDeEmail?.first.direccionDeEmail ?? '';
    _controllerDNI.text = widget.usuario?.dni ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _controllerTelefono.dispose();
    _controllerEmail.dispose();
    _controllerDNI.dispose();

    super.dispose();
  }

  Future<void> _onEditarPassword(
    BuildContext context, {
    required String dniUsuario,
    required int idUsuario,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocEditarPerfil>(),
        child: DialogEditarPassword(
          idUsuario: idUsuario,
          dniUsuario: dniUsuario,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    final l10n = context.l10n;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.pw),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: max(10.ph, 10.sh)),
            Text(
              l10n.commonPhone,
              style: TextStyle(
                fontSize: 13.pf,
                fontWeight: FontWeight.w700,
                color: colores.onBackground,
              ),
            ),
            EscuelasTextfield.soloNumero(
              borderRadius: BorderRadius.all(
                Radius.circular(10.sw),
              ),
              borderSide: BorderSide(
                color: colores.secondary,
              ),
              maxLines: 1,
              controller: _controllerTelefono,
              hintText: l10n.commonPhone,
              context: context,
              onChanged: (v) {},
            ),
            SizedBox(height: max(5.ph, 5.sh)),
            Text(
              l10n.commonEmail,
              style: TextStyle(
                fontSize: 13.pf,
                fontWeight: FontWeight.w700,
                color: colores.onBackground,
              ),
            ),
            EscuelasTextfield.email(
              borderRadius: BorderRadius.all(
                Radius.circular(10.sw),
              ),
              borderSide: BorderSide(
                color: colores.secondary,
              ),
              maxLines: 1,
              controller: _controllerEmail,
              context: context,
              onChanged: (v) {},
            ),
            SizedBox(height: max(10.ph, 10.sh)),
            Text(
              l10n.commonDNI,
              style: TextStyle(
                fontSize: 13.pf,
                fontWeight: FontWeight.w700,
                color: colores.onBackground,
              ),
            ),
            EscuelasTextfield.soloNumero(
              borderRadius: BorderRadius.all(
                Radius.circular(10.sw),
              ),
              borderSide: BorderSide(
                color: colores.secondary,
              ),
              maxLines: 1,
              controller: _controllerDNI,
              hintText: l10n.commonDNI,
              context: context,
              onChanged: (v) {},
            ),
            SizedBox(height: max(5.ph, 5.sh)),
            Center(
              child: EscuelasBoton.texto(
                estaHabilitado: true,
                onTap: () => _onEditarPassword(
                  context,
                  dniUsuario: widget.usuario?.dni ?? '',
                  idUsuario: widget.usuario?.idUserInfo ?? 0,
                ),
                color: colores.amarilloCuartoFalta,
                texto: l10n.pageEditProfileDialogChangePassword,
                context: context,
              ),
            ),
            SizedBox(height: max(20.ph, 20.sh)),
            BotonesGuardarYVolver(
              onTapConfirmar: () {
                context.read<BlocEditarPerfil>().add(
                      BlocEditarPerfilEventoGuardarCambios(
                        usuario: widget.usuario,
                        telefono: _controllerTelefono.text.isNotEmpty
                            ? _controllerTelefono.text
                            : widget.usuario?.numerosDeTelefono?.firstOrNull
                                    ?.numeroDeTelefono ??
                                '',
                        email: _controllerEmail.text.isNotEmpty
                            ? _controllerEmail.text
                            : widget.usuario?.direccionesDeEmail?.firstOrNull
                                    ?.direccionDeEmail ??
                                '',
                        dni: _controllerDNI.text.isNotEmpty
                            ? _controllerDNI.text
                            : widget.usuario?.dni,
                      ),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
