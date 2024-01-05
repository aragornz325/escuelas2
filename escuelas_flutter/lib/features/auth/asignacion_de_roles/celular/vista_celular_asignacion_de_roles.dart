import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/asignacion_de_roles/bloc/bloc_asignacion_de_roles.dart';
import 'package:escuelas_flutter/features/auth/asignacion_de_roles/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularAsignacionDeRoles}
/// Vista Celular de la pantalla Asignacion de Rol donde el admin revisa los
/// roles solcitados
/// {@endtemplate}
class VistaCelularAsignacionDeRoles extends StatelessWidget {
  /// {@macro VistaCelularAsignacionDeRoles}
  const VistaCelularAsignacionDeRoles({super.key});

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return BlocBuilder<BlocAsignacionDeRoles, BlocAsignacionDeRolesEstado>(
      builder: (context, state) {
        if (state.estaCargando) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.pw),
            child: Column(
              children: Roles.values
                  .map(
                    (rol) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          rol.name.toUpperCase(),
                          style: TextStyle(
                            color: colores.onSecondary,
                            fontSize: 16.pf,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 10.ph),
                        ...state.listaUsuariosPendientes
                            .where(
                              (usuario) => usuario.roles == rol,
                            )
                            .toList()
                            .map(
                              (usuario) => Padding(
                                padding: EdgeInsets.only(bottom: 10.ph),
                                child: ItemUsuarioPendiente(
                                  usuario: usuario,
                                ),
                              ),
                            ),
                        SizedBox(height: 20.ph),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
