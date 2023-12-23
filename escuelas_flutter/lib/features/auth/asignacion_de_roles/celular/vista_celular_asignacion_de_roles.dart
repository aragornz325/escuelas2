import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/asignacion_de_roles/bloc/bloc_asignacion_de_roles.dart';
import 'package:escuelas_flutter/features/auth/asignacion_de_roles/widgets/widgets.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/escuelas_boton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularAsignacionDeRoles}
/// Vista Celular de la pantalla Asignación de Roles donde el usuario elige que
/// rol quiere solicitar.
/// {@endtemplate}
class VistaCelularAsignacionDeRoles extends StatelessWidget {
  /// {@macro VistaCelularAsignacionDeRoles}
  const VistaCelularAsignacionDeRoles({super.key});

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Scaffold(
      appBar: AppBar(
        title: Text(
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
      body: BlocBuilder<BlocAsignacionDeRoles, BlocAsignacionDeRolesEstado>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(bottom: 40.ph),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(height: 20.ph),
                    const Text(
                      '¡Hola, “Nombre Apellido”, decinos cual es tu rol!',
                    ),
                    SizedBox(height: 20.ph),
                    ...state.listaRoles.map(
                      (rol) => Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 10.ph),
                          child: TarjetaRol(nombreRol: rol.nombre),
                        ),
                      ),
                    ),
                  ],
                ),
                EscuelasBoton.texto(
                  context: context,
                  estaHabilitado: true,
                  onTap: () {},
                  color: colores.grisDeshabilitado,
                  texto: 'CONTINUAR',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
