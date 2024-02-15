part of 'bloc_administrar_plantillas.dart';

/// {@template BlocAdministrarPlantillasEstado}
/// Estados para [BlocAdministrarPlantillas]
/// {@endtemplate}
class BlocAdministrarPlantillasEstado {
  /// {@macro BlocAdministrarPlantillasEstado}
  const BlocAdministrarPlantillasEstado._();

  BlocAdministrarPlantillasEstado.desde(
    BlocAdministrarPlantillasEstado otro,
  ) : this._();
}

/// {@template BlocAdministrarPlantillasEstadoInicial}
/// Estado inicial para [PaginaAdministrarPlantillas]
/// {@endtemplate}
class BlocAdministrarPlantillasEstadoInicial
    extends BlocAdministrarPlantillasEstado {
  /// {@macro BlocAdministrarPlantillasEstadoInicial}
  const BlocAdministrarPlantillasEstadoInicial() : super._();
}

/// {@template BlocAdministrarPlantillasEstadoCargando}
/// Estado cargando para [PaginaAdministrarPlantillas]
/// {@endtemplate}
class BlocAdministrarPlantillasEstadoCargando
    extends BlocAdministrarPlantillasEstado {
  /// {@macro BlocAdministrarPlantillasEstadoCargando}
  BlocAdministrarPlantillasEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocAdministrarPlantillasEstadoError}
/// Estado Error para [PaginaAdministrarPlantillas]
/// {@endtemplate}
class BlocAdministrarPlantillasEstadoError
    extends BlocAdministrarPlantillasEstado {
  /// {@macro BlocAdministrarPlantillasEstadoError}
  BlocAdministrarPlantillasEstadoError.desde(super.otro) : super.desde();
}

/// {@template BlocAdministrarPlantillasEstadoExitoso}
/// Estado exitoso para [PaginaAdministrarPlantillas]
/// {@endtemplate}
class BlocAdministrarPlantillasEstadoExitoso
    extends BlocAdministrarPlantillasEstado {
  /// {@macro BlocAdministrarPlantillasEstadoExitoso}
  BlocAdministrarPlantillasEstadoExitoso.desde(super.otro) : super.desde();
}
