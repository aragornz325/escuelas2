import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/comunidad_academica/bloc/bloc_comunidad_academica.dart';
import 'package:escuelas_flutter/features/dashboard/comunidad_academica/listado_comunidad/widgets/elemento_listado_comunidad.dart';
import 'package:escuelas_flutter/features/dashboard/comunidad_academica/listado_comunidad/widgets/selector_categoria.dart';
import 'package:escuelas_flutter/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularListadoComunidad}
/// Vista celular del listado de la comunidad academica donde se muestran los
/// usuarios de la categoria seleccionada
/// {@endtemplate}
class VistaCelularListadoComunidad extends StatefulWidget {
  /// {@macro VistaCelularListadoComunidad}
  const VistaCelularListadoComunidad({
    super.key,
  });

  @override
  State<VistaCelularListadoComunidad> createState() =>
      _VistaCelularListadoComunidadState();
}

class _VistaCelularListadoComunidadState
    extends State<VistaCelularListadoComunidad> {
  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.pw,
        vertical: 20.ph,
      ),
      child: BlocBuilder<BlocComunidadAcademica, BlocComunidadAcademicaEstado>(
        builder: (context, state) {
          final listaUsuarios = state.listaUsuarios;
          if (listaUsuarios == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final rolElegido = state.rolElegido;
          if (rolElegido == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: [
              Center(
                child: Text(
                  '${rolElegido.name.toUpperCase()}S',
                  style: TextStyle(
                    color: colores.onBackground,
                    fontSize: 16.pf,
                    fontWeight: FontWeight.w900,
                    fontFamily: FontFamily.nunito,
                  ),
                ),
              ),
              SizedBox(height: max(15.ph, 15.sh)),
              const SelectorDeOrdenamiento(),
              SizedBox(height: max(15.ph, 15.sh)),
              Expanded(
                child: ListView.builder(
                  itemCount: listaUsuarios.usuariosListados.length,
                  itemBuilder: (context, index) {
                    if (listaUsuarios
                        .usuariosListados[index].usuarios.isEmpty) {
                      return Container();
                    }

                    return ElementoListadoComunidad(
                      rolElegido: rolElegido,
                      ordenarPor: state.ordenarPor,
                      titulo: listaUsuarios
                          .usuariosListados[index].etiquetaDelIndexListado
                          .toUpperCase(),
                      usuariosListados: listaUsuarios.usuariosListados[index],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
