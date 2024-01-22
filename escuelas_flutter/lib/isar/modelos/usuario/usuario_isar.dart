import 'package:escuelas_client/escuelas_client.dart';
import 'package:isar/isar.dart';

part 'usuario_isar.g.dart';

/// Clase del usuario isar de la DB local basada en [Usuario].
@Collection()
class UsuarioIsar {
  Id idIsar = Isar.autoIncrement;

  late int? idUsuario;

  late int idUserInfo;

  late String nombre;

  late String apellido;

  late String urlFotoDePerfil;

 
}
