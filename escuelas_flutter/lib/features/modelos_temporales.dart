// TODO(Gon): Eliminar modelo cuando se usen los del back
class OpcionFormulario {
  OpcionFormulario({
    required this.curso,
    required this.materia,
    required this.id,
  });

  factory OpcionFormulario.fromJson(Map<String, dynamic> json) {
    return OpcionFormulario(
      curso: Curso.fromJson(json['curso'] as Map<String, dynamic>),
      materia: Materia.fromJson(json['materia'] as Map<String, dynamic>),
      id: json['id'] as int,
    );
  }

  Curso curso;
  Materia materia;
  final int id;

  Map<String, dynamic> toJson() {
    return {
      'curso': curso,
      'materia': materia,
      'id': id,
    };
  }
}

// TODO(Gon): Eliminar modelo cuando se usen los del back
class Curso {
  Curso({
    required this.nombre,
    required this.id,
  });
  factory Curso.fromJson(Map<String, dynamic> json) {
    return Curso(
      nombre: json['nombre'] as String,
      id: json['id'] as int,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'id': id,
    };
  }

  final String nombre;
  final int id;
}

// TODO(Gon): Eliminar modelo cuando se usen los del back
class Materia {
  Materia({
    required this.nombre,
    required this.id,
    required this.idCurso,
  });

  factory Materia.fromJson(Map<String, dynamic> json) {
    return Materia(
      nombre: json['nombre'] as String,
      idCurso: json['id_curso'] as int,
      id: json['id'] as int,
    );
  }
  final int idCurso;
  final String nombre;
  final int id;

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'id_curso': idCurso,
      'id': id,
    };
  }
}

// TODO(Gon): Eliminar modelo cuando se usen los del back
class Rol {
  Rol({
    required this.nombre,
    required this.permisos,
    required this.id,
  });

  factory Rol.fromJson(Map<String, dynamic> json) {
    return Rol(
      nombre: json['nombre'] as String,
      permisos: List<String>.from(json['permisos'] as List<String>),
      id: json['id'] as int,
    );
  }

  String nombre;
  List<String> permisos;
  int id;

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'permisos': permisos,
      'id': id,
    };
  }
}

// TODO(SAM): Eliminar luego cuando venga del back
enum Roles {
  directivo,
  alumno,
  docente;

  Rol get rol {
    switch (this) {
      case Roles.directivo:
        return Rol(
          nombre: 'Directivo',
          permisos: [],
          id: 0,
        );
      case Roles.alumno:
        return Rol(
          nombre: 'Alumno',
          permisos: [],
          id: 1,
        );
      case Roles.docente:
        return Rol(
          nombre: 'Docente',
          permisos: [],
          id: 2,
        );
    }
  }
}

// TODO(SAM): Eliminar luego cuando venga del back
class InfoUsuario {
  InfoUsuario({
    required this.nombre,
    required this.rol,
    required this.id,
    required this.email,
    required this.imagen,
    required this.edad,
    this.telefono,
    this.factorSanguineo,
  });
  String nombre;
  int id;
  Roles rol;
  int? telefono;
  String email;
  String imagen;
  String? factorSanguineo;
  int edad;
}

final listaUsuariosPendientes = [
  InfoUsuario(
    email: 'asd@sad.acs',
    imagen: '',
    nombre: 'Larrea Fernanda',
    rol: Roles.alumno,
    id: 0,
    edad: 31,
  ),
  InfoUsuario(
    edad: 1,
    email: 'asd@asd.asdas',
    imagen: '',
    nombre: 'Matias Sanchez',
    rol: Roles.directivo,
    id: 1,
  ),
  InfoUsuario(
    imagen: '',
    edad: 12,
    email: 'asd@asd.asdas',
    nombre: 'Gonzalo Rigoni',
    rol: Roles.directivo,
    id: 2,
  ),
  InfoUsuario(
    imagen: '',
    edad: 14,
    email: 'asd@asd.asdas',
    nombre: 'Mendizabal Carlos',
    rol: Roles.docente,
    id: 4,
  ),
  InfoUsuario(
    imagen: '',
    edad: 51,
    email: 'asd@asd.asdas',
    nombre: 'Lopez Fernando',
    rol: Roles.docente,
    id: 5,
  ),
  InfoUsuario(
    imagen: '',
    edad: 51,
    email: 'asd@asd.asdas',
    nombre: 'Cunso Laura',
    rol: Roles.alumno,
    id: 6,
  ),
];
