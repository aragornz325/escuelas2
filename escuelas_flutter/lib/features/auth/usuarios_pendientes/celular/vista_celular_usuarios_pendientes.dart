import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/usuarios_pendientes/bloc/bloc_usuarios_pendientes.dart';
import 'package:escuelas_flutter/features/auth/usuarios_pendientes/widgets/item_usuario_pendiente.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularUsuariosPendientes}
/// Vista Celular de la pantalla Usuarios Pendientes donde el admin revisa los
/// roles solcitados
/// {@endtemplate}
class VistaCelularUsuariosPendientes extends StatelessWidget {
  /// {@macro VistaCelularUsuariosPendientes}
  const VistaCelularUsuariosPendientes({super.key});

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return BlocBuilder<BlocUsuariosPendientes, BlocUsuariosPendientesEstado>(
      builder: (context, state) {
        if (state.estaCargando) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.listaUsuariosPendientes.isEmpty) {
          return Center(
            child: Text(
              l10n.pageRoleAssigmentNoPendingUsers,
              style: TextStyle(
                color: colores.onSecondary,
                fontSize: 16.pf,
                fontWeight: FontWeight.w800,
              ),
            ),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.pw),
            child: Column(
              children: state.listaRoles
                  .map(
                    (rol) => state.listaUsuariosPendientes.any(
                      (usuario) => usuario.idRolSolicitado == rol.id,
                    )
                        ? Padding(
                            padding: EdgeInsets.only(bottom: 20.pw),
                            child: Column(
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
                                ...state.listaUsuariosPendientes
                                    .where(
                                      (usuario) =>
                                          usuario.idRolSolicitado == rol.id,
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
                              ],
                            ),
                          )
                        : Container(),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
