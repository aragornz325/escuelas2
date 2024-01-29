import 'dart:math';

import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/inasistencias/bloc_inasistencias/bloc_inasistencias.dart';
import 'package:escuelas_flutter/features/dashboard/inasistencias/modelos/modelos.dart';
import 'package:escuelas_flutter/features/dashboard/inasistencias/widgets/widgets.dart';
import 'package:escuelas_flutter/gen/assets.gen.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ItemCursoConListaDeEstudiantes}
/// Item Curso con una lista de estudiantes a modificar la asistencia a dicho
/// estudiante
/// {@endtemplate}
class ItemCursoConListaDeEstudiantes extends StatefulWidget {
  /// {@macro ItemCursoConListaDeEstudiantes}
  const ItemCursoConListaDeEstudiantes({
    required this.onTap,
    required this.comisionConAsistencias,
    super.key,
  });

  /// On tap del item curso que se cerrara la lista de los estudiantes a mostrar
  final VoidCallback onTap;

  /// Curso a mostrar
  final ComisionConAsistencias comisionConAsistencias;

  @override
  State<ItemCursoConListaDeEstudiantes> createState() =>
      _ItemCursoConListaDeEstudiantesState();
}

class _ItemCursoConListaDeEstudiantesState
    extends State<ItemCursoConListaDeEstudiantes> {
  late var _inasistencias = widget.comisionConAsistencias.inasistenciasDelCurso;

  void _cambiarAsistenciaDeUnAlumno(AsistenciaDiaria asistenciaDiaria) {
    _inasistencias = _inasistencias.map((e) {
      if (e.estudianteId == asistenciaDiaria.estudianteId) {
        return e.copyWith(
          estadoDeAsistencia: e.estadoDeAsistencia.cambiarEstado(),
        );
      }

      return e;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colores = context.colores;

    return Column(
      children: [
        ItemCurso(
          ancho: 400.pw,
          onTap: widget.onTap,
          comisionConAsistencias: widget.comisionConAsistencias,
        ),
        if (_inasistencias.isEmpty)
          // TODO(anyone): hacer una vista cuando no hay cursos.
          SizedBox(
            height: max(150.ph, 150.sh),
            child: Center(
              child: Text(l10n.pageAttendanceNotAbsentStudents),
            ),
          )
        else
          Expanded(
            child: ListView.builder(
              itemCount: _inasistencias.length,
              itemBuilder: (context, index) {
                final estudiante = _inasistencias[index].estudiante;

                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.pw,
                    vertical: max(10.ph, 10.sh),
                  ),
                  child: ElementoLista.inasistencia(
                    fotoPerfil: SizedBox(
                      width: 25.sw,
                      height: 25.sh,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(100.sw)),
                        child: Image.network(
                          estudiante?.urlFotoDePerfil ?? '',
                          fit: BoxFit.cover,
                          errorBuilder: (
                            context,
                            error,
                            stackTrace,
                          ) =>
                              Image.asset(
                            Assets.images.usuario.path,
                            color: colores.onBackground,
                          ),
                        ),
                      ),
                    ),
                    nombre: '${estudiante?.nombre ?? ''} '
                        '${estudiante?.apellido ?? ''}',
                    context: context,
                    botonCambioInasistencia: InkWell(
                      onTap: () {
                        setState(() {
                          _cambiarAsistenciaDeUnAlumno(
                            _inasistencias[index],
                          );
                        });
                      },
                      child: Container(
                        width: 80.pw,
                        height: max(25.ph, 25.sh),
                        decoration: BoxDecoration(
                          color: _inasistencias[index]
                              .estadoDeAsistencia
                              .colorEstado(context),
                          borderRadius: BorderRadius.all(
                            Radius.circular(35.sw),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            _inasistencias[index]
                                .estadoDeAsistencia
                                .nombreEstado(context),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: colores.background,
                              fontWeight: FontWeight.w700,
                              fontSize: 13.pf,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        const Spacer(),
        BlocBuilder<BlocInasistencias, BlocInasistenciasEstado>(
          builder: (context, state) {
            return BotonFinalizarInasistencias(
              comisionDeCurso: widget.comisionConAsistencias.comisionDeCurso,
              inasistencias: _inasistencias,
              fecha: state.fechaActual ?? DateTime.now(),
            );
          },
        ),
      ],
    );
  }
}
