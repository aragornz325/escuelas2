// TODO(Gon): Eliminar modelo cuando se usen los del back
class OpcionFormulario {
  OpcionFormulario({
    required this.curso,
    required this.materia,
    required this.id,
  });
  Curso curso;
  Materia materia;
  final int id;
}

// TODO(Gon): Eliminar modelo cuando se usen los del back
class Curso {
  Curso({
    required this.nombre,
    required this.id,
  });
  final String nombre;
  final int id;
}

// TODO(Gon): Eliminar modelo cuando se usen los del back
class Materia {
  Materia({
    required this.nombre,
    required this.id,
  });
  final String nombre;
  final int id;
}

// TODO(Gon): Eliminar modelo cuando se usen los del back
class Rol {
  Rol({required this.nombre, required this.permisos, required this.id});
  String nombre;
  List<String> permisos;
  int id;
}

// TODO(SAM): Eliminar luego cuando venga del back
enum Permiso { directivo, alumno, profesor }

// TODO(SAM): Eliminar luego cuando venga del back
class InfoUsuario {
  InfoUsuario({required this.nombre, required this.permiso});
  String nombre;
  List<Permiso> permiso;
}
