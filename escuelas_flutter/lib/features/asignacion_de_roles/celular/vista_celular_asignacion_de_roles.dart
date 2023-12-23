import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/asignacion_de_roles/bloc/bloc_asignacion_de_roles.dart';
import 'package:escuelas_flutter/features/asignacion_de_roles/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

class VistaCelularAsignacionDeRoles extends StatelessWidget {
  const VistaCelularAsignacionDeRoles({super.key});

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Asignacion de roles',
          style: TextStyle(
            color: colores.onBackground,
            fontWeight: FontWeight.w700,
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
                ElevatedButton(onPressed: () {}, child: Text('CONTINUAR'))
              ],
            ),
          );
        },
      ),
    );
  }
}
