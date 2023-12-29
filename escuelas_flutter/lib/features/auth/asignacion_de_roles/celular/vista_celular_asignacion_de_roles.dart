import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/asignacion_de_roles/bloc/bloc_asignacion_de_roles.dart';
import 'package:escuelas_flutter/features/auth/asignacion_de_roles/widgets/widget.dart';
import 'package:escuelas_flutter/features/modelos_temporales.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/selector_de_fecha/selector_de_fecha.dart';
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

    final l10n = context.l10n;
    // TODO(Gon): El Scaffold y el appbar deberan ser eliminados cuando se defina la navegacion
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => context.router.pop(),
          child: Icon(
            Icons.arrow_back_ios,
            color: colores.onBackground,
            size: 20.sw,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => context.router.pop(),
            child: Icon(
              Icons.notifications_none,
              color: colores.onBackground,
              size: 25.sw,
            ),
          ),
          SizedBox(width: 10.pw),
        ],
        title: Text(
          l10n.pageRoleAssigmentPendingUsers,
          style: TextStyle(
            color: colores.onBackground,
            fontWeight: FontWeight.w800,
            fontSize: 16.pf,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<BlocAsignacionDeRoles, BlocAsignacionDeRolesEstado>(
        builder: (context, state) {
          if (state.estaCargando) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
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
                                  (usuario) => usuario.rol == rol,
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
                      .toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
