// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notificacion_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificacionDataImpl _$$NotificacionDataImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificacionDataImpl(
      titulo: json['titulo'] as String,
      contenido: json['contenido'] as String,
      pathRuta: json['pathRuta'] as String,
      idNotificacion: json['idNotificacion'] as String,
    );

Map<String, dynamic> _$$NotificacionDataImplToJson(
        _$NotificacionDataImpl instance) =>
    <String, dynamic>{
      'titulo': instance.titulo,
      'contenido': instance.contenido,
      'pathRuta': instance.pathRuta,
      'idNotificacion': instance.idNotificacion,
    };
