import 'package:escuelas_server/src/generated/protocol.dart';

/// Extensiones para el estado de asistencia.
/// Funciones:
/// Retornar un `String` nombre dependiendo del estado de la asistencia.
/// Función para `Cambiar el estado` dependiendo del estado anterior.
extension EstadoDeAsistenciaX on EstadoDeAsistencia {

  /// Devuelve el nombre del estado.
  String nombreEstado() {
    // TODO(ANYONE): Supportear i18n
    switch (this) {
      case EstadoDeAsistencia.presente:
        return 'Presente';
      case EstadoDeAsistencia.ausente:
        return 'Ausente';
      case EstadoDeAsistencia.mediaInasistencia:
        return 'Media Falta';
      case EstadoDeAsistencia.cuartoDeInasistencia:
        return 'Cuarto de Falta';

      case EstadoDeAsistencia.sinEstado:
        return '';
    }
  }

  /// Cambia el estado Dependiendo de la anterior Asistencia/Inasistencia.
  EstadoDeAsistencia cambiarEstado() {
    return switch (this) {
      EstadoDeAsistencia.presente => EstadoDeAsistencia.mediaInasistencia,
      EstadoDeAsistencia.mediaInasistencia =>
        EstadoDeAsistencia.cuartoDeInasistencia,
      EstadoDeAsistencia.cuartoDeInasistencia => EstadoDeAsistencia.ausente,
      EstadoDeAsistencia.ausente => EstadoDeAsistencia.presente,
      _ => EstadoDeAsistencia.presente,
    };
  }
}
