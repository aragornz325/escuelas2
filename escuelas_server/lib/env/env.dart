import 'package:envied/envied.dart';

part 'env.g.dart';

/// Variables de entorno Development.
@Envied(path: './lib/env/.env')
abstract class EnvDev {
  @EnviedField(varName: 'DB_HOST_DEV')
  static const String hostDb = _EnvDev.hostDb;
  
  @EnviedField(varName: 'DB_NAME_DEV')
  static const String nombreDb = _EnvDev.nombreDb;
  
  @EnviedField(varName: 'DB_PORT_DEV')
  static const int puertoDb = _EnvDev.puertoDb;
  
  @EnviedField(varName: 'DB_USER_DEV')
  static const String usuarioDb = _EnvDev.usuarioDb;
  
  @EnviedField(varName: 'DIRECCION_EMAIL_GMAIL_DEV')
  static const String direccionEmailGmail = _EnvDev.direccionEmailGmail;

  @EnviedField(varName: 'PASSWORD_EMAIL_GMAIL_DEV')
  static const String passwordEmailGmail = _EnvDev.passwordEmailGmail;

  @EnviedField(varName: 'API_KEY_ONE_SIGNAL_DEV')
  static const String apiKeyEscuelasApp = _EnvDev.apiKeyEscuelasApp;

  @EnviedField(varName: 'ONE_SIGNAL_APP_ID_DEV')
  static const String oneSignalAppId = _EnvDev.oneSignalAppId;
}

/// Variables de entorno Production.
@Envied(path: './lib/env/.env')
abstract class EnvProd {

  @EnviedField(varName: 'DB_HOST_PROD')
  static const String hostDb = _EnvProd.hostDb;
  
  @EnviedField(varName: 'DB_NAME_PROD')
  static const String nombreDb = _EnvProd.nombreDb;
  
  @EnviedField(varName: 'DB_PORT_PROD')
  static const int puertoDb = _EnvProd.puertoDb;
  
  @EnviedField(varName: 'DB_USER_PROD')
  static const String usuarioDb = _EnvProd.usuarioDb;
  
  @EnviedField(varName: 'DIRECCION_EMAIL_GMAIL_PROD')
  static const String direccionEmailGmail = _EnvProd.direccionEmailGmail;

  @EnviedField(varName: 'PASSWORD_EMAIL_GMAIL_PROD')
  static const String passwordEmailGmail = _EnvProd.passwordEmailGmail;


  @EnviedField(varName: 'API_KEY_ONE_SIGNAL_PROD')
  static const String apiKeyEscuelasApp = _EnvProd.apiKeyEscuelasApp;

  @EnviedField(varName: 'ONE_SIGNAL_APP_ID_PROD')
  static const String oneSignalAppId = _EnvProd.oneSignalAppId;
}
