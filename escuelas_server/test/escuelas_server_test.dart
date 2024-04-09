import 'dart:io';

import 'package:test/test.dart';

import 'server_test.dart';

Future<void> main() async {
  final ahora = DateTime.now();

  await runServerTesting([]);

  final session = await podTesting.createSession();

  final authKey = await session.auth.signInUser(3, 'email');

  exit(0);
}
