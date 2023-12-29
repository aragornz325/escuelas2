import 'package:escuelas_flutter/app/app.dart';
import 'package:escuelas_flutter/bootstrap.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: 'stg.env');
  await bootstrap(
    App.new,
    entorno: EntornosDeDesarrollo.staging.name,
    hostUrl: dotenv.env['API_URL']!,
  );
}
