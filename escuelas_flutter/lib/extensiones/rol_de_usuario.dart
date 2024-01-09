import 'package:escuelas_client/escuelas_client.dart';

/// Posee un toJson mas adecuado para la clase [RolDeUsuario]
/// ya que Serverpod no deserealiza correctamente.
extension RolDeUsuarioX on RolDeUsuario {
  Map<String, dynamic> toJsonBloc() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
    };
  }
}
