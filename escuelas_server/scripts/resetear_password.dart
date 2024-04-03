import 'dart:io';

import 'package:escuelas_server/server.dart';
import 'package:serverpod_auth_server/module.dart';

const flagArgumentoDeAmbiente = '--mode';
const flagArgumentoDeEmail = '--email';
const flagArgumentoDeNuevaPassword = '--pass';
const labelAmbienteDevelopment = 'development';
const labelAmbienteProduction = 'production';
const flagsArgumentosPosibles = [
  flagArgumentoDeAmbiente,
  flagArgumentoDeEmail,
  flagArgumentoDeNuevaPassword
];
const labelsAmbientesPosibles = [
  labelAmbienteDevelopment,
  labelAmbienteProduction
];
const passwordDefault = 'password123';

Future<void> main(List<String> args) async {
  String labelAmbiente = labelAmbienteDevelopment;
  String nuevaPassword = 'password123';

  if (args.length < 2) {
    throw StdinException('''
Guarda que te faltan argumentos. 
Es así: "dart run reset_password.dart --email <email-del-user> --pass(opcional) <nueva-password-del-user>" --mode(opcional) <ambiente-de-trabajo>
''');
  }

  if (!args.contains(flagArgumentoDeEmail) ||
      flagsArgumentosPosibles
          .contains(args[args.indexOf(flagArgumentoDeEmail) + 1]) ||
      (args.indexOf(flagArgumentoDeEmail) + 1) == args.length) {
    throw StdinException('''
No pusiste el email del user al que le querés cambiar la pass. 
Es así: "dart run reset_password.dart --email <email-del-user> --pass(opcional) <nueva-password-del-user>"
''');
  }
  String emailDelUser = args[args.indexOf(flagArgumentoDeEmail) + 1]
      .toLowerCase()
      .replaceAll(RegExp(r'''['"\s;:]'''), '');

  if (args.contains(flagArgumentoDeAmbiente)) {
    if ((args.indexOf(flagArgumentoDeNuevaPassword) + 1) == args.length) {
      throw StdinException('''
No pusiste un "--mode" explícito. 
Las opciones válidas son "--mode development" o "--mode production" (GUARDA ACÁ).
''');
    }
    if (!labelsAmbientesPosibles
        .contains(args[args.indexOf(flagArgumentoDeAmbiente) + 1])) {
      throw StdinException('''
Pusiste un "--mode" inválido. 
Las opciones válidas son "--mode development" o "--mode production" (GUARDA ACÁ).
''');
    }
    labelAmbiente = args[args.indexOf(flagArgumentoDeAmbiente) + 1];
    if (labelAmbiente == labelAmbienteProduction) {
      print('Precaución: se ha elegido el ambiente de PRODUCCIÓN.\n');
    }
  }

  if (args.contains(flagArgumentoDeNuevaPassword)) {
    if ((args.indexOf(flagArgumentoDeNuevaPassword) + 1) == args.length ||
        flagsArgumentosPosibles
            .contains(args[args.indexOf(flagArgumentoDeNuevaPassword) + 1])) {
      throw StdinException('''
No pusiste la nueva password del user. 
Es así: "dart run reset_password.dart --email <email-del-user> --pass(opcional) <nueva-password-del-user>"
''');
    }
    nuevaPassword = args[args.indexOf(flagArgumentoDeNuevaPassword) + 1];
  }

  print('Reiniciando password a user con email: $emailDelUser...\n');
  print('Corriendo server en ambiente $labelAmbiente...\n');

  await run([
    flagArgumentoDeAmbiente,
    labelAmbiente
  ]); // SEGUNDO ELEMENTO, EL RUNMODE. modoDevelopment y modoProduction (constantes al principio).

  final session = await pod.createSession();

  print('Realizando consulta de actualización...\n');

  final hashDeNuevaPassword = Emails.generatePasswordHash(nuevaPassword);

  final registrosCambiados = await session.dbNext.unsafeExecute('''
UPDATE "${EmailAuth.t.tableName}"
SET "${EmailAuth.t.hash.columnName}" = '$hashDeNuevaPassword'
WHERE "${EmailAuth.t.userId.columnName}" = (
  SELECT "${UserInfo.t.id.columnName}" 
  FROM "${UserInfo.t.tableName}" 
  WHERE "${UserInfo.t.email.columnName}" = '$emailDelUser'
  );
''');

  final elReinicioDePasswordFueRealizado = registrosCambiados == 1;

  if (elReinicioDePasswordFueRealizado) {
    print('Password del usuario $emailDelUser reiniciada correctamente.\n');
  } else {
    print('No hubo cambios.\n');
  }
}
