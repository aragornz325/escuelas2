import 'package:auto_route/auto_route.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

///{@template ItemUsuarioPendiente}
/// Datos del usuario pendiente
/// {@endtemplate}
class ItemUsuarioPendiente extends StatelessWidget {
  /// {@macro ItemUsuarioPendiente}
  const ItemUsuarioPendiente({
    required this.usuario,
    super.key,
  });

  /// Usuario del que se muestran los datos
  final UsuarioPendiente usuario;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Row(
      children: [
        Expanded(
          child: ElementoLista.usuario(
            avatar: usuario.urlFotoDePerfil,
            nombreUsuario: usuario.nombre,
            context: context,
            onTap: () => context.router.push(
              RutaPerfilUsuarioPendiente(
                idUsuarioPendiente: usuario.id ?? 0,
              ),
            ),
          ),
        ),
        SizedBox(width: 10.pw),
        GestureDetector(
          onTap: () => context.router.push(
            RutaPerfilUsuarioPendiente(
              idUsuarioPendiente: usuario.id ?? 0,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.sw),
              color: colores.primaryContainer,
            ),
            width: 45.sw,
            height: 45.sh,
            child: Center(
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: colores.background,
                size: 15.pw,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
