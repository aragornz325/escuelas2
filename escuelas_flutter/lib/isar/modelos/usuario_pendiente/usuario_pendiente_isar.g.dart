// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_pendiente_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUsuarioPendienteIsarCollection on Isar {
  IsarCollection<UsuarioPendienteIsar> get usuarioPendienteIsars =>
      this.collection();
}

const UsuarioPendienteIsarSchema = CollectionSchema(
  name: r'UsuarioPendienteIsar',
  id: -841281687429832166,
  properties: {
    r'apellido': PropertySchema(
      id: 0,
      name: r'apellido',
      type: IsarType.string,
    ),
    r'estadoDeSolicitud': PropertySchema(
      id: 1,
      name: r'estadoDeSolicitud',
      type: IsarType.byte,
      enumMap: _UsuarioPendienteIsarestadoDeSolicitudEnumValueMap,
    ),
    r'idRolSolicitado': PropertySchema(
      id: 2,
      name: r'idRolSolicitado',
      type: IsarType.long,
    ),
    r'idUserInfo': PropertySchema(
      id: 3,
      name: r'idUserInfo',
      type: IsarType.long,
    ),
    r'nombre': PropertySchema(
      id: 4,
      name: r'nombre',
      type: IsarType.string,
    ),
    r'urlFotoDePerfil': PropertySchema(
      id: 5,
      name: r'urlFotoDePerfil',
      type: IsarType.string,
    )
  },
  estimateSize: _usuarioPendienteIsarEstimateSize,
  serialize: _usuarioPendienteIsarSerialize,
  deserialize: _usuarioPendienteIsarDeserialize,
  deserializeProp: _usuarioPendienteIsarDeserializeProp,
  idName: r'idIsar',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _usuarioPendienteIsarGetId,
  getLinks: _usuarioPendienteIsarGetLinks,
  attach: _usuarioPendienteIsarAttach,
  version: '3.1.0+1',
);

int _usuarioPendienteIsarEstimateSize(
  UsuarioPendienteIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.apellido.length * 3;
  bytesCount += 3 + object.nombre.length * 3;
  bytesCount += 3 + object.urlFotoDePerfil.length * 3;
  return bytesCount;
}

void _usuarioPendienteIsarSerialize(
  UsuarioPendienteIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.apellido);
  writer.writeByte(offsets[1], object.estadoDeSolicitud.index);
  writer.writeLong(offsets[2], object.idRolSolicitado);
  writer.writeLong(offsets[3], object.idUserInfo);
  writer.writeString(offsets[4], object.nombre);
  writer.writeString(offsets[5], object.urlFotoDePerfil);
}

UsuarioPendienteIsar _usuarioPendienteIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UsuarioPendienteIsar();
  object.apellido = reader.readString(offsets[0]);
  object.estadoDeSolicitud = _UsuarioPendienteIsarestadoDeSolicitudValueEnumMap[
          reader.readByteOrNull(offsets[1])] ??
      EstadoDeSolicitud.rechazado;
  object.idIsar = id;
  object.idRolSolicitado = reader.readLong(offsets[2]);
  object.idUserInfo = reader.readLong(offsets[3]);
  object.nombre = reader.readString(offsets[4]);
  object.urlFotoDePerfil = reader.readString(offsets[5]);
  return object;
}

P _usuarioPendienteIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (_UsuarioPendienteIsarestadoDeSolicitudValueEnumMap[
              reader.readByteOrNull(offset)] ??
          EstadoDeSolicitud.rechazado) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _UsuarioPendienteIsarestadoDeSolicitudEnumValueMap = {
  'rechazado': 0,
  'pendiente': 1,
  'aprobado': 2,
};
const _UsuarioPendienteIsarestadoDeSolicitudValueEnumMap = {
  0: EstadoDeSolicitud.rechazado,
  1: EstadoDeSolicitud.pendiente,
  2: EstadoDeSolicitud.aprobado,
};

Id _usuarioPendienteIsarGetId(UsuarioPendienteIsar object) {
  return object.idIsar;
}

List<IsarLinkBase<dynamic>> _usuarioPendienteIsarGetLinks(
    UsuarioPendienteIsar object) {
  return [];
}

