import 'dart:math';

import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extension_estado_asistencia.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ListaDeAlumnosAusentes}
/// Lista de Alumnos no asistidos de ese dia cuando se tomo asistencias.
/// {@endtemplate}
class ListaDeAlumnosAusentes extends StatefulWidget {
  /// {@macro ListaDeAlumnosAusentes}
  const ListaDeAlumnosAusentes({
    required this.usuarios,
    required this.asistencias,
    super.key,
  });

  /// Lista de alumnos a filtrar por ausentismo.
  final List<Usuario> usuarios;

  /// Lista de asistencias
  final List<AsistenciaDiaria> asistencias;

  @override
  State<ListaDeAlumnosAusentes> createState() => _ListaDeAlumnosAusentesState();
}

class _ListaDeAlumnosAusentesState extends State<ListaDeAlumnosAusentes> {
  /// Lista de alumnos filtradas por ausentismo
  List<Usuario> get usuarioSinEstadoPresente => widget.usuarios.where(
        (usuario) {
          return widget.asistencias.any(
            (asistencia) =>
                asistencia.idEstudiante == usuario.idUserInfo &&
                !(asistencia.estadoDeAsistencia ==
                        EstadoDeAsistencia.presente ||
                    asistencia.estadoDeAsistencia ==
                        EstadoDeAsistencia.sinEstado),
          );
        },
      ).toList();

  /// Variables de ordenamiento por Estado
  bool ordenEstado = false;

  /// Variables de ordenamiento por Nombre
  bool ordenPorNombre = false;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    /// Variables de ordenamiento de la lista de alumnos
    var alumnosOrdenados = usuarioSinEstadoPresente;

    if (ordenPorNombre) {
      // Ordenar por apellido

      alumnosOrdenados.sort(
        (a, b) => a.apellido.toLowerCase().compareTo(
              b.apellido.toLowerCase(),
            ),
      );
    } else if (ordenEstado) {
      // Ordenar por estado ascendente
      alumnosOrdenados.sort(
        (a, b) {
          // Obtener las asistencias diarias asociadas a cada usuario
          final asistenciaA = widget.asistencias.firstWhere(
            (asistencia) => asistencia.idEstudiante == a.idUserInfo,
          );
          final asistenciaB = widget.asistencias.firstWhere(
            (asistencia) => asistencia.idEstudiante == b.idUserInfo,
          );

          return asistenciaA.estadoDeAsistencia.index
              .compareTo(asistenciaB.estadoDeAsistencia.index);
        },
      );
    } else {
      // No ordenar si ambas opciones están en false
      alumnosOrdenados = widget.usuarios;
    }

    return Column(
      children: [
        Row(
          children: [
            _TextoEIcono(
              titulo: l10n.commonName,
              estaDesplegado: ordenPorNombre,
              onTap: () => setState(() {
                ordenPorNombre = !ordenPorNombre;
                ordenEstado = false;
              }),
            ),
            const Spacer(),
            _TextoEIcono(
              titulo: l10n.commonState,
              estaDesplegado: ordenEstado,
              onTap: () => setState(() {
                ordenPorNombre = false;
                ordenEstado = !ordenEstado;
              }),
            ),
          ],
        ),
        SizedBox(height: max(5.ph, 5.sh)),
        SizedBox(
          height: max(100.ph, 100.sh),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (alumnosOrdenados.isNotEmpty) ...[
                  ...alumnosOrdenados.map(
                    (alumno) {
                      //TODO(mati): cambiar esta horrible logica
                      final asistenciaDiaria = widget.asistencias.firstWhere(
                        (asistencia) =>
                            asistencia.idEstudiante == alumno.idUserInfo,
                      );

                      return asistenciaDiaria.estadoDeAsistencia !=
                              EstadoDeAsistencia.presente
                          ? Row(
                              children: [
                                SizedBox(
                                  width: 150.pw,
                                  child: Text(
                                    '${alumno.nombre} ${alumno.apellido}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15.pf,
                                      color: colores.onBackground,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  asistenciaDiaria.estadoDeAsistencia
                                      .nombreEstado(context),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13.pf,
                                    color: asistenciaDiaria.estadoDeAsistencia
                                        .colorEstado(context),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                ] else ...[
                  Center(
                    child: Text(
                      l10n.pageAttendanceNotAbsentStudents,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13.pf,
                        color: colores.onBackground,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// {@template _TextoYIcono}
/// Es un texto con un onTap y un icono que indica si esta desplegado cierto
/// filtro
/// {@endtemplate}
class _TextoEIcono extends StatelessWidget {
  /// {@macro _TextoYIcono}
  const _TextoEIcono({
    required this.titulo,
    required this.onTap,
    required this.estaDesplegado,
  });

  /// Titulo del filtro
  final String titulo;

  /// OnTap del filtro
  final VoidCallback onTap;

  /// Indica si el filtro esta desplegado
  final bool estaDesplegado;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Text(
            titulo,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 10.pf,
              color: colores.onBackground,
            ),
          ),
          Icon(
            estaDesplegado
                ? Icons.arrow_drop_down_rounded
                : Icons.arrow_drop_up_rounded,
            size: 20.pw,
            color: colores.onBackground,
          ),
        ],
      ),
    );
  }
}
