import 'package:escuelas_flutter/features/dashboard/inasistencias/bloc_inasistencias/bloc_inasistencias.dart';
import 'package:escuelas_flutter/features/dashboard/inasistencias/modelos/modelos.dart';
import 'package:escuelas_flutter/features/dashboard/inasistencias/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ListaDeCursos}
/// Lista de cursos y sus estudiantes en caso de que toque algún curso
/// se despliega la lista de estudiantes.
/// {@endtemplate}
class ListaDeComisionesDeCurso extends StatefulWidget {
  /// {@macro ListaDeCursos}
  const ListaDeComisionesDeCurso({super.key});

  @override
  State<ListaDeComisionesDeCurso> createState() =>
      _ListaDeComisionesDeCursoState();
}

class _ListaDeComisionesDeCursoState extends State<ListaDeComisionesDeCurso> {
  /// Controlador de desplazamiento
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocInasistencias, BlocInasistenciasEstado>(
      builder: (context, state) => ListView.builder(
        shrinkWrap: true,
        controller: _scrollController,
        itemCount: state.comisionesConAsistencias.length,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) =>
            _ContenidoDeplegableDeLaComisionDeCurso(
          controller: _scrollController,
          comisionConAsistencias: state.comisionesConAsistencias[index],
          index: index,
          esMesPosterior: state.fechaActual?.isBefore(DateTime.now()) ?? false,
        ),
      ),
    );
  }
}

/// {@template _ContenidoDeplegableDelCurso}
/// Permite desplegar la lista de estudiantes de un curso.
/// {@endtemplate}
class _ContenidoDeplegableDeLaComisionDeCurso extends StatefulWidget {
  /// {@macro _ContenidoDeplegableDelCurso}
  const _ContenidoDeplegableDeLaComisionDeCurso({
    required this.controller,
    required this.comisionConAsistencias,
    required this.index,
    required this.esMesPosterior,
  });

  /// Controlador de desplazamiento.
  final ScrollController controller;

  /// Curso a mostrar.
  final ComisionConAsistencias comisionConAsistencias;

  /// Indice de la lista.
  final int index;

  /// indica si el mes es posterior
  final bool esMesPosterior;

  @override
  State<_ContenidoDeplegableDeLaComisionDeCurso> createState() =>
      _ContenidoDeplegableDeLaComisionDeCursoState();
}

class _ContenidoDeplegableDeLaComisionDeCursoState
    extends State<_ContenidoDeplegableDeLaComisionDeCurso> {
  /// indica si el curso esta desplegado
  bool desplegado = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: desplegado ? 60.hp : null,
      duration: const Duration(milliseconds: 250),
      child: desplegado
          ? ItemCursoConListaDeEstudiantes(
              comisionConAsistencias: widget.comisionConAsistencias,
              onTap: widget.esMesPosterior ? _alternarDespliegue : () {},
            )
          : ItemCurso(
              comisionConAsistencias: widget.comisionConAsistencias,
              onTap: widget.esMesPosterior ? _alternarDespliegue : () {},
            ),
    );
  }

  /// Alterna el despliegue del curso
  void _alternarDespliegue() => setState(
        () {
          desplegado = !desplegado;
          Future.delayed(
            const Duration(milliseconds: 250),
            () {
              widget.controller.animateTo(
                widget.index *
                    8.hp, // TODO(anyone): ver bien esto con el emulador
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
              );
            },
          );
        },
      );
}