void _usuarioPendienteIsarAttach(
    IsarCollection<dynamic> col, Id id, UsuarioPendienteIsar object) {
  object.idIsar = id;
}

extension UsuarioPendienteIsarQueryWhereSort
    on QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QWhere> {
  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterWhere>
      anyIdIsar() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UsuarioPendienteIsarQueryWhere
    on QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QWhereClause> {
  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterWhereClause>
      idIsarEqualTo(Id idIsar) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: idIsar,
        upper: idIsar,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterWhereClause>
      idIsarNotEqualTo(Id idIsar) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: idIsar, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: idIsar, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: idIsar, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: idIsar, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterWhereClause>
      idIsarGreaterThan(Id idIsar, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: idIsar, includeLower: include),
      );
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterWhereClause>
      idIsarLessThan(Id idIsar, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: idIsar, includeUpper: include),
      );
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterWhereClause>
      idIsarBetween(
    Id lowerIdIsar,
    Id upperIdIsar, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIdIsar,
        includeLower: includeLower,
        upper: upperIdIsar,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UsuarioPendienteIsarQueryFilter on QueryBuilder<UsuarioPendienteIsar,
    UsuarioPendienteIsar, QFilterCondition> {
  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> apellidoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'apellido',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> apellidoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'apellido',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> apellidoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'apellido',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> apellidoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'apellido',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> apellidoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'apellido',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> apellidoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'apellido',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
          QAfterFilterCondition>
      apellidoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'apellido',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
          QAfterFilterCondition>
      apellidoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'apellido',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> apellidoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'apellido',
        value: '',
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> apellidoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'apellido',
        value: '',
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> estadoDeSolicitudEqualTo(EstadoDeSolicitud value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estadoDeSolicitud',
        value: value,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> estadoDeSolicitudGreaterThan(
    EstadoDeSolicitud value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'estadoDeSolicitud',
        value: value,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> estadoDeSolicitudLessThan(
    EstadoDeSolicitud value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'estadoDeSolicitud',
        value: value,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> estadoDeSolicitudBetween(
    EstadoDeSolicitud lower,
    EstadoDeSolicitud upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'estadoDeSolicitud',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> idIsarEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idIsar',
        value: value,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> idIsarGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idIsar',
        value: value,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> idIsarLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idIsar',
        value: value,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> idIsarBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idIsar',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> idRolSolicitadoEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idRolSolicitado',
        value: value,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> idRolSolicitadoGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idRolSolicitado',
        value: value,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> idRolSolicitadoLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idRolSolicitado',
        value: value,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> idRolSolicitadoBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idRolSolicitado',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> idUserInfoEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idUserInfo',
        value: value,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> idUserInfoGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idUserInfo',
        value: value,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> idUserInfoLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idUserInfo',
        value: value,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> idUserInfoBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idUserInfo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> nombreEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> nombreGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> nombreLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> nombreBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nombre',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> nombreStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> nombreEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
          QAfterFilterCondition>
      nombreContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
          QAfterFilterCondition>
      nombreMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nombre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> nombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> nombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> urlFotoDePerfilEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'urlFotoDePerfil',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> urlFotoDePerfilGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'urlFotoDePerfil',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> urlFotoDePerfilLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'urlFotoDePerfil',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> urlFotoDePerfilBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'urlFotoDePerfil',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> urlFotoDePerfilStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'urlFotoDePerfil',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> urlFotoDePerfilEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'urlFotoDePerfil',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
          QAfterFilterCondition>
      urlFotoDePerfilContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'urlFotoDePerfil',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
          QAfterFilterCondition>
      urlFotoDePerfilMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'urlFotoDePerfil',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> urlFotoDePerfilIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'urlFotoDePerfil',
        value: '',
      ));
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar,
      QAfterFilterCondition> urlFotoDePerfilIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'urlFotoDePerfil',
        value: '',
      ));
    });
  }
}

extension UsuarioPendienteIsarQueryObject on QueryBuilder<UsuarioPendienteIsar,
    UsuarioPendienteIsar, QFilterCondition> {}

extension UsuarioPendienteIsarQueryLinks on QueryBuilder<UsuarioPendienteIsar,
    UsuarioPendienteIsar, QFilterCondition> {}

