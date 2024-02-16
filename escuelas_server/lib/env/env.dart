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

    /// Api key de EscuelasApp de One signal.
  @EnviedField(varName: 'API_KEY_ONE_SIGNAL_DEV')
  static const String apiKeyEscuelasApp = _EnvDev.apiKeyEscuelasApp;

  /// One Signal app ID.
  @EnviedField(varName: 'ONE_SIGNAL_APP_ID_DEV')
  static const String oneSignalAppId = _EnvDev.oneSignalAppId;
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


  /// Api key de EscuelasApp de One signal.
  @EnviedField(varName: 'API_KEY_ONE_SIGNAL_PROD')
  static const String apiKeyEscuelasApp = _EnvProd.apiKeyEscuelasApp;

  /// One Signal app ID.
  @EnviedField(varName: 'ONE_SIGNAL_APP_ID_PROD')
  static const String oneSignalAppId = _EnvProd.oneSignalAppId;
}
