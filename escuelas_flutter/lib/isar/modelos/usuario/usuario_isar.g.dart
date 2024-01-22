// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUsuarioIsarCollection on Isar {
  IsarCollection<UsuarioIsar> get usuarioIsars => this.collection();
}

const UsuarioIsarSchema = CollectionSchema(
  name: r'UsuarioIsar',
  id: 4821564693279005877,
  properties: {
    r'apellido': PropertySchema(
      id: 0,
      name: r'apellido',
      type: IsarType.string,
    ),
    r'idUserInfo': PropertySchema(
      id: 1,
      name: r'idUserInfo',
      type: IsarType.long,
    ),
    r'idUsuario': PropertySchema(
      id: 2,
      name: r'idUsuario',
      type: IsarType.long,
    ),
    r'nombre': PropertySchema(
      id: 3,
      name: r'nombre',
      type: IsarType.string,
    ),
    r'urlFotoDePerfil': PropertySchema(
      id: 4,
      name: r'urlFotoDePerfil',
      type: IsarType.string,
    )
  },
  estimateSize: _usuarioIsarEstimateSize,
  serialize: _usuarioIsarSerialize,
  deserialize: _usuarioIsarDeserialize,
  deserializeProp: _usuarioIsarDeserializeProp,
  idName: r'idIsar',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _usuarioIsarGetId,
  getLinks: _usuarioIsarGetLinks,
  attach: _usuarioIsarAttach,
  version: '3.1.0+1',
);

int _usuarioIsarEstimateSize(
  UsuarioIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.apellido.length * 3;
  bytesCount += 3 + object.nombre.length * 3;
  bytesCount += 3 + object.urlFotoDePerfil.length * 3;
  return bytesCount;
}

void _usuarioIsarSerialize(
  UsuarioIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.apellido);
  writer.writeLong(offsets[1], object.idUserInfo);
  writer.writeLong(offsets[2], object.idUsuario);
  writer.writeString(offsets[3], object.nombre);
  writer.writeString(offsets[4], object.urlFotoDePerfil);
}

UsuarioIsar _usuarioIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UsuarioIsar();
  object.apellido = reader.readString(offsets[0]);
  object.idIsar = id;
  object.idUserInfo = reader.readLong(offsets[1]);
  object.idUsuario = reader.readLongOrNull(offsets[2]);
  object.nombre = reader.readString(offsets[3]);
  object.urlFotoDePerfil = reader.readString(offsets[4]);
  return object;
}

P _usuarioIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _usuarioIsarGetId(UsuarioIsar object) {
  return object.idIsar;
}

List<IsarLinkBase<dynamic>> _usuarioIsarGetLinks(UsuarioIsar object) {
  return [];
}

void _usuarioIsarAttach(
    IsarCollection<dynamic> col, Id id, UsuarioIsar object) {
  object.idIsar = id;
}

