import 'dart:io';

import 'package:rolemissions/rolemissions.dart';

void main() {
  final rolemission = Rolemissions(
    persistanceDelegate: PostgresStrategy(
      host: 'db.mvdsvzvejhmrnxgdfdwz.supabase.co',
      databaseName: 'postgres',
      userName: 'postgres',
      dbPassword: 'L86Grm9pso3LyUdA',
      port: 5432,
    ),
  );

  rolemission.initialFixture(
    userTable: 'usuarios',
  );

  exit(0);
}
