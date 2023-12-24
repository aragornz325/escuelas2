import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/seleccion_de_rol/bloc/bloc_seleccion_de_rol.dart';
import 'package:escuelas_flutter/features/auth/seleccion_de_rol/widgets/tarjeta_rol.dart';
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
  /// Indica que rol de la lista esta seleccionado
  int rolPresionado = -1;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          // TODO(Gon): l10n
          'Asignación de Roles',
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
                const Text(
                  // TODO(Gon): l10n
                  '¡Hola, “Nombre Apellido”, decinos cual es tu rol!',
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
                  // TODO(Gon): l10n
                  texto: 'CONTINUAR',
                ),
                if (rolPresionado != -1)
                  Column(
                    children: [
                      SizedBox(height: 40.ph),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.pw),
                        child: Text(
                          // TODO(Gon): l10n
                          'Te registrarás con el rol "Directivo". Todo rol'
                          ' tiene que ser aprobado por el administrador. '
                          'Una vez aprobado podrás usar la app.',
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
        ),
      ),
    );
  }
}
