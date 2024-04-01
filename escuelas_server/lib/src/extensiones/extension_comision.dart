import 'package:escuelas_server/src/generated/protocol.dart';

extension ComisionDeCursoX on ComisionDeCurso {
  String get nombreDelCurso => curso?.nombre ?? '';

  String get nombreDelCursoYLaComision => '$nombreDelCurso $nombre';

  List<Asignatura> get listaDeAsignaturas => curso?.asignaturas ?? [];

  List<Usuario> get listaDeEstudiantes =>
      estudiantes
          ?.map(
            (e) =>
                e.usuario ??
                Usuario(
                  idUserInfo: 0,
                  nombre: '',
                  apellido: '',
                  urlFotoDePerfil: '',
                  necesitaCambiarPassword: false,
                ),
          )
          .where((element) => element.id != null)
          .toList() ??
      [];
}