extension UsuarioPendienteIsarQuerySortBy
    on QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QSortBy> {
  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterSortBy>
      sortByApellido() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apellido', Sort.asc);
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterSortBy>
      sortByApellidoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apellido', Sort.desc);
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterSortBy>
      sortByEstadoDeSolicitud() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estadoDeSolicitud', Sort.asc);
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterSortBy>
      sortByEstadoDeSolicitudDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estadoDeSolicitud', Sort.desc);
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterSortBy>
      sortByIdRolSolicitado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idRolSolicitado', Sort.asc);
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterSortBy>
      sortByIdRolSolicitadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idRolSolicitado', Sort.desc);
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterSortBy>
      sortByIdUserInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idUserInfo', Sort.asc);
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterSortBy>
      sortByIdUserInfoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idUserInfo', Sort.desc);
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterSortBy>
      sortByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterSortBy>
      sortByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterSortBy>
      sortByUrlFotoDePerfil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'urlFotoDePerfil', Sort.asc);
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterSortBy>
      sortByUrlFotoDePerfilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'urlFotoDePerfil', Sort.desc);
    });
  }
}

extension UsuarioPendienteIsarQuerySortThenBy
    on QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QSortThenBy> {
  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterSortBy>
      thenByApellido() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apellido', Sort.asc);
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterSortBy>
      thenByApellidoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apellido', Sort.desc);
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterSortBy>
      thenByEstadoDeSolicitud() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estadoDeSolicitud', Sort.asc);
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterSortBy>
      thenByEstadoDeSolicitudDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estadoDeSolicitud', Sort.desc);
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterSortBy>
      thenByIdIsar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idIsar', Sort.asc);
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterSortBy>
      thenByIdIsarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idIsar', Sort.desc);
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterSortBy>
      thenByIdRolSolicitado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idRolSolicitado', Sort.asc);
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterSortBy>
      thenByIdRolSolicitadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idRolSolicitado', Sort.desc);
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterSortBy>
      thenByIdUserInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idUserInfo', Sort.asc);
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterSortBy>
      thenByIdUserInfoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idUserInfo', Sort.desc);
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterSortBy>
      thenByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterSortBy>
      thenByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterSortBy>
      thenByUrlFotoDePerfil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'urlFotoDePerfil', Sort.asc);
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QAfterSortBy>
      thenByUrlFotoDePerfilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'urlFotoDePerfil', Sort.desc);
    });
  }
}

extension UsuarioPendienteIsarQueryWhereDistinct
    on QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QDistinct> {
  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QDistinct>
      distinctByApellido({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'apellido', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QDistinct>
      distinctByEstadoDeSolicitud() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'estadoDeSolicitud');
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QDistinct>
      distinctByIdRolSolicitado() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'idRolSolicitado');
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QDistinct>
      distinctByIdUserInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'idUserInfo');
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QDistinct>
      distinctByNombre({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nombre', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UsuarioPendienteIsar, UsuarioPendienteIsar, QDistinct>
      distinctByUrlFotoDePerfil({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'urlFotoDePerfil',
          caseSensitive: caseSensitive);
    });
  }
}

extension UsuarioPendienteIsarQueryProperty on QueryBuilder<
    UsuarioPendienteIsar, UsuarioPendienteIsar, QQueryProperty> {
  QueryBuilder<UsuarioPendienteIsar, int, QQueryOperations> idIsarProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idIsar');
    });
  }

  QueryBuilder<UsuarioPendienteIsar, String, QQueryOperations>
      apellidoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'apellido');
    });
  }

  QueryBuilder<UsuarioPendienteIsar, EstadoDeSolicitud, QQueryOperations>
      estadoDeSolicitudProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estadoDeSolicitud');
    });
  }

  QueryBuilder<UsuarioPendienteIsar, int, QQueryOperations>
      idRolSolicitadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idRolSolicitado');
    });
  }

  QueryBuilder<UsuarioPendienteIsar, int, QQueryOperations>
      idUserInfoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idUserInfo');
    });
  }

  QueryBuilder<UsuarioPendienteIsar, String, QQueryOperations>
      nombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombre');
    });
  }

  QueryBuilder<UsuarioPendienteIsar, String, QQueryOperations>
      urlFotoDePerfilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'urlFotoDePerfil');
    });
  }
}
