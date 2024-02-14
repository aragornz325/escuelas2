import 'package:escuelas_server/src/generated/protocol.dart';

extension UsuarioX on Usuario {
  List<String> get listaDireccionesDeEmailStrings => direccionesDeEmail != null
      ? direccionesDeEmail!.map((e) => e.direccionDeEmail).toList()
      : [];
}
