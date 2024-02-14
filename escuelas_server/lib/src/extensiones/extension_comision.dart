import 'package:escuelas_server/src/generated/protocol.dart';

extension ComisionDeCursoX on ComisionDeCurso {
  String get nombreDelCurso => curso != null ? curso!.nombre : '';
  String get nombreDelCursoYLaComision => curso != null ? '${curso!.nombre} $nombre' : '';
  List<Asignatura> get listaDeAsignaturas => curso != null && curso!.asignaturas != null ? curso!.asignaturas! : [];
  List<Usuario> get listaDeEstudiantes => estudiantes != null ? estudiantes!.map((e) => e.usuario!).toList() : [];
}