extension UsuarioIsarQueryWhereSort
    on QueryBuilder<UsuarioIsar, UsuarioIsar, QWhere> {
  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterWhere> anyIdIsar() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UsuarioIsarQueryWhere
    on QueryBuilder<UsuarioIsar, UsuarioIsar, QWhereClause> {
  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterWhereClause> idIsarEqualTo(
      Id idIsar) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: idIsar,
        upper: idIsar,
      ));
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterWhereClause> idIsarNotEqualTo(
      Id idIsar) {
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

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterWhereClause> idIsarGreaterThan(
      Id idIsar,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: idIsar, includeLower: include),
      );
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterWhereClause> idIsarLessThan(
      Id idIsar,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: idIsar, includeUpper: include),
      );
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterWhereClause> idIsarBetween(
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

extension UsuarioIsarQueryFilter
    on QueryBuilder<UsuarioIsar, UsuarioIsar, QFilterCondition> {
  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition> apellidoEqualTo(
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

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      apellidoGreaterThan(
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

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      apellidoLessThan(
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

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition> apellidoBetween(
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

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      apellidoStartsWith(
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

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      apellidoEndsWith(
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

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      apellidoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'apellido',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition> apellidoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'apellido',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      apellidoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'apellido',
        value: '',
      ));
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      apellidoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'apellido',
        value: '',
      ));
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition> idIsarEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idIsar',
        value: value,
      ));
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      idIsarGreaterThan(
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

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition> idIsarLessThan(
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

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition> idIsarBetween(
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

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      idUserInfoEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idUserInfo',
        value: value,
      ));
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      idUserInfoGreaterThan(
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

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      idUserInfoLessThan(
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

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      idUserInfoBetween(
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

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      idUsuarioIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'idUsuario',
      ));
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      idUsuarioIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'idUsuario',
      ));
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      idUsuarioEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idUsuario',
        value: value,
      ));
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      idUsuarioGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idUsuario',
        value: value,
      ));
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      idUsuarioLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idUsuario',
        value: value,
      ));
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      idUsuarioBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idUsuario',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition> nombreEqualTo(
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

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      nombreGreaterThan(
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

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition> nombreLessThan(
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

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition> nombreBetween(
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

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      nombreStartsWith(
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

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition> nombreEndsWith(
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

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition> nombreContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition> nombreMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nombre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      nombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      nombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      urlFotoDePerfilEqualTo(
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

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      urlFotoDePerfilGreaterThan(
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

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      urlFotoDePerfilLessThan(
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

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      urlFotoDePerfilBetween(
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

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      urlFotoDePerfilStartsWith(
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

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      urlFotoDePerfilEndsWith(
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

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      urlFotoDePerfilContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'urlFotoDePerfil',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      urlFotoDePerfilMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'urlFotoDePerfil',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      urlFotoDePerfilIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'urlFotoDePerfil',
        value: '',
      ));
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterFilterCondition>
      urlFotoDePerfilIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'urlFotoDePerfil',
        value: '',
      ));
    });
  }
}

extension UsuarioIsarQueryObject
    on QueryBuilder<UsuarioIsar, UsuarioIsar, QFilterCondition> {}

extension UsuarioIsarQueryLinks
    on QueryBuilder<UsuarioIsar, UsuarioIsar, QFilterCondition> {}

extension UsuarioIsarQuerySortBy
    on QueryBuilder<UsuarioIsar, UsuarioIsar, QSortBy> {
  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterSortBy> sortByApellido() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apellido', Sort.asc);
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterSortBy> sortByApellidoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apellido', Sort.desc);
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterSortBy> sortByIdUserInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idUserInfo', Sort.asc);
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterSortBy> sortByIdUserInfoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idUserInfo', Sort.desc);
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterSortBy> sortByIdUsuario() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idUsuario', Sort.asc);
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterSortBy> sortByIdUsuarioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idUsuario', Sort.desc);
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterSortBy> sortByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterSortBy> sortByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterSortBy> sortByUrlFotoDePerfil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'urlFotoDePerfil', Sort.asc);
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterSortBy>
      sortByUrlFotoDePerfilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'urlFotoDePerfil', Sort.desc);
    });
  }
}

extension UsuarioIsarQuerySortThenBy
    on QueryBuilder<UsuarioIsar, UsuarioIsar, QSortThenBy> {
  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterSortBy> thenByApellido() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apellido', Sort.asc);
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterSortBy> thenByApellidoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apellido', Sort.desc);
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterSortBy> thenByIdIsar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idIsar', Sort.asc);
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterSortBy> thenByIdIsarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idIsar', Sort.desc);
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterSortBy> thenByIdUserInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idUserInfo', Sort.asc);
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterSortBy> thenByIdUserInfoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idUserInfo', Sort.desc);
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterSortBy> thenByIdUsuario() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idUsuario', Sort.asc);
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterSortBy> thenByIdUsuarioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idUsuario', Sort.desc);
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterSortBy> thenByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterSortBy> thenByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterSortBy> thenByUrlFotoDePerfil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'urlFotoDePerfil', Sort.asc);
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QAfterSortBy>
      thenByUrlFotoDePerfilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'urlFotoDePerfil', Sort.desc);
    });
  }
}

extension UsuarioIsarQueryWhereDistinct
    on QueryBuilder<UsuarioIsar, UsuarioIsar, QDistinct> {
  QueryBuilder<UsuarioIsar, UsuarioIsar, QDistinct> distinctByApellido(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'apellido', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QDistinct> distinctByIdUserInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'idUserInfo');
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QDistinct> distinctByIdUsuario() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'idUsuario');
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QDistinct> distinctByNombre(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nombre', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UsuarioIsar, UsuarioIsar, QDistinct> distinctByUrlFotoDePerfil(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'urlFotoDePerfil',
          caseSensitive: caseSensitive);
    });
  }
}

extension UsuarioIsarQueryProperty
    on QueryBuilder<UsuarioIsar, UsuarioIsar, QQueryProperty> {
  QueryBuilder<UsuarioIsar, int, QQueryOperations> idIsarProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idIsar');
    });
  }

  QueryBuilder<UsuarioIsar, String, QQueryOperations> apellidoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'apellido');
    });
  }

  QueryBuilder<UsuarioIsar, int, QQueryOperations> idUserInfoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idUserInfo');
    });
  }

  QueryBuilder<UsuarioIsar, int?, QQueryOperations> idUsuarioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idUsuario');
    });
  }

  QueryBuilder<UsuarioIsar, String, QQueryOperations> nombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombre');
    });
  }

  QueryBuilder<UsuarioIsar, String, QQueryOperations>
      urlFotoDePerfilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'urlFotoDePerfil');
    });
  }
}
