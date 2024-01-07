import 'package:escuelas_flutter/features/dashboard/perfil_usuario/bloc/bloc_perfil_usuario.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/widgets/seccion_cursos.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/widgets/seccion_datos_personales.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/widgets/tarjeta_perfil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template VistaCelularPerfilUsuario}
/// Vista celular de la pantalla 'Perfil de usuario'
/// {@endtemplate}
class VistaCelularPerfilUsuario extends StatelessWidget {
  /// {@macro VistaCelularPerfilUsuario}
  const VistaCelularPerfilUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocPerfilUsuario, BlocPerfilUsuarioEstado>(
      builder: (context, state) {
        if (state is BlocPerfilUsuarioEstadoCargando) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TarjetaPerfil(
              nombreRol: state.nombreRol,
              nombreUsuario: state.usuario?.nombre ?? '',
              apellidoUsuario: state.usuario?.apellido ?? '',
            ),
            const Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DatosPersonales(),
                    SeccionCursos(),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
