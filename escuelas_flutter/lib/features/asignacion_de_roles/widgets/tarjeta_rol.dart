import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/widgets/elemento_lista.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

class TarjetaRol extends StatelessWidget {
  const TarjetaRol({
    required this.nombreRol,
    super.key,
  });
  final String nombreRol;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    return ElementoLista(
      titulo: nombreRol,
      altura: 65.ph,
      ancho: 330.pw,
      borderRadius: 20.sw,
      colorFondo: colores.tertiary,
      fontSize: 16.pf,
      fontWeight: FontWeight.w700,
    );
  }
}
