import 'package:envied/envied.dart';

part 'env.g.dart';

/// Variables de entorno Development.
@Envied(path: './lib/env/.env')
abstract class EnvDev {
  /// Host de la Base de Datos.
  @EnviedField(varName: 'DIRECCION_EMAIL_GMAIL_DEV')
  static const String direccionEmailGmail = _EnvDev.direccionEmailGmail;

  /// Contraseña de la Base de Datos.
  @EnviedField(varName: 'PASSWORD_EMAIL_GMAIL_DEV')
  static const String passwordEmailGmail = _EnvDev.passwordEmailGmail;
}

/// Variables de entorno Production.
@Envied(path: './lib/env/.env')
abstract class EnvProd {
  /// Host de la Base de Datos.
  @EnviedField(varName: 'DIRECCION_EMAIL_GMAIL_PROD')
  static const String direccionEmailGmail = _EnvProd.direccionEmailGmail;

  /// Contraseña de la Base de Datos.
  @EnviedField(varName: 'PASSWORD_EMAIL_GMAIL_PROD')
  static const String passwordEmailGmail = _EnvProd.passwordEmailGmail;
}
