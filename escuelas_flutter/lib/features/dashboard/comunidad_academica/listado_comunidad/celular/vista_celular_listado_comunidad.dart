import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/comunidad_academica/bloc/bloc_comunidad_academica.dart';
import 'package:escuelas_flutter/features/dashboard/comunidad_academica/listado_comunidad/widgets/selector_categoria.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularListadoComunidad}
/// Vista celular del listado de la comunidad academica donde se muestran los
/// usuarios de la categoria seleccionada
/// {@endtemplate}
class VistaCelularListadoComunidad extends StatefulWidget {
  /// {@macro VistaCelularListadoComunidad}
  const VistaCelularListadoComunidad({super.key});

  @override
  State<VistaCelularListadoComunidad> createState() =>
      _VistaCelularListadoComunidadState();
}

class _VistaCelularListadoComunidadState
    extends State<VistaCelularListadoComunidad> {
  @override
  void initState() {
    context
        .read<BlocComunidadAcademica>()
        .add(BlocComunidadAcademicaEventoOrdenarAlfabeticamente());
    super.initState();
  }

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
          return Column(
            children: [
              Center(
                child: Text(
                  // TODO(anyone): Hacer que ponga el nombre del rol seleccionado en plural
                  'DOCENTES',
                  style: TextStyle(
                    color: colores.onBackground,
                    fontSize: 16.pf,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SelectorDeOrdenamiento(),
              ...state.listaOrdenada.map((orden) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 10.ph),
                  child: Column(
                    children: [
                      Text(orden.categoria),
                      Column(
                        children: orden.lista
                            .map(
                              (usuario) => ElementoLista.usuario(
                                onTap: () => context.router.push(
                                  RutaPerfilUsuario(
                                    idUsuario: usuario.id,
                                  ),
                                ),
                                // TODO(anyone): Cambiar esto al nombre del usuario
                                nombreUsuario: usuario.dni,
                                context: context,
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
