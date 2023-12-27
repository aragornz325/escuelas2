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

    // TODO(Gon): El Scaffold y el appbar deberan ser eliminados cuando se defina la navegacion
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.pageKycRoleSelectionTitle,
          style: TextStyle(
            color: colores.onBackground,
            fontWeight: FontWeight.w900,
            fontSize: 16.pf,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: 40.ph),
        child: BlocBuilder<BlocKyc, BlocKycEstado>(
          builder: (context, state) {
            final rolPresionado = state.rolElegido;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
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
                    Column(
                      children: [
                        // TODO (Gon): Mostrar roles correspondientes a los permisos del usuario
                        ...state.listaRoles.map(
                          (rol) => Center(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 10.ph),
                              child: ElementoLista.rol(
                                context: context,
                                nombreRol: Text(
                                  rol.nombre,
                                  style: TextStyle(
                                    fontSize: 16.pf,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                estaPresionado: rol.id == rolPresionado?.id,
                                onTap: () => context.read<BlocKyc>().add(
                                      BlocKycEventoSeleccionarRol(
                                        rolElegido: rol,
                                        eliminarRolSeleccionado:
                                            state.rolElegido?.id == rol.id &&
                                                state.rolElegido != null,
                                      ),
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    EscuelasBoton.texto(
                      context: context,
                      estaHabilitado: rolPresionado != null,
                      // TODO(Gon): Esto se va a cambiar cuando cambie la navegacion
                      onTap: () => context.router.push(
                        PaginaKyc(
                          rolElegido: rolPresionado!,
                        ),
                      ),
                      color: rolPresionado != null
                          ? colores.azul
                          : colores.grisDeshabilitado,
                      texto: l10n.commonContinue.toUpperCase(),
                    ),
                    if (rolPresionado != null)
                      Column(
                        children: [
                          SizedBox(height: 40.ph),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.pw),
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
        ),
      ),
    );
  }
}
