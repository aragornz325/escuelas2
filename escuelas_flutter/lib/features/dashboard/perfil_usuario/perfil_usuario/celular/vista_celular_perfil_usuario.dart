import 'package:escuelas_flutter/extensiones/usuario.dart';
import 'package:escuelas_flutter/features/dashboard/bloc_dashboard/bloc_dashboard.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/perfil_usuario/bloc/bloc_perfil_usuario.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/perfil_usuario/widget/widget.dart';
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

  /// Dialog que notifica que el usuario ha sido eliminado exitosamente
  Future<void> _eliminadoConExito(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<BlocPerfilUsuario>(),
          child: const DialogEliminadoConExito(),
        );
      },
    );
  }

  Future<void> _yaTieneEstaAsignatura(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<BlocPerfilUsuario>(),
          child: const DialogYaTieneEstaAsignatura(),
        );
      },
    );
  }

  Future<void> _materiaAsignadaConExito(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<BlocPerfilUsuario>(),
          child: const DialogExitoAlAsignarMateria(),
        );
      },
    );
  }

  Future<void> _materiadesAsignadaConExito(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<BlocPerfilUsuario>(),
          child: const DialogExitoAlDesasignarMateria(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final usuarioLogueado = context.read<BlocDashboard>().state.usuario;
    return BlocConsumer<BlocPerfilUsuario, BlocPerfilUsuarioEstado>(
      listener: (context, state) {
        if (state is BlocPerfilUsuarioEstadoExitosoAlEliminarUsuario) {
          _eliminadoConExito(context);
        }
        if (state is BlocPerfilUsuarioEstadoYaTieneEstaAsignatura) {
          _yaTieneEstaAsignatura(context);
        }
        if (state is BlocPerfilUsuarioEstadoExitoAlAsignarMateria) {
          _materiaAsignadaConExito(context);
        }
        if (state is BlocPerfilUsuarioEstadoExitoAlDesasignarMateria) {
          _materiadesAsignadaConExito(context);
        }
      },
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
              rolesAsignados: state.usuario?.nombreRoles ?? '',
              nombreUsuario: state.usuario?.nombre ?? '',
              apellidoUsuario: state.usuario?.apellido ?? '',
              urlImage: state.usuario?.urlFotoDePerfil ?? '',
              usuario: state.usuario,
              usuarioLogueado: usuarioLogueado,
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
