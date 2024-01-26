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
  final UsuariosListados? usuariosListados;

  /// Verifica si es del listado nombre para enviar o no widget derecho
  final OrdenarPor ordenarPor;

  /// Rol de usuario elegido previamente
  final Role? rolElegido;
  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Padding(
      padding: EdgeInsets.only(bottom: 10.ph),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.pw),
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
            children: usuariosListados?.usuarios
                    .map(
                      (usuario) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.ph),
                        child: ElementoLista.usuarioComunidadAcademica(
                          usuario: usuario,
                          ordenarPor: ordenarPor,
                          onTap: () => context.router.push(
                            RutaPerfilUsuario(
                              idUsuario: usuario.id ?? 0,
                            ),
                          ),
                          avatar: usuario.urlFotoDePerfil,
                          nombreUsuario: usuario.apellido,
                          context: context,
                        ),
                      ),
                    )
                    .toList() ??
                [],
          ),
        ],
      ),
    );
  }
}
