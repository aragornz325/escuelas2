import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/asistencias/bloc_asistencias/bloc_asistencias_bloc.dart';
import 'package:escuelas_flutter/features/carga_calificaciones/bloc_carga_calificaciones/bloc_carga_calificaciones.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/escuelas_boton.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template PaginaInicio}
/// Todo agregar docu
/// {@endtemplate}
class VistaCelularCargaDeCalificaciones extends StatefulWidget {
  /// {@macro PaginaInicio}
  const VistaCelularCargaDeCalificaciones({super.key});

  @override
  State<VistaCelularCargaDeCalificaciones> createState() =>
      _VistaCelularCargaDeCalificacionesState();
}

class _VistaCelularCargaDeCalificacionesState
    extends State<VistaCelularCargaDeCalificaciones> {
  var fecha = DateTime.now();

  void _restarDia() {
    setState(() {
      fecha = fecha.subtract(Duration(days: 1));
    });
  }

  void _sumarDia() {
    setState(() {
      fecha = fecha.add(Duration(days: 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'MATEMATICA',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 13.pf,
                  color: colores.onBackground,
                ),
              ),
              Text(
                'PRIMERO',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 13.pf,
                  color: colores.onSecondary,
                ),
              ),
            ],
          ),
          //TODO(anyone): reemplazar por el calendario este esta too feo.
          Text(
            '${fecha.year} ${fecha.month} ${fecha.day}',
            style: TextStyle(
              fontSize: 30.pf,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _restarDia(),
                child: Text(
                  'Restar',
                  style: TextStyle(
                    fontSize: 15.pf,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => _sumarDia(),
                child: Text(
                  'Sumar',
                  style: TextStyle(
                    fontSize: 15.pf,
                  ),
                ),
              ),
            ],
          ),

          /// TODO: Implementar lista de alumnos
          BlocBuilder<BlocCargaCalificaciones, BlocCargaCalificacionesEstado>(
            builder: (context, state) {
              if (state.alumnos.isEmpty) {
                return Center(
                  child: Text('No hay alumnos'),
                );
              }
              return Expanded(
                child: Column(
                  children: [
                    ...state.alumnos.map(
                      (alumno) => Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: max(5.ph, 5.sh),
                          horizontal: 15.pw,
                        ),
                        child: EscuelasCargaCalificacionAlumno(
                          listaCalificaciones: alumno.calificacion
                                  ?.map((e) => e.calificacion.toDouble())
                                  .toList() ??
                              [],
                          nombreAlumno: alumno.nombre,
                          calificacionPrevia: getCalificacionForDate(
                            alumno.calificacion ?? [],
                            fecha,
                          ),
                          //TODO(anyone): reemplazar por los roles reales
                          esEditable: state.rolDelUsuario?.nombre == 'docente'
                              ? fecha.day == DateTime.now().day
                              : state.rolDelUsuario?.nombre == 'directivo' &&
                                  fecha.isBefore(DateTime.now()),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              EscuelasBoton.texto(
                context: context,
                estaHabilitado: true,
                onTap: () {},
                color: colores.error,
                texto: 'BORRAR TODO',
              ),
              EscuelasBoton.texto(
                context: context,
                estaHabilitado: true,
                onTap: () {},
                color: colores.azul,
                texto: 'CONFIRMAR',
              ),
            ],
          ),
        ],
      ),
    );
  }

  String? getCalificacionForDate(
      List<ModeloCalificacion> calificaciones, DateTime fecha) {
    for (ModeloCalificacion calificacion in calificaciones) {
      if (calificacion.fecha.year == fecha.year &&
          calificacion.fecha.month == fecha.month &&
          calificacion.fecha.day == fecha.day) {
        return calificacion.calificacion.toString();
      }
    }
    return null; // Si no hay calificación para la fecha dada
  }
}
