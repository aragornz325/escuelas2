import 'package:escuelas_flutter/isar/isar_servicio.dart';
import 'package:escuelas_flutter/utilidades/cliente_serverpod.dart';

/// Cierra sesion y tambien borra los datos de la instancia local.
Future<void> cerrarSesionUsuario() async {
  await sessionManager.signOut();

  if (!sessionManager.isSignedIn) {
    await IsarServicio.borrarDatosDeInstanciaDB();
  }
}
