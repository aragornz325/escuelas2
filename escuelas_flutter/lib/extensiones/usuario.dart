import 'package:escuelas_client/escuelas_client.dart';

extension UsuarioX on Usuario {
  String get nombreRoles => roles?.map((e) => e.rol?.nombre).join(', ') ?? '';

  String get nombreComisiones =>
      comisiones?.map((e) => e.comision?.nombre).join(', ') ?? '';
}
