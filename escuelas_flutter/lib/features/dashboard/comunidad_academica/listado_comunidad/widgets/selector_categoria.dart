import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/comunidad_academica/bloc/bloc_comunidad_academica.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
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

  /// Actualiza el item seleccionado
  void actualizarIndice(int nuevoIndice) {
    setState(() {
      index = nuevoIndice;
    });
    switch (nuevoIndice) {
      case 0:
        context.read<BlocComunidadAcademica>().add(
              BlocComunidadAcademicaEventoOrdenarAlfabeticamente(),
            );
      case 1:
      // TODO(anyone): implementar ordenamiento por curso
      // context
      //   .read<BlocComunidadAcademica>()
      //   .add(BlocComunidadAcademicaEventoOrdenarPorCurso());
      case 2:
      // TODO(anyone): implementar ordenamiento por asignatura
      // context.read<BlocComunidadAcademica>().add(
      //    BlocComunidadAcademicaEventoOrdenarPorAsignatura(),
      //   );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return Container(
      width: 240.pw,
      height: 30.ph,
      decoration: BoxDecoration(
        color: colores.tertiary,
        borderRadius: BorderRadius.circular(50.sw),
      ),
      child: Row(
        children: [
          _ItemCategoria(
            nombre: l10n.commonName,
            estaSeleccionado: index == 0,
            onTap: () => actualizarIndice(0),
          ),
          _ItemCategoria(
            nombre: l10n.commonCourse,
            estaSeleccionado: index == 1,
            onTap: () => actualizarIndice(1),
          ),
          _ItemCategoria(
            nombre: l10n.commonSubject,
            estaSeleccionado: index == 2,
            onTap: () => actualizarIndice(2),
          ),
        ],
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
    required this.nombre,
    required this.estaSeleccionado,
    required this.onTap,
  });

  /// Nombre de la categoria
  final String nombre;

  /// Indica si esta seleccionado
  final bool estaSeleccionado;

  /// Funcion que se ejecuta al hacer tap
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80.pw,
        height: 30.ph,
        decoration: BoxDecoration(
          color: estaSeleccionado ? colores.primaryContainer : colores.tertiary,
          borderRadius: BorderRadius.circular(50.sw),
        ),
        child: Center(
          child: Text(
            nombre,
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
