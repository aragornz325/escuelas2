import 'configs_de_escuelas.dart';

// TODO(anyone): Antes de produccion chequear las configuraciones de las
// instancias

/// Configuraciones para la escuela Redemptoris Missio
class RedemptorisMissioConfigs extends ConfigsDeInstancia {
  @override
  int get diasDeAnticipacion => 5;

  @override
  DateTime fechaDeEnvio(DateTime primeroDeMes) =>
      primeroDeMes.subtract(Duration(days: diasDeAnticipacion));
}
