import 'package:freezed_annotation/freezed_annotation.dart';

part 'notificacion_data.freezed.dart';
part 'notificacion_data.g.dart';

/// {@template NotificacionData}
/// Representa el contenido de una notificacion para ser manejada en el front.
/// Contiene informacion sobre el contenido y nombre de ruta a dirigirse.
/// {@endtemplate}
@freezed
class NotificacionData with _$NotificacionData {
  /// {@macro NotificacionData}
  const factory NotificacionData({
    required String titulo,
    required String contenido,
    required String pathRuta,
    required String idNotificacion,
 
  }) = _NotificacionData;

  /// Metodo fromJson de la clase [NotificacionData] para deserealizar.
  factory NotificacionData.fromJson(Map<String, dynamic> json) =>
      _$NotificacionDataFromJson(json);
}
