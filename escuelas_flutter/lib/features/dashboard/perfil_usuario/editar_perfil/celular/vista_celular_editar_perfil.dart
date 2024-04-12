import 'dart:math';

import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/editar_perfil/bloc/bloc_editar_perfil.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/editar_perfil/widgets/dialogs/dialogs.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/editar_perfil/widgets/widgets.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularEditarPerfil}
/// Vista para editar el perfil.
/// {@endtemplate}

class VistaCelularEditarPerfil extends StatelessWidget {
  /// {@macro VistaCelularEditarPerfil}
  const VistaCelularEditarPerfil({
    super.key,
  });

  /// dialog de exito al guardar los cambios en la BD
  void _dialogDeExitoAlGuardarCambios(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => const DialogExitoAlGuardarCambios(),
    );
  }

  Future<void> _onAgregarContacto(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocEditarPerfil>(),
        child: DialogAgregarContacto(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocConsumer<BlocEditarPerfil, BlocEditarPerfilEstado>(
        listener: (context, state) {
          if (state is BlocEditarPerfilEstadoExitosoAlActualizar) {
            _dialogDeExitoAlGuardarCambios(context);
          }
          if (state is BlocEditarPerfilEstadoExitosoEditarPassword) {
            _dialogDeExitoAlGuardarCambios(context);
          }
        },
        builder: (context, state) {
          if (state is BlocEditarPerfilEstadoCargando ||
              state.usuario == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return IntrinsicHeight(
            child: ListView(
              children: [
                _DatosPersonalesAEditar(
                  usuario: state.usuario,
                  onTapAgregar: () => _onAgregarContacto(context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// {@template _DatosPersonalesAEditar}
/// Datos personales a editar del usuario
/// {@endtemplate}
class _DatosPersonalesAEditar extends StatelessWidget {
  /// {@macro _DatosPersonalesAEditar}
  const _DatosPersonalesAEditar({
    required this.onTapAgregar,
    this.usuario,
  });

  /// Usuario a editar
  final Usuario? usuario;

  /// FUncion para agregar un contacto
  final VoidCallback onTapAgregar;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.pw),
      child: Container(
        decoration: BoxDecoration(
          color: colores.tertiary,
          borderRadius: BorderRadius.all(Radius.circular(15.sw)),
        ),
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: max(10.ph, 10.sh)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.pw),
                child: Text(
                  l10n.pageRoleAssigmentPersonalInformation.toUpperCase(),
                  style: TextStyle(
                    fontSize: 13.pf,
                    fontWeight: FontWeight.w700,
                    color: colores.onBackground,
                  ),
                ),
              ),
              SizedBox(height: max(10.ph, 10.sh)),
              Divider(
                height: 0,
                color: colores.secondary,
              ),
              FormularioDePerfilUsuario(
                usuario: usuario,
              ),
              SizedBox(height: max(20.ph, 20.sh)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.pw),
                child: Text(
                  l10n.pageEditProfileContacts.toUpperCase(),
                  style: TextStyle(
                    fontSize: 13.pf,
                    fontWeight: FontWeight.w700,
                    color: colores.onBackground,
                  ),
                ),
              ),
              SizedBox(height: max(10.ph, 10.sh)),
              Divider(
                height: 0,
                color: colores.secondary,
              ),
              SizedBox(height: max(10.ph, 10.sh)),
              ListaContactos(
                listaDeEmailDeContacto: usuario?.direccionesDeEmail ?? [],
              ),
              SizedBox(height: max(10.ph, 10.sh)),
              if (usuario!.direccionesDeEmail!.length < 4 ||
                  usuario?.direccionesDeEmail == null)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: FloatingActionButton(
                      backgroundColor: colores.amarilloCuartoFalta,
                      onPressed: onTapAgregar,
                      child: const Icon(Icons.add),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
