import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/asignatura.dart';

/// Posee un toJson mas adecuado para la clase [Curso]
/// ya que Serverpod no deserealiza correctamente.
extension CursoX on Curso {
  // TODO(anyone): Remover esto cuando se arregle el toJson() de Serverpod

  /// toJson para evitar usar el del modelo Serverpod porque no deserializa
  /// correctamente [DateTime] para eso agregamos un  .toIso8601String().
  Map<String, dynamic> toJsonBloc() {
    return {
      'id': id,
      'nombre': nombre,
      'asignaturas':
          asignaturas?.map((asignatura) => asignatura.toJsonBloc()).toList(),
      'ultimaModificacion': ultimaModificacion.toIso8601String(),
      'fechaCreacion': fechaCreacion.toIso8601String(),
      'fechaEliminacion': fechaEliminacion?.toIso8601String(),
    };
  }
}
