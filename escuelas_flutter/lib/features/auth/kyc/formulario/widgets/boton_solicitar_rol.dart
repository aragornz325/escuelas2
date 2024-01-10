import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/kyc/bloc/bloc_kyc.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/utilidades/cliente_serverpod.dart';
import 'package:escuelas_flutter/widgets/escuelas_boton.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template BotonSolicitarRol}
/// Botón para solicitar rol
/// {@endtemplate}
class BotonSolicitarRol extends StatelessWidget {
  /// {@macro BotonSolicitarRol}
  const BotonSolicitarRol({
    super.key,
  });

  Future<void> _dialogSolicitarRol(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<BlocKyc>(),
          child: const DialogSolicitarRol(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return BlocBuilder<BlocKyc, BlocKycEstado>(
      builder: (context, state) {
        return EscuelasBoton.texto(
          context: context,
          estaHabilitado: state.rolElegido != null,
          onTap: () => _dialogSolicitarRol(context),
          color: state.opcionesFormulario.isNotEmpty
              ? colores.azul
              : colores.grisDeshabilitado,
          texto: l10n.commonApply,
        );
      },
    );
  }
}

class DialogSolicitarRol extends StatelessWidget {
  const DialogSolicitarRol({
    super.key,
  });

  void _enviarSolicitudRegistro(BuildContext context) {
    context.read<BlocKyc>().add(
          BlocKycEventoSolicitarRegistro(
            userInfo: sessionManager.signedInUser,
          ),
        );
    Navigator.pop(context);
    context.router.push(const RutaEspera());
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return EscuelasDialog.confirmar(
      onTapConfirmar: () => _enviarSolicitudRegistro(context),
      content: BlocBuilder<BlocKyc, BlocKycEstado>(
        builder: (context, state) {
          return Text(
            l10n.pageKycFormConfirmationDialogText(
              state.rolElegido?.nombre ?? '',
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.pf,
              fontWeight: FontWeight.w600,
              color: colores.grisSC,
            ),
          );
        },
      ),
    );
  }
}
