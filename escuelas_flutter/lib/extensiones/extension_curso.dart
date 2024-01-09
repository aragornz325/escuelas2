import 'package:escuelas_client/escuelas_client.dart';

/// Extension para una comisión de curso.
/// Funciones:
///
/// Retorna la `Cantidad de alumnos` que no asistieron de un curso.
///
/// Retorna si `Todos los alumnos` tienen al menos una asistencia.
extension ComisionDeCursoX on ComisionDeCurso {
  /// Devuelve la cantidad de no ausentes.
  int cantidadDeNoAusentes(List<AsistenciaDiaria> asistenciasDiarias) {
    return cursadas?.where(
          (estudiante) {
            // Filtrar las asistencias diarias asociadas a este estudiante
            final asistenciasEstudiante = asistenciasDiarias.where(
              (asistencia) => asistencia.estudianteId == estudiante.usuarioId,
            );

            return asistenciasEstudiante.any(
              (asistencia) =>
                  asistencia.estadoDeAsistencia != EstadoDeAsistencia.ausente &&
                  asistencia.estadoDeAsistencia != EstadoDeAsistencia.sinEstado,
            );
          },
        ).length ??
        0;
  }

  /// Devuelve true si todos los alumnos tienen al menos una asistencia
  bool alumnosSinInasistencias(List<AsistenciaDiaria> asistenciasDiarias) {
    final estudiantes = cursadas?.map((e) => e.usuario).toList() ?? [];

    return estudiantes.every((estudiante) {
      final asistenciasEstudiante = asistenciasDiarias.where(
        (asistencia) => asistencia.estudianteId == estudiante?.id,
      );

      return asistenciasEstudiante.every(
        (asistencia) =>
            asistencia.estadoDeAsistencia != EstadoDeAsistencia.sinEstado,
      );
    });
  }
}
