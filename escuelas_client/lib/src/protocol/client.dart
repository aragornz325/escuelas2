/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:escuelas_client/src/protocol/curso/asignatura.dart' as _i3;
import 'package:escuelas_client/src/protocol/curso/curso.dart' as _i4;
import 'dart:io' as _i5;
import 'protocol.dart' as _i6;

/// {@category Endpoint}
class EndpointAsignatura extends _i1.EndpointRef {
  EndpointAsignatura(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'asignatura';

  /// La función `otenerAsignaturaPorId` recupera un objeto `Asignatura` por su ID usando una `Session`
  _i2.Future<_i3.Asignatura> obtenerAsignaturaPorId({required int id}) =>
      caller.callServerEndpoint<_i3.Asignatura>(
        'asignatura',
        'obtenerAsignaturaPorId',
        {'id': id},
      );

  /// La función "obtenerAsignaturas" recupera una lista de asignaturas utilizando un objeto de sesión.
  _i2.Future<List<_i3.Asignatura>> obtenerAsignaturas() =>
      caller.callServerEndpoint<List<_i3.Asignatura>>(
        'asignatura',
        'obtenerAsignaturas',
        {},
      );

  /// La función `crearAsignatura` crea un nuevo objeto `Asignatura` en la base de datos usando la
  /// sesión proporcionada y devuelve el objeto creado.
  _i2.Future<_i3.Asignatura> crearAsignatura(
          {required _i3.Asignatura asignatura}) =>
      caller.callServerEndpoint<_i3.Asignatura>(
        'asignatura',
        'crearAsignatura',
        {'asignatura': asignatura},
      );

  /// La función `actualizarAsignatura` actualiza un objeto `Asignatura` en una base de datos usando un
  /// objeto `Session` proporcionado.
  _i2.Future<_i3.Asignatura> actualizarAsignatura(
          {required _i3.Asignatura asignatura}) =>
      caller.callServerEndpoint<_i3.Asignatura>(
        'asignatura',
        'actualizarAsignatura',
        {'asignatura': asignatura},
      );

  /// La función `eliminarAsignatura` elimina un objeto `Asignatura` de una base de datos utilizando una
  /// `Session` proporcionada.
  _i2.Future<int> eliminarAsignatura({required int id}) =>
      caller.callServerEndpoint<int>(
        'asignatura',
        'eliminarAsignatura',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointCurso extends _i1.EndpointRef {
  EndpointCurso(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'curso';

  /// La función "obtenerCursoPorId" recupera un curso por su ID usando una sesión y un ORM.
  _i2.Future<_i4.Curso> obtenerCursoPorId({required int id}) =>
      caller.callServerEndpoint<_i4.Curso>(
        'curso',
        'obtenerCursoPorId',
        {'id': id},
      );

  /// La función "obtenerCursos" recupera una lista de cursos utilizando un objeto de sesión.
  _i2.Future<List<_i4.Curso>> obtenerCursos() =>
      caller.callServerEndpoint<List<_i4.Curso>>(
        'curso',
        'obtenerCursos',
        {},
      );

  /// La función `crearCurso` crea un curso en una base de datos utilizando la sesión y el objeto del
  /// curso proporcionados.
  _i2.Future<_i4.Curso> crearCurso({required _i4.Curso curso}) =>
      caller.callServerEndpoint<_i4.Curso>(
        'curso',
        'crearCurso',
        {'curso': curso},
      );

  /// La función `actualizarCurso` actualiza un curso en una base de datos utilizando la sesión y el
  /// objeto del curso proporcionados.
  _i2.Future<_i4.Curso> actualizarCurso({required _i4.Curso curso}) =>
      caller.callServerEndpoint<_i4.Curso>(
        'curso',
        'actualizarCurso',
        {'curso': curso},
      );

  /// La función `eliminarCurso` elimina un curso de una base de datos utilizando una sesión y un ORM.
  _i2.Future<void> eliminarCurso({required int id}) =>
      caller.callServerEndpoint<void>(
        'curso',
        'eliminarCurso',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointExample extends _i1.EndpointRef {
  EndpointExample(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'example';

  _i2.Future<String> hello(String name) => caller.callServerEndpoint<String>(
        'example',
        'hello',
        {'name': name},
      );
}

class Client extends _i1.ServerpodClient {
  Client(
    String host, {
    _i5.SecurityContext? context,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
  }) : super(
          host,
          _i6.Protocol(),
          context: context,
          authenticationKeyManager: authenticationKeyManager,
        ) {
    asignatura = EndpointAsignatura(this);
    curso = EndpointCurso(this);
    example = EndpointExample(this);
  }

  late final EndpointAsignatura asignatura;

  late final EndpointCurso curso;

  late final EndpointExample example;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'asignatura': asignatura,
        'curso': curso,
        'example': example,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
