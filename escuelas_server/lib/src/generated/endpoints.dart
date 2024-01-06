/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/asignatura_endpoint.dart' as _i2;
import '../endpoints/asistencia_endpoint.dart' as _i3;
import '../endpoints/curso_endpoint.dart' as _i4;
import '../endpoints/example_endpoint.dart' as _i5;
import '../endpoints/roles_endpoint.dart' as _i6;
import '../endpoints/usuario_endpoint.dart' as _i7;
import 'package:escuelas_server/src/generated/curso/asignatura.dart' as _i8;
import 'package:escuelas_server/src/generated/asistencia/asistencia_diaria.dart'
    as _i9;
import 'package:escuelas_server/src/generated/curso/curso.dart' as _i10;
import 'package:escuelas_server/src/generated/usuario/rol_de_usuario.dart'
    as _i11;
import 'package:escuelas_server/src/generated/usuario/usuario_pendiente.dart'
    as _i12;
import 'package:serverpod_auth_server/module.dart' as _i13;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'asignatura': _i2.AsignaturaEndpoint()
        ..initialize(
          server,
          'asignatura',
          null,
        ),
      'asistencia': _i3.AsistenciaEndpoint()
        ..initialize(
          server,
          'asistencia',
          null,
        ),
      'curso': _i4.CursoEndpoint()
        ..initialize(
          server,
          'curso',
          null,
        ),
      'example': _i5.ExampleEndpoint()
        ..initialize(
          server,
          'example',
          null,
        ),
      'roles': _i6.RolesEndpoint()
        ..initialize(
          server,
          'roles',
          null,
        ),
      'usuario': _i7.UsuarioEndpoint()
        ..initialize(
          server,
          'usuario',
          null,
        ),
    };
    connectors['asignatura'] = _i1.EndpointConnector(
      name: 'asignatura',
      endpoint: endpoints['asignatura']!,
      methodConnectors: {
        'obtenerAsignaturaPorId': _i1.MethodConnector(
          name: 'obtenerAsignaturaPorId',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['asignatura'] as _i2.AsignaturaEndpoint)
                  .obtenerAsignaturaPorId(
            session,
            id: params['id'],
          ),
        ),
        'obtenerAsignaturas': _i1.MethodConnector(
          name: 'obtenerAsignaturas',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['asignatura'] as _i2.AsignaturaEndpoint)
                  .obtenerAsignaturas(session),
        ),
        'crearAsignatura': _i1.MethodConnector(
          name: 'crearAsignatura',
          params: {
            'asignatura': _i1.ParameterDescription(
              name: 'asignatura',
              type: _i1.getType<_i8.Asignatura>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['asignatura'] as _i2.AsignaturaEndpoint)
                  .crearAsignatura(
            session,
            asignatura: params['asignatura'],
          ),
        ),
        'actualizarAsignatura': _i1.MethodConnector(
          name: 'actualizarAsignatura',
          params: {
            'asignatura': _i1.ParameterDescription(
              name: 'asignatura',
              type: _i1.getType<_i8.Asignatura>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['asignatura'] as _i2.AsignaturaEndpoint)
                  .actualizarAsignatura(
            session,
            asignatura: params['asignatura'],
          ),
        ),
        'eliminarAsignatura': _i1.MethodConnector(
          name: 'eliminarAsignatura',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['asignatura'] as _i2.AsignaturaEndpoint)
                  .eliminarAsignatura(
            session,
            id: params['id'],
          ),
        ),
      },
    );
    connectors['asistencia'] = _i1.EndpointConnector(
      name: 'asistencia',
      endpoint: endpoints['asistencia']!,
      methodConnectors: {
        'crearAsistenciasEnLote': _i1.MethodConnector(
          name: 'crearAsistenciasEnLote',
          params: {
            'asistencias': _i1.ParameterDescription(
              name: 'asistencias',
              type: _i1.getType<List<_i9.AsistenciaDiaria>>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['asistencia'] as _i3.AsistenciaEndpoint)
                  .crearAsistenciasEnLote(
            session,
            asistencias: params['asistencias'],
          ),
        )
      },
    );
    connectors['curso'] = _i1.EndpointConnector(
      name: 'curso',
      endpoint: endpoints['curso']!,
      methodConnectors: {
        'obtenerCursoPorId': _i1.MethodConnector(
          name: 'obtenerCursoPorId',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['curso'] as _i4.CursoEndpoint).obtenerCursoPorId(
            session,
            id: params['id'],
          ),
        ),
        'obtenerCursos': _i1.MethodConnector(
          name: 'obtenerCursos',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['curso'] as _i4.CursoEndpoint).obtenerCursos(session),
        ),
        'crearCurso': _i1.MethodConnector(
          name: 'crearCurso',
          params: {
            'curso': _i1.ParameterDescription(
              name: 'curso',
              type: _i1.getType<_i10.Curso>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['curso'] as _i4.CursoEndpoint).crearCurso(
            session,
            curso: params['curso'],
          ),
        ),
        'actualizarCurso': _i1.MethodConnector(
          name: 'actualizarCurso',
          params: {
            'curso': _i1.ParameterDescription(
              name: 'curso',
              type: _i1.getType<_i10.Curso>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['curso'] as _i4.CursoEndpoint).actualizarCurso(
            session,
            curso: params['curso'],
          ),
        ),
        'eliminarCurso': _i1.MethodConnector(
          name: 'eliminarCurso',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['curso'] as _i4.CursoEndpoint).eliminarCurso(
            session,
            id: params['id'],
          ),
        ),
      },
    );
    connectors['example'] = _i1.EndpointConnector(
      name: 'example',
      endpoint: endpoints['example']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['example'] as _i5.ExampleEndpoint).hello(
            session,
            params['name'],
          ),
        )
      },
    );
    connectors['roles'] = _i1.EndpointConnector(
      name: 'roles',
      endpoint: endpoints['roles']!,
      methodConnectors: {
        'obtenerRolPorId': _i1.MethodConnector(
          name: 'obtenerRolPorId',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roles'] as _i6.RolesEndpoint).obtenerRolPorId(
            session,
            id: params['id'],
          ),
        ),
        'obtenerRoles': _i1.MethodConnector(
          name: 'obtenerRoles',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roles'] as _i6.RolesEndpoint).obtenerRoles(session),
        ),
        'crearRol': _i1.MethodConnector(
          name: 'crearRol',
          params: {
            'rol': _i1.ParameterDescription(
              name: 'rol',
              type: _i1.getType<_i11.RolDeUsuario>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roles'] as _i6.RolesEndpoint).crearRol(
            session,
            rol: params['rol'],
          ),
        ),
        'actualizarRol': _i1.MethodConnector(
          name: 'actualizarRol',
          params: {
            'rol': _i1.ParameterDescription(
              name: 'rol',
              type: _i1.getType<_i11.RolDeUsuario>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roles'] as _i6.RolesEndpoint).actualizarRol(
            session,
            rol: params['rol'],
          ),
        ),
        'eliminarRol': _i1.MethodConnector(
          name: 'eliminarRol',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['roles'] as _i6.RolesEndpoint).eliminarRol(
            session,
            id: params['id'],
          ),
        ),
      },
    );
    connectors['usuario'] = _i1.EndpointConnector(
      name: 'usuario',
      endpoint: endpoints['usuario']!,
      methodConnectors: {
        'obtenerUsuarioPendiente': _i1.MethodConnector(
          name: 'obtenerUsuarioPendiente',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['usuario'] as _i7.UsuarioEndpoint)
                  .obtenerUsuarioPendiente(session),
        ),
        'obtenerUsuariosPendientes': _i1.MethodConnector(
          name: 'obtenerUsuariosPendientes',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['usuario'] as _i7.UsuarioEndpoint)
                  .obtenerUsuariosPendientes(session),
        ),
        'enviarSoliciturRegistro': _i1.MethodConnector(
          name: 'enviarSoliciturRegistro',
          params: {
            'usuarioPendiente': _i1.ParameterDescription(
              name: 'usuarioPendiente',
              type: _i1.getType<_i12.UsuarioPendiente>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['usuario'] as _i7.UsuarioEndpoint)
                  .enviarSoliciturRegistro(
            session,
            usuarioPendiente: params['usuarioPendiente'],
          ),
        ),
        'actualizarUsuarioPendiente': _i1.MethodConnector(
          name: 'actualizarUsuarioPendiente',
          params: {
            'usuarioPendiente': _i1.ParameterDescription(
              name: 'usuarioPendiente',
              type: _i1.getType<_i12.UsuarioPendiente>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['usuario'] as _i7.UsuarioEndpoint)
                  .actualizarUsuarioPendiente(
            session,
            usuarioPendiente: params['usuarioPendiente'],
          ),
        ),
      },
    );
    modules['serverpod_auth'] = _i13.Endpoints()..initializeEndpoints(server);
  }
}
