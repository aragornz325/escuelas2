import 'package:escuelas_client/escuelas_client.dart';

/// Configuraciones de escuelas
///
/// Esta clase es la encargada de proveer las configuraciones de las instancias.
abstract class ConfigsDeInstancia {
  int get diasDeAnticipacion => throw UnimplementedError();

  DateTime fechaDeEnvio(DateTime primeroDeMes) =>
      primeroDeMes.subtract(Duration(days: diasDeAnticipacion));

  List<Periodo> periodosDelAnioLectivo(int anio) => throw UnimplementedError();
}
