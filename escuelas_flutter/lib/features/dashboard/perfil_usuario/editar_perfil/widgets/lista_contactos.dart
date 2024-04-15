import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/editar_perfil/bloc/bloc_editar_perfil.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/editar_perfil/widgets/dialogs/dialogs.dart';
import 'package:escuelas_flutter/widgets/elemento_lista.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ListaContactos}
/// Lista de contactos del usuario, en la vista de editar perfil.
/// {@endtemplate}
class ListaContactos extends StatelessWidget {
  /// {@macro ListaContactos}
  const ListaContactos({
    required this.listaDeEmailDeContacto,
    super.key,
  });

  /// Lista de emails de contacto del usuario
  final List<DireccionDeEmail> listaDeEmailDeContacto;

  Future<void> _onEditarContacto(
    BuildContext context, {
    required DireccionDeEmail contacto,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocEditarPerfil>(),
        child: DialogEditarContacto(
          contacto: contacto,
        ),
      ),
    );
  }

  Future<void> _onConfirmarEliminado(
    BuildContext context, {
    required DireccionDeEmail contacto,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocEditarPerfil>(),
        child: DialogConfirmarEliminado(
          contacto: contacto,
          onTapConfirmar: () => context.read<BlocEditarPerfil>().add(
                BlocEditarPerfilEventoEliminarContacto(
                  idDireccionDeEmail: contacto.id ?? 0,
                ),
              ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    return Expanded(
      child: ListView(
        children: listaDeEmailDeContacto
            .map(
              (e) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.ph)
                    .copyWith(bottom: 10.ph),
                child: ElementoLista(
                  tieneBordeVisible: true,
                  altura: 40.ph,
                  borderRadius: 10.sw,
                  onTap: () {
                    if (e.etiqueta == EtiquetaDireccionEmail.personalPrimario) {
                      return;
                    } else {
                      _onEditarContacto(context, contacto: e);
                    }
                  },
                  widgetLateralDerecho:
                      e.etiqueta == EtiquetaDireccionEmail.personalPrimario
                          ? null
                          : IconButton(
                              icon: Icon(
                                Icons.delete_outline_outlined,
                                color: colores.error,
                              ),
                              onPressed: () =>
                                  _onConfirmarEliminado(contacto: e, context),
                            ),
                  texto: Text(
                    // ignore: lines_longer_than_80_chars
                    '${e.etiqueta?.nombreParentezco(context)}     (${e.direccionDeEmail})',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.pf,
                      fontWeight: FontWeight.w700,
                      color: colores.onBackground,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
