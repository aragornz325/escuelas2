import 'package:escuelas_server/src/generated/protocol.dart';

extension UsuarioX on Usuario {
  List<String> get listaDireccionesDeEmailStrings => direccionesDeEmail?.map((e) => e.direccionDeEmail).toList() ?? [];
}
