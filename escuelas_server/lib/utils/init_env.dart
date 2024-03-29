import 'package:escuelas_server/env/env.dart';

/// Mapa con las variables de entorno para reemplazar en el YAML.
late final VariablesDeEntorno env;

/// Inicializa las variables de entorno.
void initEnv(String mode) {
  switch (mode) {
    case 'development':
      env = VariablesDeEntorno.getInstance(
        hostDb: EnvDev.hostDb,
        nombreDb: EnvDev.nombreDb,
        puertoDb: EnvDev.puertoDb,
        usuarioDb: EnvDev.usuarioDb,
        direccionEmailGmail: EnvDev.direccionEmailGmail,
        passwordEmailGmail: EnvDev.passwordEmailGmail,
        apiKeyEscuelasApp: EnvDev.apiKeyEscuelasApp,
        oneSignalAppId: EnvDev.oneSignalAppId,
      );
      break;
    case 'production':
      env = VariablesDeEntorno.getInstance(
        hostDb: EnvProd.hostDb,
        nombreDb: EnvProd.nombreDb,
        puertoDb: EnvProd.puertoDb,
        usuarioDb: EnvProd.usuarioDb,
        direccionEmailGmail: EnvProd.direccionEmailGmail,
        passwordEmailGmail: EnvProd.passwordEmailGmail,
        apiKeyEscuelasApp: EnvProd.apiKeyEscuelasApp,
        oneSignalAppId: EnvProd.oneSignalAppId,
      );
      break;
    default:
      env = VariablesDeEntorno.getInstance(
        hostDb: EnvDev.hostDb,
        nombreDb: EnvDev.nombreDb,
        puertoDb: EnvDev.puertoDb,
        usuarioDb: EnvDev.usuarioDb,
        direccionEmailGmail: EnvDev.direccionEmailGmail,
        passwordEmailGmail: EnvDev.passwordEmailGmail,
        apiKeyEscuelasApp: EnvDev.apiKeyEscuelasApp,
        oneSignalAppId: EnvDev.oneSignalAppId,
      );
      break;
  }
}

class VariablesDeEntorno {
  VariablesDeEntorno({
    required String hostDb,
    required String nombreDb,
    required int puertoDb,
    required String usuarioDb,
    required String direccionEmailGmail,
    required String passwordEmailGmail,
    required String apiKeyEscuelasApp,
    required String oneSignalAppId,
  }) {
    _hostDb = hostDb;
    _nombreDb = nombreDb;
    _puertoDb = puertoDb;
    _usuarioDb = usuarioDb;
    _direccionEmailGmail = direccionEmailGmail;
    _passwordEmailGmail = passwordEmailGmail;
    _apiKeyEscuelasApp = apiKeyEscuelasApp;
    _oneSignalAppId = oneSignalAppId;
  }

  static VariablesDeEntorno? _instance;

  factory VariablesDeEntorno.getInstance({
    required String hostDb,
    required String nombreDb,
    required int puertoDb,
    required String usuarioDb,
    required String direccionEmailGmail,
    required String passwordEmailGmail,
    required String apiKeyEscuelasApp,
    required String oneSignalAppId,
  }) {
    _instance ??= VariablesDeEntorno(
      hostDb: hostDb,
      nombreDb: nombreDb,
      puertoDb: puertoDb,
      usuarioDb: usuarioDb,
      direccionEmailGmail: direccionEmailGmail,
      passwordEmailGmail: passwordEmailGmail,
      apiKeyEscuelasApp: apiKeyEscuelasApp,
      oneSignalAppId: oneSignalAppId,
    );
    return _instance!;
  }

  String? _hostDb;
  String? _nombreDb;
  int? _puertoDb;
  String? _usuarioDb;
  String? _direccionEmailGmail;
  String? _passwordEmailGmail;
  String? _apiKeyEscuelasApp;
  String? _oneSignalAppId;

  // Getters for accessing environment variables
  String get hostDb => _hostDb!;
  String get nombreDb => _nombreDb!;
  int get puertoDb => _puertoDb!;
  String get usuarioDb => _usuarioDb!;
  String get direccionEmailGmail => _direccionEmailGmail!;
  String get passwordEmailGmail =>
      _passwordEmailGmail!; // Consider security implications
  String get apiKeyEscuelasApp => _apiKeyEscuelasApp!;
  String get oneSignalAppId => _oneSignalAppId!;
}
