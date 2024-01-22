import 'package:escuelas_client/escuelas_client.dart';
import 'package:isar/isar.dart';

part 'usuario_pendiente_isar.g.dart';

/// Clase del usuario pendiente isar de la DB local basada en [UsuarioPendiente]
@Collection()
class UsuarioPendienteIsar {
  late int idUserInfo;

  late String nombre;

  late String apellido;

  late String urlFotoDePerfil;

  late int idRolSolicitado;

  Id idIsar = Isar.autoIncrement;

  @enumerated
  late EstadoDeSolicitud estadoDeSolicitud;
}
