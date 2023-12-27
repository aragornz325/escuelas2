import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/asignacion_de_roles/bloc/bloc_asignacion_de_roles.dart';
import 'package:escuelas_flutter/features/auth/modelos_temporales.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/elemento_lista.dart';
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
            Icons.arrow_back,
            color: colores.onBackground,
          ),
        ),
        title: Text(
          'Usuarios Pendientes',
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
          if (state is BlocAsignacionDeRolesEstadoCargando) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Center(
            child: SizedBox(
              width: 340.pw,
              child: SingleChildScrollView(
                child: Column(
                  children: Roles.values
                      .map(
                        (e) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.name.toUpperCase(),
                              style: TextStyle(
                                color: colores.onSecondary,
                                fontSize: 16.pf,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 10.ph),
                            ...state.listaUsuariosPendientes
                                .where(
                                  (usuario) => usuario.rol == e,
                                )
                                .toList()
                                .map(
                                  (e) => Padding(
                                    padding: EdgeInsets.only(bottom: 10.ph),
                                    child: Row(
                                      children: [
                                        ElementoLista.usuario(
                                          nombreUsuario: Text(
                                            e.nombre,
                                            style: TextStyle(
                                              fontSize: 14.pf,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          context: context,
                                          onTap: () {},
                                        ),
                                        SizedBox(width: 10.pw),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: colores.azul,
                                            ),
                                            width: 38.sw,
                                            height: 38.sh,
                                            child: Center(
                                              child: Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                color: colores.background,
                                                size: 20.sw,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
