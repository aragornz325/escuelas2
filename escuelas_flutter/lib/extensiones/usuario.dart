import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_commons/escuelas_commons.dart';

extension UsuarioX on Usuario {
  String get nombreRoles => roles?.keys.join(', ') ?? '';

  String get nombreComisiones =>
      comisiones?.map((e) => e.comision?.nombre).join(', ') ?? '';

  List<Permisos> get permisos =>
      roles?.values.map(Permisos.fromSerialization).toList() ?? [];

  bool tienePermisos(Enum permiso) {
    return permisos.any((e) => e.permissions.any((p) => p.contains(permiso)));
  }
}
