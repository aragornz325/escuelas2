import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/extensiones/ordenar_por.dart';
import 'package:escuelas_flutter/features/dashboard/comunidad_academica/bloc/bloc_comunidad_academica.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template SelectorDeOrden}
/// Muestra en que orden se esta mostrando la lista de usuarios con la
/// posibilidad de cambiarlo
/// {@endtemplate}
class SelectorDeOrdenamiento extends StatefulWidget {
  /// {@macro SelectorDeOrden}
  const SelectorDeOrdenamiento({
    super.key,
  });

  @override
  State<SelectorDeOrdenamiento> createState() => _SelectorDeOrdenamientoState();
}

class _SelectorDeOrdenamientoState extends State<SelectorDeOrdenamiento> {
  int index = 0;

  ///  Cambia el ordenamiento del listado

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Container(
      height: 30.ph,
      decoration: BoxDecoration(
        color: colores.tertiary,
        borderRadius: BorderRadius.circular(50.sw),
      ),
      child: BlocBuilder<BlocComunidadAcademica, BlocComunidadAcademicaEstado>(
        builder: (context, state) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...state.listaUsuarios?.opcionesDeOrdenamiento.map(
                    (e) => _ItemCategoria(
                      itemSeleccionado: state.ordenarPor,
                      enumOrdenar: e,
                    ),
                  ) ??
                  [],
            ],
          );
        },
      ),
    );
  }
}

/// {@template _ItemCategoria}
/// Item de la lista de categorias
/// {@endtemplate}
class _ItemCategoria extends StatelessWidget {
  /// {@macro _ItemCategoria}
  const _ItemCategoria({
    required this.itemSeleccionado,
    required this.enumOrdenar,
  });

  /// Indica si esta seleccionado
  final OrdenarPor itemSeleccionado;

  /// Indica si cual es el item seleccionado
  final OrdenarPor enumOrdenar;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final estaSeleccionado = enumOrdenar == itemSeleccionado;

    final idRol = context.read<BlocComunidadAcademica>().state.idRol;

    return GestureDetector(
      onTap: () => context.read<BlocComunidadAcademica>().add(
            BlocComunidadAcademicaEventoTraerUsuariosPorRol(
              ordenarPor: enumOrdenar,
              idRol: idRol,
            ),
          ),
      child: Container(
        width: 80.pw,
        height: 30.ph,
        decoration: BoxDecoration(
          color: estaSeleccionado ? colores.primaryContainer : colores.tertiary,
          borderRadius: BorderRadius.circular(50.sw),
        ),
        child: Center(
          child: Text(
            enumOrdenar.nombreItem(context),
            style: TextStyle(
              color: estaSeleccionado
                  ? colores.grisClaroSombreado
                  : colores.secondary,
              fontSize: 14.pf,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
