import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/features/dashboard/alumno-calificaciones/calificaciones-anuales/bloc_calificaciones_anuales/bloc_calificaciones_anuales.dart';
import 'package:escuelas_flutter/features/dashboard/alumno-calificaciones/calificaciones-anuales/widgets/elemento_lista_mes.dart';
import 'package:escuelas_flutter/features/dashboard/alumno-calificaciones/calificaciones-mensuales/widgets/boton_ingresar_asignatura.dart';
import 'package:escuelas_flutter/utilidades/enums/enum_meses.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ListaTarjetaCalificacionesAnuales}
/// Lista de tarjetas de desempeño del alumno con relacion a una asignatura,
/// donde puede visualizar el mes y respectivas calificaciones.
/// {@endtemplate}
class ListaTarjetaCalificacionesAnuales extends StatelessWidget {
  /// {@macro ListaTarjetaCalificacionesAnuales}
  const ListaTarjetaCalificacionesAnuales({
    required this.listaCalificacionesAnuales,
    super.key,
  });

  /// Lista de calificaciones mensuales de un año entero de un alumno para una
  /// asignatura determinada.
  final List<CalificacionMensual?> listaCalificacionesAnuales;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocCalificacionesAnuales,
        BlocCalificacionesAnualesEstado>(
      builder: (context, state) {
        if (state is BlocCalificacionesAnualesEstadoCargando) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 22.ph,
            ),
            child: ListView.builder(
              itemCount: Meses.values.length,
              itemBuilder: (BuildContext context, int i) {
                final mes = Meses.values[i];

                final calificacion = state.obtenerCalificacionPorMes(mes.index);

                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.ph,
                    horizontal: 15.pw,
                  ),
                  child: Row(
                    children: [
                      ElementoListaMes(mes: mes),
                      ElementoCalificacion(
                        calificacion: calificacion,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
