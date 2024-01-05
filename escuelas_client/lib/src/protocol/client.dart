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
import 'package:escuelas_client/src/protocol/asistencia/asistencia_diaria.dart'
    as _i4;
import 'package:escuelas_client/src/protocol/curso/curso.dart' as _i5;
import 'package:escuelas_client/src/protocol/usuario/usuario_pendiente.dart'
    as _i6;
import 'package:serverpod_auth_client/module.dart' as _i7;
import 'dart:io' as _i8;
import 'protocol.dart' as _i9;

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
class EndpointAsistencia extends _i1.EndpointRef {
  EndpointAsistencia(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'asistencia';

  /// La función `crearAsistenciasEnBatch` crea un nuevo objeto `AsistenciaDiaria` en la base de datos usando la
  /// sesión proporcionada y devuelve el objeto creado.
  _i2.Future<String> crearAsistenciasEnLote(
          {required List<_i4.AsistenciaDiaria> asistencias}) =>
      caller.callServerEndpoint<String>(
        'asistencia',
        'crearAsistenciasEnLote',
        {'asistencias': asistencias},
      );
}

/// {@category Endpoint}
class EndpointCurso extends _i1.EndpointRef {
  EndpointCurso(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'curso';

  /// La función "obtenerCursoPorId" recupera un curso por su ID usando una sesión y un ORM.
  _i2.Future<_i5.Curso> obtenerCursoPorId({required int id}) =>
      caller.callServerEndpoint<_i5.Curso>(
        'curso',
        'obtenerCursoPorId',
        {'id': id},
      );

  /// La función "obtenerCursos" recupera una lista de cursos utilizando un objeto de sesión.
  _i2.Future<List<_i5.Curso>> obtenerCursos() =>
      caller.callServerEndpoint<List<_i5.Curso>>(
        'curso',
        'obtenerCursos',
        {},
      );

  /// La función `crearCurso` crea un curso en una base de datos utilizando la sesión y el objeto del
  /// curso proporcionados.
  _i2.Future<_i5.Curso> crearCurso({required _i5.Curso curso}) =>
      caller.callServerEndpoint<_i5.Curso>(
        'curso',
        'crearCurso',
        {'curso': curso},
      );

  /// La función `actualizarCurso` actualiza un curso en una base de datos utilizando la sesión y el
  /// objeto del curso proporcionados.
  _i2.Future<_i5.Curso> actualizarCurso({required _i5.Curso curso}) =>
      caller.callServerEndpoint<_i5.Curso>(
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

/// {@category Endpoint}
class EndpointUsuario extends _i1.EndpointRef {
  EndpointUsuario(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'usuario';

  _i2.Future<_i6.UsuarioPendiente> obtenerUsuariosPendientes() =>
      caller.callServerEndpoint<_i6.UsuarioPendiente>(
        'usuario',
        'obtenerUsuariosPendientes',
        {},
      );

  _i2.Future<_i6.UsuarioPendiente> enviarSoliciturRegistro(
          {required _i6.UsuarioPendiente usuarioPendiente}) =>
      caller.callServerEndpoint<_i6.UsuarioPendiente>(
        'usuario',
        'enviarSoliciturRegistro',
        {'usuarioPendiente': usuarioPendiente},
      );
}

class _Modules {
  _Modules(Client client) {
    auth = _i7.Caller(client);
  }

  late final _i7.Caller auth;
}

class Client extends _i1.ServerpodClient {
  Client(
    String host, {
    _i8.SecurityContext? context,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
  }) : super(
          host,
          _i9.Protocol(),
          context: context,
          authenticationKeyManager: authenticationKeyManager,
        ) {
    asignatura = EndpointAsignatura(this);
    asistencia = EndpointAsistencia(this);
    curso = EndpointCurso(this);
    example = EndpointExample(this);
    usuario = EndpointUsuario(this);
    modules = _Modules(this);
  }

  late final EndpointAsignatura asignatura;

  late final EndpointAsistencia asistencia;

  late final EndpointCurso curso;

  late final EndpointExample example;

  late final EndpointUsuario usuario;

  late final _Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'asignatura': asignatura,
        'asistencia': asistencia,
        'curso': curso,
        'example': example,
        'usuario': usuario,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}
