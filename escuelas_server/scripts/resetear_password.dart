import 'package:escuelas_server/server.dart';
import 'package:serverpod_auth_server/module.dart';


const flagArgumentoDeModo = '--mode';
const modoDevelopment = 'development';
const modoProduction = 'production';

Future<void> main(List<String> args) async {

  final idDeRegistroDeEmailAuth = 0; // PONER ACÁ EL REGISTRO CON LA PASSWORD QUE QUERÉS CAMBIAR.

  await run([flagArgumentoDeModo, modoDevelopment]); // SEGUNDO ELEMENTO, EL RUNMODE. modoDevelopment y modoProduction (constantes al principio).

  final session = await pod.createSession();

  // Esto es el ORM para actualizar un registro con la contraseña de una cuenta.
  // Lo que importa acá es el ID del registro de la tabla `serverpod_email_auth`.
  await EmailAuth.db.updateRow(
    session,
    EmailAuth(
      id: idDeRegistroDeEmailAuth, // Lo que importa (tabla serverpod_email_auth).
      userId: 3, // Dato irrelevante.
      email: 'email', // Dato irrelevante.
      hash: await Emails.generatePasswordHash( // Acá se guarda el HASH de la password.
        'password', // NUEVA PASSWORD.
      ),
    ),
    columns: (p0) => [
      p0.hash, // IMPORTANTE QUE ESTO ESTÉ ASÍ PARA QUE NO HAYA QUE AGREGAR NINGÚN OTRO DATO MÁS QUE EL ID Y LA NUEVA PASSWORD.
    ],
  );
}
