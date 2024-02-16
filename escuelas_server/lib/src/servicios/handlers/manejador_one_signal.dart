import 'dart:convert';
import 'dart:io';

import 'package:escuelas_commons/modelo_notificacion/notificacion_data.dart';
import 'package:http/http.dart' as http;

class ManejadorOneSignal {
  ManejadorOneSignal._privateConstructor(this._apiKey, this._appId);

  final String _apiKey;

  final String _appId;

  /// Instancia Singleton
  static ManejadorOneSignal? _instance;

  /// Constructor factory que provee acceso a la instancia Singleton de [ManejadorOneSignal]
  factory ManejadorOneSignal({
    required String apiKey,
    required String appId,
  }) {
    _instance ??= ManejadorOneSignal._privateConstructor(apiKey, appId);
    return _instance!;
  }

  final _httpClient = http.Client();

  static const _baseUrl = 'https://onesignal.com/api';

  static ManejadorOneSignal get instance {
    return _instance!;
  }

  Uri path(String url) => Uri.parse(_baseUrl + url);

  Map<String, String> get headers => {
        "Authorization": "Basic $_apiKey",
        "content-type": "application/json",
      };

  /// Envia una push notificacion a ciertos usuarios de acuerdo a su ID.
  Future<void> enviarPushNotification({
    /// Modelo de notificacion custom que contiene data adicional
    required NotificacionData notificationData,

    /// This is the template id of the notification
    String? templateId,

    /// Estos son los botones de la notificacion
    List<Button>? buttons,

    /// This will be used to send the notification to a specific segment
    List<IncludedSegments>? includedSegments,

    /// Id del usuario para enviarle la notificacion.
    String? userId,

    /// La notificacion sera enviada a la lista de id usuarios externos.
    List<String>? includeExternalUserIds,

    /// Se puede coordinar para que la notificacion se mande en cierto tiempo.
    DateTime? sendAfter,
  }) async {
    try {
      final b = {
        "app_id": _appId,
        "contents": {
          "en": notificationData.contenido,
          "es": notificationData.contenido,
        },
        if (includedSegments != null)
          "included_segments": "${IncludedSegments.activeUser}",
        "headings": {
          "en": notificationData.titulo,
          "es": notificationData.titulo,
        },
        if (templateId != null)
          "template_id": {
            "en": templateId,
            "es": templateId,
          },
        if (buttons != null)
          "buttons": buttons.map(
            (x) => x.toMap(),
          ),
        if (userId != null || includeExternalUserIds != null)
          "include_external_user_ids": [
            "$userId",
            ...includeExternalUserIds ?? [],
          ],
        if (sendAfter != null) "send_after": sendAfter.toIso8601String(),
        "data": {'notificacionData': notificationData.toJson()},
        "channel_for_external_user_ids": "push",
      };
      final data = json.encode(b);
      final response = await _httpClient.post(
        path('/v1/notifications'),
        headers: headers,
        body: data,
      );
      stdout.write(response.body);
    } catch (e, st) {
      stdout.write('$e/n$st');
      throw Exception(e);
    }
  }
}

enum IncludedSegments {
  activeUser('Active Users'),
  inactiveUser('Inactive Users');

  const IncludedSegments(this.name);

  final String name;
}

Button buttonFromMap(String str) =>
    Button.fromMap(json.decode(str) as Map<String, dynamic>);

String buttonToMap(Button data) => json.encode(data.toMap());

/// Boton que podria tener la notificacion y que el usuario interactue con el.
class Button {
  Button({
    required this.id,
    required this.text,
    required this.icon,
    this.data,
  });

  final String? id;
  final String? text;
  final String? icon;
  final Map<String, dynamic>? data;

  factory Button.fromMap(Map<String, dynamic> json) => Button(
        id: json["id"] as String?,
        text: json["text"] as String?,
        icon: json["icon"] as String?,
        data: json["data"] as Map<String, dynamic>?,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "text": text,
        "icon": icon,
        "data": data,
      };
}
