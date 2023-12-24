import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/elemento_lista.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template TarjetaRol}
/// Tarjeta que muestra el nombre de un rol
/// {@endtemplate}
class TarjetaRol extends StatelessWidget {
  /// {@macro TarjetaRol}
  const TarjetaRol({
    required this.nombreRol,
    required this.estaPresionado,
    this.onTap,
    super.key,
  });

  /// Nombre del rol
  final String nombreRol;

  /// Indica si la tarjeta esta presionada
  final bool estaPresionado;

  /// Procesa el evento de presionar la tarjeta
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return ElementoLista(
      titulo: nombreRol,
      altura: 65.ph,
      ancho: 330.pw,
      borderRadius: 20.sw,
      colorFondo:
          estaPresionado ? colores.grisBotonPresionado : colores.tertiary,
      fontSize: 16.pf,
      fontWeight: FontWeight.w900,
      onTap: onTap,
      boxShadow: estaPresionado
          ? [
              BoxShadow(
                blurRadius: 50,
                offset: const Offset(0, -4),
                color: Colors.grey.shade200,
                inset: true,
              ),
              BoxShadow(
                blurRadius: 4,
                offset: const Offset(0, 4),
                inset: true,
                color: colores.grisSC,
              ),
            ]
          : [],
    );
  }
}
