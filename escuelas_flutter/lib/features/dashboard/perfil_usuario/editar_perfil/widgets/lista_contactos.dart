import 'dart:math';

import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/widgets/elemento_lista.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ListaContactos}
/// Lista de contactos del usuario, en la vista de editar perfil.
/// {@endtemplate}
class ListaContactos extends StatelessWidget {
  /// {@macro ListaContactos}
  const ListaContactos({
    required this.listaDeContactos,
    super.key,
  });

  final List<DireccionDeEmail> listaDeContactos;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    return SizedBox(
      height: max(150.ph, 150.sh),
      child: ListView(
        children: listaDeContactos
            .map(
              (e) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.ph)
                    .copyWith(bottom: 10.ph),
                child: ElementoLista(
                  tieneBordeVisible: true,
                  altura: 40.ph,
                  borderRadius: 10.sw,
                  onTap: () {
                    if (e.etiqueta == EtiquetaDireccionEmail.otro) {
                      print('email primario');
                    } else {
                      print('no funciona esto');
                    }
                  },
                  texto: Text(
                    e.direccionDeEmail.toUpperCase(),
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

//! TODO(Anyone): Eliminar cuando este el back
class Contacto {
  Contacto({required this.email, required this.nombre});
  String nombre;
  String email;
}
