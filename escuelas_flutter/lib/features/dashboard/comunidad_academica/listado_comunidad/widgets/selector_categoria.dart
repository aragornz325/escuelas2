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
  OrdenarPor _ordenarPor = OrdenarPor.apellido;
  int index = 0;

  ///  Cambia el ordenamiento del listado
  void _cambiarOrdenamiento(OrdenarPor ordenarPor) {
    setState(() {
      _ordenarPor = ordenarPor;
    });
    context.read<BlocComunidadAcademica>().add(
          BlocComunidadAcademicaEventoTraerUsuariosPorRol(
            ordenarPor: ordenarPor,
          ),
        );
  }

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
          final listaUsuarios = state.listaUsuarios;
          if (listaUsuarios == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...listaUsuarios.opcionesDeOrdenamiento.map(
                (e) => _ItemCategoria(
                  itemSeleccionado: _ordenarPor,
                  onTap: _cambiarOrdenamiento,
                  itemOrdenarPor: e,
                ),
              ),
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
    required this.onTap,
    required this.itemOrdenarPor,
  });

  /// Indica si esta seleccionado
  final OrdenarPor itemSeleccionado;

  /// Funcion que se ejecuta al hacer tap
  final void Function(OrdenarPor ordenarPor) onTap;

  /// Indica si cual es el item seleccionado
  final OrdenarPor itemOrdenarPor;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final estaSeleccionado = itemOrdenarPor == itemSeleccionado;

    return GestureDetector(
      onTap: () => onTap.call(itemOrdenarPor),
      child: Container(
        width: 80.pw,
        height: 30.ph,
        decoration: BoxDecoration(
          color: estaSeleccionado ? colores.primaryContainer : colores.tertiary,
          borderRadius: BorderRadius.circular(50.sw),
        ),
        child: Center(
          child: Text(
            itemOrdenarPor.nombreItem(context),
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
