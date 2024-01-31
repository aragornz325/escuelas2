import 'dart:io';

import 'package:rolemissions/rolemissions.dart';

void main() async {
  // ! TODO(anyone): remover las credenciales de la base de datos
  final rolemission = Rolemissions(
    persistanceDelegate: PostgresStrategy(
      host: 'aws-0-sa-east-1.pooler.supabase.com',
      databaseName: 'postgres',
      userName: 'postgres.mvdsvzvejhmrnxgdfdwz',
      dbPassword: 'L86Grm9pso3LyUdA',
      port: 5432,
    ),
  );

  await rolemission.initialFixture(
    userTable: 'usuarios',
  );

  exit(0);
}
