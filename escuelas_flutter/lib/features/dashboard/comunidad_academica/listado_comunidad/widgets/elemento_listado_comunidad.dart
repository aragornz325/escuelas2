import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/widgets/elemento_lista.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';
import 'package:rolemissions/rolemissions.dart';

///{@template ElementoListadoComunidad}
///Elemento del listado de la comunidad academica
///{@endtemplate}
class ElementoListadoComunidad extends StatelessWidget {
  ///{@macro ElementoListadoComunidad}
  const ElementoListadoComunidad({
    required this.titulo,
    required this.usuariosListados,
    required this.ordenarPor,
    required this.rolElegido,
    super.key,
  });

  /// Titulo que recibe el el elemento de listado.
  final String titulo;

  /// Lista de usuarios
  final UsuariosListados usuariosListados;

  /// Verifica si es del listado nombre para enviar o no widget derecho
  final OrdenarPor ordenarPor;

  /// Rol de usuario elegido previamente
  final Role rolElegido;
  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.pw, top: max(10.ph, 10.sh)),
          child: Text(
            titulo,
            style: TextStyle(
              color: colores.onSecondary,
              fontSize: 13.pf,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Column(
          children: usuariosListados.usuarios
              .map(
                (usuario) => Padding(
                  padding: EdgeInsets.symmetric(vertical: max(10.ph, 10.sh)),
                  child: ElementoLista.usuarioCA(
                    usuario: usuario,
                    ordenarPor: ordenarPor,
                    onTap: () => context.router.push(
                      RutaPerfilUsuario(
                        idUsuario: usuario.idUserInfo,
                      ),
                    ),
                    avatar: usuario.urlFotoDePerfil,
                    nombreUsuario: usuario.apellido,
                    context: context,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
