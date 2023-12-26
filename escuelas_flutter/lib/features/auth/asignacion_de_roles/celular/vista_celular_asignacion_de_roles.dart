import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/asignacion_de_roles/bloc/bloc_asignacion_de_roles.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularAsignacionDeRoles}
/// TODO(anyone): AGREGAR DOCUMENTACION.
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
          return Column(
            children: [],
          );
        },
      ),
    );
  }
}
