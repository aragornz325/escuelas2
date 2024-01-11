import 'package:escuelas_client/escuelas_client.dart';

/// Posee un toJson mas adecuado para la clase [Asignatura]
/// ya que Serverpod no deserealiza correctamente.
extension AsignaturaX on Asignatura {
  Map<String, dynamic> toJsonBloc() {
    return {
      'id': id,
      'nombre': nombre,
      'cursoId': cursoId,
    };
  }
}
