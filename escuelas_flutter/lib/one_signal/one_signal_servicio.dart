import 'package:escuelas_commons/modelo_notificacion/notificacion_data.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:onesignal_flutter/onesignal_flutter.dart';

/// Se inicializa Servicio de One Signal, se handlea el usuario.
/// Ademas de handlear las notificaciones.
abstract class OneSignalServicio {
  static late OneSignal oneSignal;

  /// Getter de la instancia de OneSignal
  OneSignal get instanciaOneSignal => oneSignal;

  /// Se inicializa OneSignal antes de asegurarte que esta montado el widget
  /// para poder enviar push notifications
  static Future<void> inicializarOneSignal() async {
    await OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    OneSignal.initialize(dotenv.env['ONE_SIGNAL_API_KEY']!);

    await OneSignal.Notifications.requestPermission(true);
  }

  /// Al loguear al usuario con su ID a OneSignal le permite escuchar
  /// las notificaciones entrantes. 
  static Future<void> loguearUsuario(int idUsuario) async {
    await OneSignal.login(idUsuario.toString());
  }

  /// Desloguea al usuario en OneSignal, denegando las notificaciones entrantes.
  static Future<void> desloguearUsuario() async {
    await OneSignal.logout();
  }

  /// Maneja los procesos que ocurren cuando el usuario presiona
  /// las push notifications.
  static Future<void> notificationHandler({
    required AppRouter appRouter,
  }) async {
    /// Cuando el usuario presiona la notificacion
    OneSignal.Notifications.addClickListener((event) async {
      final notificacionMapObject = event
          .notification.additionalData!.values.first as Map<Object?, Object?>;

      final notificacionMap = Map<String, dynamic>.from(notificacionMapObject);

      final notificacion = NotificacionData.fromJson(notificacionMap);

      /// Obtiene la ruta y redirige al usuario hacia ella.
      await appRouter.pushNamed(notificacion.pathRuta);
    });
  }
}
