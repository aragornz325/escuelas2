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
    imagen:
        'https://scontent.cdninstagram.com/v/t51.2885-15/156141943_116374040380782_8550082029919709786_n.jpg?stp=dst-jpg_e35&efg=eyJ2ZW5jb2RlX3RhZyI6ImltYWdlX3VybGdlbi42MzJ4NjMyLnNkciJ9&_nc_ht=scontent.cdninstagram.com&_nc_cat=106&_nc_ohc=o88zgJDc4aIAX-lVkal&edm=APs17CUBAAAA&ccb=7-5&ig_cache_key=MjUyMTM3ODc0MDg1Njk5OTY1Mw%3D%3D.2-ccb7-5&oh=00_AfB3nPw-OG-IMXTYL_Uu9B7OPRRWbSgVNXJurmyk7AU1rQ&oe=65907177&_nc_sid=10d13b',
    nombre: 'Larrea Fernanda',
    rol: Roles.alumno,
    id: 0,
    edad: 31,
  ),
  InfoUsuario(
    edad: 1,
    email: 'asd@asd.asdas',
    imagen:
        'https://static.wikia.nocookie.net/450329c0-0d9f-49e5-a28f-f5ddf5697e7c/scale-to-width/755',
    nombre: 'Matias Sanchez',
    rol: Roles.directivo,
    id: 1,
  ),
  InfoUsuario(
    imagen:
        'https://i.pinimg.com/564x/fa/6d/d1/fa6dd1a0682daeb6201d1231c35640cd.jpg',
    edad: 12,
    email: 'asd@asd.asdas',
    nombre: 'Gonzalo Rigoni',
    rol: Roles.directivo,
    id: 2,
  ),
  InfoUsuario(
    imagen:
        'https://i.pinimg.com/736x/1d/32/4e/1d324e4a6f8652d520d734ae3e9ffa75.jpg',
    edad: 14,
    email: 'asd@asd.asdas',
    nombre: 'Mendizabal Carlos',
    rol: Roles.docente,
    id: 4,
  ),
  InfoUsuario(
    imagen:
        'https://scontent.flpg2-1.fna.fbcdn.net/v/t1.6435-9/126901301_2462762727364760_7764337153070352095_n.jpg?stp=dst-jpg_p600x600&_nc_cat=109&ccb=1-7&_nc_sid=dd63ad&_nc_eui2=AeGILELI65Y3jNXKRgX6_bOrrDI14Vt0c6asMjXhW3RzpoDcXrWqKsiidGGuK2GMMJ1-bM-UC7mAyQ2v_qUXVBNy&_nc_ohc=eKUax65WJ_oAX-wjpWR&_nc_ht=scontent.flpg2-1.fna&oh=00_AfCyo_z-WqI7etUe9TDnoFJHLSH2LerLh92UxD8KbA35KQ&oe=65B3D99D',
    edad: 51,
    email: 'asd@asd.asdas',
    nombre: 'Lopez Fernando',
    rol: Roles.docente,
    id: 5,
  ),
  InfoUsuario(
    imagen:
        'https://akamai.sscdn.co/letras/207x366/fotos/0/1/6/5/0165472db69857b2e0beedf5079300d5.jpg',
    edad: 51,
    email: 'asd@asd.asdas',
    nombre: 'Cunso Laura',
    rol: Roles.alumno,
    id: 6,
  ),
];
