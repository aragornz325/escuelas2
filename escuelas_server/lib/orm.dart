import 'package:logging/logging.dart';
import 'package:escuelas_server/src/excepciones/excepcion_endpoint.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// Tipo de funcion que ejecuta el metodo performOdmOperation.
typedef FuncionServerpodDb<T> = Future<T> Function(Session session);

/// Objeto de session de Serverpod.

/// Clase abstracta de ORM con metodo performOperation.
abstract class ORM {
  /// Sesion (clase de Serverpod).
  late Session? session;

  /// Instancia del logger.
  final logger = Logger('ORM');

  /// Metodo para ejecutar las operaciones de los ORM y manejar errores.
  Future<T> ejecutarOperacionOrm<T>(
    Session session,
    FuncionServerpodDb<T> funcion,
  ) async {
    try {
      this.session = session;
      return await funcion(session);
    } on ExcepcionCustom catch (e, st) {
      logger.shout('''
ERROR DE PRLAB:
Titulo: ${e.titulo}
Tipo de error: ${e.tipoDeError}
Código de error: ${e.codigoError}
Mensaje: ${e.mensaje}
StackTrace: $st
''');
      rethrow;
    } on Exception catch (e, st) {
      logger.severe('Unidentified error: $e \n$st');
      throw UnimplementedError(
        'Unidentified error: $e \n$st',
      );
    }
  }

  /// Metodo para ejecutar funciones con queries raw de Serverpod y mapear los
  /// resultados a objetos.
  /// Requiere del script de la query SQL y las "keys" del objeto a devolver.
  Future<List<Map<String, dynamic>>> ejecutarConsultaSql<T>(
    Session session,
    String consulta, {
    required Iterable<String> clavesMapaModeloDb,
    int? tiempoDeEsperaEnSegundos,
    Transaction? transaccion,
  }) async {
    try {
      final consultaDb = await session.db.query(
        consulta,
        timeoutInSeconds: tiempoDeEsperaEnSegundos,
        transaction: transaccion,
      );

      List<String> clavesMapaModeloLista = clavesMapaModeloDb.toList();

      final respuesta = consultaDb.map((e) {
        Map<String, dynamic> modeloRespuesta = {};
        for (final clave in clavesMapaModeloLista) {
          modeloRespuesta[clave] = e[clavesMapaModeloLista.indexOf(clave)];
        }
        return modeloRespuesta;
      }).toList();

      return respuesta;
    } on Exception catch (e, st) {
      throw UnimplementedError(
        'Error no identificado: $e \n$st',
      );
    }
  }

  /// Funcion ORM propia para insertar registros en la Base de
  /// Datos. Requiere el nombre de la tabla y una lista con los
  /// objetos a insertarse (de clase [TableRow]).
  ///
  /// Retorna los ID de los objetos insertados en formato [List].
  Future<List<int>> insertarRegistrosEnDb(
    Session session, {
    required String nombreTabla,
    required List<TableRow> registros,
  }) async {
    try {
      final List<Map> registrosMapas = registros
          .map(
            (row) => row.toJsonForDatabase()
              ..remove('id')
              ..remove('fechaEliminacion'),
          )
          .toList();

      var listaColumnas = <String>[
        ...registrosMapas.first.keys.map((columna) => '"$columna"'),
      ];

      var listasValores = <String>[];

      final cantidadRegistros = registrosMapas.length;

      for (var i = 0; i < cantidadRegistros; i++) {
        final Map registro = registrosMapas[i];
        var valoresRegistro = [];
        for (final columna in registro.keys as Iterable<String>) {
          dynamic valorSinFormato = registro[columna];

          String valor = DatabasePoolManager.encoder.convert(valorSinFormato);

          valoresRegistro.add(valor);
        }

        listasValores.add('(${valoresRegistro.join(', ')})');
      }

      var consulta = '''
        INSERT INTO $nombreTabla (
          ${listaColumnas.join(', ')}
        ) VALUES 
          ${listasValores.join(',\n  ')} 
        RETURNING id;
      ''';

      final respuestaRaw = await session.db.query(
        consulta,
      );

      if (respuestaRaw.isEmpty) {
        throw Exception('Error al crear registro.');
      }

      final List<int> respuestaListaIds =
          respuestaRaw.map((e) => e.first as int).toList();

      return respuestaListaIds;
    } on ExcepcionCustom {
      rethrow;
    } on Exception {
      rethrow;
    }
  }

  /// Funcion ORM propia para actualizar registros en la Base
  /// de Datos. Requiere el nombre de la tabla, el id del registro
  /// y los campos a actualizar en formato [Map].
  Future<List<dynamic>> actualizarRegistroEnDb(
    Session session, {
    required String nombreTabla,
    required int id,
    required Map<String, dynamic> camposRegistro,
    Iterable<String> retornar = const [],
  }) async {
    try {
      final campos = camposRegistro..removeWhere((key, value) => value == null);

      List<String> listaActualizaciones = [];

      for (final columna in campos.keys) {
        if (columna == 'id') {
          continue;
        }

        var valor = DatabasePoolManager.encoder.convert(campos[columna]);

        listaActualizaciones.add('"$columna" = $valor');
      }
      var actualizaciones = listaActualizaciones.join(', ');

      final retornoString = retornar.isNotEmpty
          ? 'RETURNING ${retornar.map(
                (e) => '"$e"',
              ).join(', ')}'
          : '';

      var query = '''
UPDATE $nombreTabla 
SET $actualizaciones 
WHERE id = $id AND ("fechaEliminacion" IS NULL)
$retornoString;
''';

      final response = await session.db.query(query);

      if (response.isNotEmpty) {
        return response.first;
      } else {
        return [];
      }
    } on Exception {
      rethrow;
    }
  }
}
