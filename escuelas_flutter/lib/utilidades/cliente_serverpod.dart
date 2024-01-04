import 'package:escuelas_client/escuelas_client.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

late SessionManager sessionManager;
late Client client;

Future<void> inicializarClienteServerpod({
  required String hostUrl,
  required String entorno,
}) async {
  // El emulador de Android no tiene acceso al host local de la máquina.
  // dirección IP const = '10.0.2.2'; // IP del emulador de Android para el host

  // En un dispositivo real, reemplace ipAddress con la dirección IP de su
  // computadora. Configura un objeto de cliente singleton que se puede usar
  //para hablar con el servidor desde cualquier lugar de nuestra aplicación.
  //El cliente se genera a partir del código de su servidor.
  // El cliente está configurado para conectarse a un Serverpod que se ejecuta
  //en un servidor local en el puerto predeterminado. Deberá modificar esto para
  // conectarse a  servidores de prueba o de producción.
  client = Client(
    hostUrl,
    authenticationKeyManager: FlutterAuthenticationKeyManager(
      runMode: entorno,
      storage: SharedPreferenceStorage(),
    ),
  )..connectivityMonitor = FlutterConnectivityMonitor();

  // El administrador de sesión realiza un seguimiento del estado de inicio de
  // sesión del usuario. Usted puede consultarlo para ver si el usuario ha
  // iniciado sesión actualmente y obtener información sobre el usuario.
  sessionManager = SessionManager(
    caller: client.modules.auth,
  );

  await sessionManager.initialize();
}
