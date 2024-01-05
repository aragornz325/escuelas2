import 'package:escuelas_flutter/features/asistencias/bloc_asistencias/bloc_asistencias.dart';
import 'package:escuelas_flutter/features/asistencias/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ListaDeCursos}
/// Lista de cursos y sus alumnos en caso de que toque algún curso se despliega
/// la lista de alumnos
/// {@endtemplate}
class ListaDeCursos extends StatefulWidget {
  /// {@macro ListaDeCursos}
  const ListaDeCursos({super.key});

  @override
  State<ListaDeCursos> createState() => _ListaDeCursosState();
}

class _ListaDeCursosState extends State<ListaDeCursos> {
  /// Controlador de desplazamiento
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    // Inicialización del controlador de desplazamiento
    _scrollController = ScrollController();
  }

  /// Despliega o cierra el curso de la lista que se presionó
  void _abrirCurso({
    required int index,
    required int indexCurso,
    required List<ModeloCurso> cursos,
  }) {
    final estaDesplegado =
        !(indexCurso == index && (cursos[index].esVisible ?? true));

    context.read<BlocAsistencias>().add(
          BlocAsistenciasEventoAbrirCurso(
            estaDesplegado: estaDesplegado,
            index: index,
          ),
        );

    if (indexCurso != index) {
      Future.delayed(const Duration(milliseconds: 250), () {
        _scrollController.animateTo(
          index * 80, // TODO(mati): ver bien esto con el emulador
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocAsistencias, BlocAsistenciasEstado>(
      builder: (context, state) => ListView.builder(
        controller: _scrollController,
        itemCount: state.cursos.length,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) => AnimatedContainer(
          height: state.esMismoCurso(index) ? 90.hp : null,
          duration: const Duration(milliseconds: 250),
          child: state.esMismoCurso(index)
              ? ItemCursoConListaDeAlumnos(
                  indexCurso: index,
                  curso: state.cursos[index],
                  onTap: () => _abrirCurso(
                    index: index,
                    indexCurso: state.index,
                    cursos: state.cursos,
                  ),
                )
              : ItemCurso(
                  curso: state.cursos[index],
                  onTap: () => _abrirCurso(
                    index: index,
                    indexCurso: state.index,
                    cursos: state.cursos,
                  ),
                ),
        ),
      ),
    );
  }
}
