import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/seleccion_de_rol/bloc/bloc_seleccion_de_rol.dart';
import 'package:escuelas_flutter/features/auth/seleccion_de_rol/widgets/tarjeta_rol.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/escuelas_boton.dart';
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
  // TODO(Gon): Ver si es mejor usar un rol entero en vez de solo la id

  /// Indica que rol de la lista esta seleccionado
  int rolPresionado = -1;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    // TODO(Gon): El Scaffold y el appbar deberan ser eliminados cuando se defina la navegacion
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.pageRoleSelectionTitle,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 20.ph),
                // TODO(Gon): Usar nombre del usuario logeado
                Text(
                  l10n.pageRoleSelectionWelcome('Gonzalo Rigoni'),
                  style: TextStyle(
                    color: colores.onBackground,
                    fontSize: 14.pf,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20.ph),
                BlocBuilder<BlocSeleccionDeRol, BlocSeleccionDeRolEstado>(
                  builder: (context, state) {
                    if (state.estaEnEstadoCargando) {
                      const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Column(
                      children: [
                        ...state.listaRoles.map(
                          (rol) => Center(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 10.ph),
                              child: TarjetaRol(
                                nombreRol: rol.nombre,
                                estaPresionado: rolPresionado == rol.id,
                                onTap: () => setState(() {
                                  rolPresionado = rol.id;
                                }),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            Column(
              children: [
                EscuelasBoton.texto(
                  context: context,
                  estaHabilitado: rolPresionado != -1,
                  // TODO(Gon): Dar funcion(llevar a la pag de KYC)
                  onTap: () {},
                  color: rolPresionado != -1
                      ? colores.azul
                      : colores.grisDeshabilitado,
                  texto: l10n.commonContinue.toUpperCase(),
                ),
                if (rolPresionado != -1)
                  Column(
                    children: [
                      SizedBox(height: 40.ph),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.pw),
                        child: BlocBuilder<BlocSeleccionDeRol,
                            BlocSeleccionDeRolEstado>(
                          builder: (context, state) {
                            final nombreRolSeleccionado = state.listaRoles
                                .where(
                                  (element) => element.id == rolPresionado,
                                )
                                .first
                                .nombre;
                            return Text(
                              l10n.pageRoleConfirmationText(
                                nombreRolSeleccionado,
                              ),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: colores.onSecondary,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.pf,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
