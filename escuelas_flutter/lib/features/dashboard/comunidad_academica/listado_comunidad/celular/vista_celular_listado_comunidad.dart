import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/comunidad_academica/bloc/bloc_comunidad_academica.dart';
import 'package:escuelas_flutter/features/dashboard/comunidad_academica/listado_comunidad/widgets/elemento_listado_comunidad.dart';
import 'package:escuelas_flutter/features/dashboard/comunidad_academica/listado_comunidad/widgets/selector_categoria.dart';
import 'package:escuelas_flutter/gen/fonts.gen.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
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

    final l10n = context.l10n;

    return BlocBuilder<BlocComunidadAcademica, BlocComunidadAcademicaEstado>(
      builder: (context, state) {
        if (state.listaUsuarios == null ||
            state is BlocComunidadAcademicaEstadoCargando) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Column(
          children: [
            Center(
              child: Text(
                '${state.rolElegido?.name.toUpperCase()}',
                style: TextStyle(
                  color: colores.onBackground,
                  fontSize: 16.pf,
                  fontWeight: FontWeight.w900,
                  fontFamily: FontFamily.nunito,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.ph),
              child: const SelectorDeOrdenamiento(),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.pw),
                  child: state.estaVacio
                      ? Center(
                          child: Text(
                            l10n.pageAcademicCommunityNoUsersToShow,
                            style: TextStyle(
                              color: colores.onBackground,
                              fontSize: 16.pf,
                              fontWeight: FontWeight.w500,
                              fontFamily: FontFamily.nunito,
                            ),
                          ),
                        )
                      : Column(
                          children: state.listaUsuarios?.usuariosListados
                                  .map(
                                    (e) => e.usuarios.isEmpty
                                        ? Container()
                                        : ElementoListadoComunidad(
                                            rolElegido: state.rolElegido,
                                            ordenarPor: state.ordenarPor,
                                            titulo: e.etiquetaDelIndexListado
                                                .toUpperCase(),
                                            usuariosListados: e,
                                          ),
                                  )
                                  .toList() ??
                              [],
                        ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
