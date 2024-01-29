import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_commons/manejo_de_calificaciones/valor_de_calificacion/valor_de_calificacion.dart';

/// Manejador de calificaciones
///
/// Esta clase es la encargada de manipular las calificaciones para
/// adaptarlas a los distintos sistemas de calificacion
abstract class ManejadorDeCalificaciones {
  /// Obtiene el valor de la calificacion
  ///
  /// Segun el tipo de calificacion de calificacion elige como computar
  /// el valor del mismo para adaptarse a los distintos sistemas de calificacion
  /// ej: Numerico, Conceptual, Alfabetico
  ///
  /// [indexCalificacion] es el indice que se encuentra dentro de los enums que
  /// representan los valores de calificacion.
  static String obtenerValorDeCalificacion(
    TipoCalificacion tipoCalificacion,
    int indexCalificacion,
  ) {
    switch (tipoCalificacion) {
      case TipoCalificacion.numericoDecimal:
        return ValorDeCalificacionNumericaDecimal
            .values[indexCalificacion].valor;
      case TipoCalificacion.rite:
        return ValorDeCalificacionConceptualRite.values[indexCalificacion].name;
      case TipoCalificacion.alfabetico:
        return ValorDeCalificacionNumericaDecimal
            .values[indexCalificacion].valor;
    }
  }
}
