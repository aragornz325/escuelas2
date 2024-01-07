import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/features/inasistencias/bloc_inasistencias/bloc_inasistencias.dart';
import 'package:escuelas_flutter/features/inasistencias/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ListaDeCursos}
/// Lista de cursos y sus alumnos en caso de que toque algún curso se despliega
/// la lista de alumnos
/// {@endtemplate}
class ListaDeCursos extends StatefulWidget {
  /// {@macro ListaDeCursos}
  const ListaDeCursos({
    required this.fecha,
    super.key,
  });

  /// Fecha en la que se finalizaron las asistencias
  final DateTime fecha;

  @override
  State<ListaDeCursos> createState() => _ListaDeCursosState();
}

class _ListaDeCursosState extends State<ListaDeCursos> {
  /// Controlador de desplazamiento
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocInasistencias, BlocInasistenciasEstado>(
      builder: (context, state) => ListView.builder(
        controller: _scrollController,
        itemCount: state.cursos.length,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) => _ContenidoDeplegableDelCurso(
          controller: _scrollController,
          curso: state.cursos[index],
          index: index,
          fecha: widget.fecha,
        ),
      ),
    );
  }
}

/// {@template _ContenidoDeplegableDelCurso}
/// Permite desplegar la lista de alumnos de un curso.
/// {@endtemplate}
class _ContenidoDeplegableDelCurso extends StatefulWidget {
  /// {@macro _ContenidoDeplegableDelCurso}
  const _ContenidoDeplegableDelCurso({
    required this.controller,
    required this.curso,
    required this.index,
    required this.fecha,
  });

  /// Controlador de desplazamiento
  final ScrollController controller;

  /// Cursos
  final ComisionDeCurso curso;

  /// Indice
  final int index;

  /// Fecha del calendario
  final DateTime fecha;

  @override
  State<_ContenidoDeplegableDelCurso> createState() =>
      _ContenidoDeplegableDelCursoState();
}

class _ContenidoDeplegableDelCursoState
    extends State<_ContenidoDeplegableDelCurso> {
  /// indica si el curso esta desplegado
  bool desplegado = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: desplegado ? 70.hp : null,
      duration: const Duration(milliseconds: 250),
      child: desplegado
          ? ItemCursoConListaDeAlumnos(
              indexCurso: widget.index,
              curso: widget.curso,
              onTap: _desplegarCurso,
              fecha: widget.fecha,
            )
          : ItemCurso(
              curso: widget.curso,
              onTap: _desplegarCurso,
            ),
    );
  }

  /// despliega el curso
  void _desplegarCurso() => setState(
        () {
          desplegado = !desplegado;
          Future.delayed(
            const Duration(milliseconds: 250),
            () {
              widget.controller.animateTo(
                widget.index *
                    8.hp, // TODO(mati): ver bien esto con el emulador
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
              );
            },
          );
        },
      );
}
