import 'package:escuelas_server/src/generated/protocol.dart';

extension ComisionDeCursoX on ComisionDeCurso {
  String get nombreDelCurso => curso?.nombre ?? '';

  String get nombreDelCursoYLaComision =>
      curso != null ? '${curso!.nombre} $nombre' : '';

  List<Asignatura> get listaDeAsignaturas => curso?.asignaturas ?? [];

  List<Usuario> get listaDeEstudiantes =>
      estudiantes
          ?.map(
            (e) =>
                e.usuario ??
                Usuario(
                  idUserInfo: 0,
                  nombre: 'nombre',
                  apellido: 'apellido',
                  urlFotoDePerfil: 'urlFotoDePerfil',
                ),
          )
          .where((element) => element.id != null)
          .toList() ??
      [];
}
