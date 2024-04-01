import 'dart:convert';
import 'dart:io';

import 'package:escuelas_server/server.dart';
import 'package:escuelas_server/src/endpoints/user_info_endpoint.dart';
import 'package:escuelas_server/src/endpoints/usuario_endpoint.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_usuario_pendiente.dart';

/// SCRIPT PARA REGISTRAR USUARIOS EN MASA A PARTIR DE UN ARCHIVO JSON.
/// NECESITAN LOS CAMPOS: NOMBRE, APELLIDO, EMAIL, DNI.
///
/// SI SON ESTUDIANTES SE NECESITA TAMBIÉN EL ID DE LA COMISIÓN A LA QUE
/// CORRESPONDEN.
/// 
/// SI SON DOCENTES, SE NECESITAN LOS IDs de LAS ASIGNATURAS Y LOS IDs DE 
/// LAS COMISIONES DE LAS ASIGNATURAS QUE LES CORRESPONDEN.
///
/// INDICAR EN LA CONSTANTE `runMode` el entorno en el que se debe ejecutar.
/// INDICAR EN LA CONSTANTE `rutaDelArchivoJsonConLosDatosDeLosUsuarios` la ruta del archivo JSON.
/// INDICAR EN LA CONSTANTE `tipoDeUser` SI SON ESTUDIANTES, DOCENTES o DIRECTIVOS.
Future<void> main() async {
  const runMode = 'development';
  const rutaDelArchivoJsonConLosDatosDeLosUsuarios =
      'archivo_con_usuarios.json';
  const tipoDeUser = TipoDeUser.estudiante;
  const urlFotoDePerfilUsuarioDefault = 'https://res.cloudinary.com/dovck0lft/image/upload/v1710430707/contentHeadingImages/img_content_63_1710430707199.jpg';
  const labelCampoNombre = 'nombre';
  const labelCampoApellido = 'apellido';
  const labelCampoEmail = 'email';
  const labelCampoDni = 'dni';
  const labelCampoComision = 'comision';

  final ahora = DateTime.now();

  await run(['--mode', runMode]);

  final session = await pod.createSession();

  final alumnos = jsonDecode(File(
    rutaDelArchivoJsonConLosDatosDeLosUsuarios,
  ).readAsStringSync());

  for (final alumno in alumnos) {
    try {
      final nombreAlumno = alumno[labelCampoNombre].toString();
      final apellidoAlumno = alumno[labelCampoApellido].toString();
      final emailAlumno = alumno[labelCampoEmail].toString();
      final dniAlumno = alumno[labelCampoDni].toString();
      final comisionAlumno = int.tryParse(alumno[labelCampoComision].toString());
      final asignaturasSolicitadas;

      final user = await UserInfoEndpoint().registrarUserInfo(
        session,
        nombre: nombreAlumno,
        apellido: apellidoAlumno,
        email: emailAlumno,
        password: 'Password123!',
        dni: dniAlumno,
      );

      if (user.id == null) {
        print(
            'El id del UserInfo creado se retornó null, saltando al siguiente...');
        continue;
      }

      final idUserInfo = user.id!;
      final nombreUser = user.userName.split(';').first;
      final apellidoUser = user.userName.split(';').last;

      final soli = await OrmUsuarioPendiente().crearUsuarioPendiente(
        session,
        usuarioPendiente: UsuarioPendiente(
          idUserInfo: idUserInfo,
          nombre: nombreUser,
          apellido: apellidoUser,
          urlFotoDePerfil:
              urlFotoDePerfilUsuarioDefault,
          dni: dniAlumno,
          idRolSolicitado: tipoDeUser.index + 1,
          estadoDeSolicitud: EstadoDeSolicitud.pendiente,
          ultimaModificacion: ahora,
          fechaCreacion: ahora,
          comisionSolicitadaId: comisionAlumno,
        ),
      );

      if (soli.id == null) {
        print(
            'El id del UsuarioPendiente creado se retornó null, saltando al siguiente...');
        continue;
      }

      final idUsuarioPendiente = soli.id!;

      await UsuarioEndpoint().responderSolicitudDeRegistro(
        session,
        estadoDeSolicitud: EstadoDeSolicitud.aprobado,
        idUsuarioPendiente: idUsuarioPendiente,
      );
    } catch (e, st) {
      print('ERROR: $e\n$st');
      continue;
    }
  }

  exit(0);
}

enum TipoDeUser {
  estudiante,
  docente,
  directivo,
}
