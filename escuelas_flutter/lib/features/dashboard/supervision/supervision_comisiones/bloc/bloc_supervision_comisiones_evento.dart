part of 'bloc_supervision_comisiones.dart';

/// {@template BlocSupervisionComisionesEvento}
/// Eventos para el bloc de supervision de comisiones
/// {@endtemplate}
abstract class BlocSupervisionComisionesEvento {
  /// {@macro BlocSupervisionComisionesEvento}
  const BlocSupervisionComisionesEvento();
}

/// {@template BlocSupervisionComisionesEventoInicializar}
/// Evento para inicializar el bloc de supervision de comisiones
/// {@endtemplate}
class BlocSupervisionComisionesEventoInicializar
    extends BlocSupervisionComisionesEvento {
  /// {@macro BlocSupervisionComisionesEventoInicializar}
  const BlocSupervisionComisionesEventoInicializar({
    required this.fecha,
  });

  /// Fecha utilizada para traer los datos de las comisiones
  final DateTime fecha;
}

/// {@template BlocSupervisionComisionesEventoEnviarEmails}
/// Evento para enviar los correos a las comisiones.
/// {@endtemplate}
class BlocSupervisionComisionesEventoEnviarEmails
    extends BlocSupervisionComisionesEvento {
  /// {@macro BlocSupervisionComisionesEventoEnviarEmails}
  const BlocSupervisionComisionesEventoEnviarEmails();
}
