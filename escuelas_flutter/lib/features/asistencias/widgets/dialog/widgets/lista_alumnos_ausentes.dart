import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/asistencias/bloc_asistencias/bloc_asistencias.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ListaDeAlumnosAusentes}
/// Lista de Alumnos no asistidos de ese dia cuando se tomo asistencias.
/// {@endtemplate}
class ListaDeAlumnosAusentes extends StatefulWidget {
  /// {@macro ListaDeAlumnosAusentes}
  const ListaDeAlumnosAusentes({
    required this.alumnosFiltrados,
    super.key,
  });

  /// Lista de alumnos filtrados por los ausentes.
  final List<ModeloAlumno> alumnosFiltrados;

  @override
  State<ListaDeAlumnosAusentes> createState() => _ListaDeAlumnosAusentesState();
}

class _ListaDeAlumnosAusentesState extends State<ListaDeAlumnosAusentes> {
  /// Variables de ordenamiento por Estado
  bool ordenEstado = false;

  /// Variables de ordenamiento por Nombre
  bool ordenPorNombre = false;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    /// Variables de ordenamiento de la lista de alumnos
    var alumnosOrdenados = List<ModeloAlumno>.from(widget.alumnosFiltrados);

    if (ordenPorNombre) {
      // Ordenar por nombre
      alumnosOrdenados.sort(
        (a, b) =>
            //TODO(mati): reemplazar por en apellido
            a.nombre.toLowerCase().compareTo(
                  b.nombre.toLowerCase(),
                ),
      );
    } else if (ordenEstado) {
      // Ordenar por estado ascendente
      alumnosOrdenados.sort(
        (a, b) => a.asistencia.index.compareTo(
          b.asistencia.index,
        ),
      );
    } else {
      // No ordenar si ambas opciones están en false
      alumnosOrdenados = widget.alumnosFiltrados;
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
          height: max(120.ph, 120.sh),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (alumnosOrdenados.isNotEmpty) ...[
                  ...alumnosOrdenados.map(
                    (alumno) {
                      return Row(
                        children: [
                          SizedBox(
                            width: 150.pw,
                            child: Text(
                              alumno.nombre,
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
                            alumno.asistencia.nombreEstado(context),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13.pf,
                              color: alumno.asistencia.colorEstado(context),
                            ),
                          ),
                        ],
                      );
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
    super.key,
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
