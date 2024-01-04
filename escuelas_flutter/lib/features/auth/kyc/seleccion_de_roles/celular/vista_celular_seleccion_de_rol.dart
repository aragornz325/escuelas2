import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/kyc/bloc/bloc_kyc.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/escuelas_boton.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularSeleccionDeRol}
/// Vista Celular de la pantalla Seleccion de Rol donde el usuario elige que
/// rol quiere solicitar.
/// {@endtemplate}
class VistaCelularSeleccionDeRol extends StatefulWidget {
  /// {@macro VistaCelularSeleccionDeRol}
  const VistaCelularSeleccionDeRol({super.key});

  @override
  State<VistaCelularSeleccionDeRol> createState() =>
      _VistaCelularSeleccionDeRolState();
}

class _VistaCelularSeleccionDeRolState
    extends State<VistaCelularSeleccionDeRol> {
  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return BlocBuilder<BlocKyc, BlocKycEstado>(
      builder: (context, state) {
        final rolPresionado = state.rolElegido;

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.pw),
              child: Column(
                children: [
                  SizedBox(height: 20.ph),
                  // TODO(Gon): Usar nombre del usuario logeado
                  Text(
                    l10n.pageKycRoleSelectionWelcome('Gonzalo Rigoni'),
                    style: TextStyle(
                      color: colores.onBackground,
                      fontSize: 14.pf,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20.ph),
                  ...state.listaRoles.map(
                    (rol) => Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20.ph),
                        child: ElementoLista.rol(
                          context: context,
                          nombreRol: rol.nombre,
                          estaPresionado: rol.id == rolPresionado?.id,
                          onTap: () => context.read<BlocKyc>().add(
                                BlocKycEventoSeleccionarRol(
                                  rolElegido: rol,
                                  eliminarRolSeleccionado:
                                      rolPresionado?.id == rol.id &&
                                          rolPresionado != null,
                                ),
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20.ph),
                  child: EscuelasBoton.texto(
                    context: context,
                    estaHabilitado: rolPresionado != null,
                    // TODO(Gon): Esto se va a cambiar cuando cambie la navegacion
                    onTap: () => context.router.push(
                      const RutaFormulario(),
                    ),
                    color: rolPresionado != null
                        ? colores.azul
                        : colores.grisDeshabilitado,
                    texto: l10n.commonContinue.toUpperCase(),
                  ),
                ),
                if (rolPresionado != null)
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.pw,
                          vertical: 20.ph,
                        ),
                        child: Text(
                          l10n.pageRoleConfirmationText(
                            rolPresionado.nombre,
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: colores.onSecondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 13.pf,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
