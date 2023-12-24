import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/kyc/bloc/bloc_kyc.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/escuelas_boton.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template BotonSolicitarRol}
/// Botón para solicitar rol
/// {@endtemplate}
class BotonSolicitarRol extends StatelessWidget {
  /// {@macro BotonSolicitarRol}
  const BotonSolicitarRol({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return BlocBuilder<BlocKyc, BlocKycEstado>(
      builder: (context, state) {
        return EscuelasBoton.texto(
          context: context,
          // TODO(Gon): Cambiar esta logica a una mejor, xq no esta bueno inicializar el nombre en vacio
          // TODO(Gon): Tambien ver xq si no esta esto rompe state.opcionesKyc.isNotEmpty
          estaHabilitado: state.opcionesKyc.isNotEmpty &&
              state.opcionesKyc[0].curso.nombre != '' &&
              state.opcionesKyc[0].materia.nombre != '',
          onTap: () => showDialog<void>(
            context: context,
            builder: (context) {
              return EscuelasDialog.confirmar(
                context: context,
                // TODO(Gon): Enviar solicitud de rol al admin
                onTapConfirmar: () {},
                titulo: l10n.pageKycConfirmationDialogText(
                  state.rolElegido?.nombre ?? '',
                ),
              );
            },
          ),
          color: state.opcionesKyc.isNotEmpty &&
                  state.opcionesKyc[0].curso.nombre != '' &&
                  state.opcionesKyc[0].materia.nombre != ''
              ? colores.azul
              : colores.grisDeshabilitado,

          texto: l10n.commonApply,
        );
      },
    );
  }
}
