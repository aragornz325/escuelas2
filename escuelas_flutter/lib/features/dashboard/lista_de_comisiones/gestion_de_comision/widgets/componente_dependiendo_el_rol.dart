import 'dart:math';

import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/widgets/escuelas_boton.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ComponenteDependiendoElRol}
/// Componente que depende del rol que quieras mostrar
/// {@endtemplate}
class ComponenteDependiendoElRol extends StatelessWidget {
  /// {@macro ComponenteDependiendoElRol}
  const ComponenteDependiendoElRol({
    required this.tituloDeRol,
    required this.tituloBoton,
    required this.onTap,
    super.key,
  });

  /// Titulo del rol ej: Docente o Alumno.
  final String tituloDeRol;

  /// Titulo del boton.
  final String tituloBoton;

  /// Funcion que se ejecuta al presionar el boton.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tituloDeRol,
              style: TextStyle(
                color: colores.secondary,
                fontSize: 13.pf,
                fontWeight: FontWeight.w800,
              ),
            ),
            EscuelasBoton.textoEIcono(
              color: colores.primary,
              onTap: onTap,
              texto: tituloBoton,
              context: context,
              icono: Icons.person_add_alt_outlined,
            ),
          ],
        ),
        Divider(
          color: colores.secondary,
          height: max(5.ph, 5.sh),
        ),
      ],
    );
  }
}
