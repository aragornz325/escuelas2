// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notificacion_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NotificacionData _$NotificacionDataFromJson(Map<String, dynamic> json) {
  return _NotificacionData.fromJson(json);
}

/// @nodoc
mixin _$NotificacionData {
  String get titulo => throw _privateConstructorUsedError;
  String get contenido => throw _privateConstructorUsedError;
  String get pathRuta => throw _privateConstructorUsedError;
  String get idNotificacion => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificacionDataCopyWith<NotificacionData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificacionDataCopyWith<$Res> {
  factory $NotificacionDataCopyWith(
          NotificacionData value, $Res Function(NotificacionData) then) =
      _$NotificacionDataCopyWithImpl<$Res, NotificacionData>;
  @useResult
  $Res call(
      {String titulo,
      String contenido,
      String pathRuta,
      String idNotificacion});
}

/// @nodoc
class _$NotificacionDataCopyWithImpl<$Res, $Val extends NotificacionData>
    implements $NotificacionDataCopyWith<$Res> {
  _$NotificacionDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? titulo = null,
    Object? contenido = null,
    Object? pathRuta = null,
    Object? idNotificacion = null,
  }) {
    return _then(_value.copyWith(
      titulo: null == titulo
          ? _value.titulo
          : titulo // ignore: cast_nullable_to_non_nullable
              as String,
      contenido: null == contenido
          ? _value.contenido
          : contenido // ignore: cast_nullable_to_non_nullable
              as String,
      pathRuta: null == pathRuta
          ? _value.pathRuta
          : pathRuta // ignore: cast_nullable_to_non_nullable
              as String,
      idNotificacion: null == idNotificacion
          ? _value.idNotificacion
          : idNotificacion // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificacionDataImplCopyWith<$Res>
    implements $NotificacionDataCopyWith<$Res> {
  factory _$$NotificacionDataImplCopyWith(_$NotificacionDataImpl value,
          $Res Function(_$NotificacionDataImpl) then) =
      __$$NotificacionDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String titulo,
      String contenido,
      String pathRuta,
      String idNotificacion});
}

/// @nodoc
class __$$NotificacionDataImplCopyWithImpl<$Res>
    extends _$NotificacionDataCopyWithImpl<$Res, _$NotificacionDataImpl>
    implements _$$NotificacionDataImplCopyWith<$Res> {
  __$$NotificacionDataImplCopyWithImpl(_$NotificacionDataImpl _value,
      $Res Function(_$NotificacionDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? titulo = null,
    Object? contenido = null,
    Object? pathRuta = null,
    Object? idNotificacion = null,
  }) {
    return _then(_$NotificacionDataImpl(
      titulo: null == titulo
          ? _value.titulo
          : titulo // ignore: cast_nullable_to_non_nullable
              as String,
      contenido: null == contenido
          ? _value.contenido
          : contenido // ignore: cast_nullable_to_non_nullable
              as String,
      pathRuta: null == pathRuta
          ? _value.pathRuta
          : pathRuta // ignore: cast_nullable_to_non_nullable
              as String,
      idNotificacion: null == idNotificacion
          ? _value.idNotificacion
          : idNotificacion // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificacionDataImpl implements _NotificacionData {
  const _$NotificacionDataImpl(
      {required this.titulo,
      required this.contenido,
      required this.pathRuta,
      required this.idNotificacion});

  factory _$NotificacionDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificacionDataImplFromJson(json);

  @override
  final String titulo;
  @override
  final String contenido;
  @override
  final String pathRuta;
  @override
  final String idNotificacion;

  @override
  String toString() {
    return 'NotificacionData(titulo: $titulo, contenido: $contenido, pathRuta: $pathRuta, idNotificacion: $idNotificacion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificacionDataImpl &&
            (identical(other.titulo, titulo) || other.titulo == titulo) &&
            (identical(other.contenido, contenido) ||
                other.contenido == contenido) &&
            (identical(other.pathRuta, pathRuta) ||
                other.pathRuta == pathRuta) &&
            (identical(other.idNotificacion, idNotificacion) ||
                other.idNotificacion == idNotificacion));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, titulo, contenido, pathRuta, idNotificacion);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificacionDataImplCopyWith<_$NotificacionDataImpl> get copyWith =>
      __$$NotificacionDataImplCopyWithImpl<_$NotificacionDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificacionDataImplToJson(
      this,
    );
  }
}

abstract class _NotificacionData implements NotificacionData {
  const factory _NotificacionData(
      {required final String titulo,
      required final String contenido,
      required final String pathRuta,
      required final String idNotificacion}) = _$NotificacionDataImpl;

  factory _NotificacionData.fromJson(Map<String, dynamic> json) =
      _$NotificacionDataImpl.fromJson;

  @override
  String get titulo;
  @override
  String get contenido;
  @override
  String get pathRuta;
  @override
  String get idNotificacion;
  @override
  @JsonKey(ignore: true)
  _$$NotificacionDataImplCopyWith<_$NotificacionDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
