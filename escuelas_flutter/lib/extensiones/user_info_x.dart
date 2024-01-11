import 'package:serverpod_auth_client/module.dart';

/// Extension con getters de la clase UserInfo
extension UserInfoX on UserInfo {
  /// Obtiene solo el nombre del usuario
  String get apellidoo => fullName?.split(' ').last ?? '';
}
