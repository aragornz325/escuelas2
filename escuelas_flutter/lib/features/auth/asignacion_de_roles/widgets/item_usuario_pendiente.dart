import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/modelos_temporales.dart';
import 'package:escuelas_flutter/theming/base.dart';
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
  final InfoUsuario usuario;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Row(
      children: [
        ElementoLista.usuario(
          nombreUsuario: Text(
            usuario.nombre,
            style: TextStyle(
              fontSize: 14.pf,
              fontWeight: FontWeight.w700,
            ),
          ),
          context: context,
          // TODO(Gon): Navegar a perfil de usuario
          onTap: () {},
        ),
        SizedBox(width: 10.pw),
        GestureDetector(
          // TODO(Gon): Navegar a perfil de usuario
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
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
    );
  }
}
