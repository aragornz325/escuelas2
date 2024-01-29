import 'package:escuelas_client/escuelas_client.dart';

/// {@template ComisionConAsistencias}
/// Comision con las asistencias de los estudiantes
/// {@endtemplate}
class ComisionConAsistencias {
  const ComisionConAsistencias({
    required this.comisionDeCurso,
    required this.inasistenciasDelCurso,
  });

  /// Comision de curso
  final ComisionDeCurso comisionDeCurso;

  /// Lista de inasistencias de los estudiantes
  final List<AsistenciaDiaria> inasistenciasDelCurso;

  ComisionConAsistencias copyWith({
    ComisionDeCurso? comisionDeCurso,
    List<AsistenciaDiaria>? inasistenciasDelCurso,
  }) {
    return ComisionConAsistencias(
      comisionDeCurso: comisionDeCurso ?? this.comisionDeCurso,
      inasistenciasDelCurso:
          inasistenciasDelCurso ?? this.inasistenciasDelCurso,
    );
  }
}
