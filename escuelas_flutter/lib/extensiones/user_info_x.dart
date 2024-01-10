import 'package:serverpod_auth_client/module.dart';

/// Extension con getters de la clase UserInfo
extension UserInfoX on UserInfo {
  /// Obtiene solo el nombre del usuario
  String get nombreUsuario => userName;

  /// Obtiene el nombre completo del usuario
  String? get nombreCompleto => fullName;

  /// Obtiene la imagen de perfil del usuario como Url
  String? get imagePerfilUrl => imageUrl;
}
