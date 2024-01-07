import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/auth/kyc/espera/celular/vista_celular_espera.dart';
import 'package:escuelas_flutter/features/auth/kyc/espera/escritorio/vista_escritorio_espera.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';

/// {@template PaginaEspera}
/// Pagina de la pantalla 'Espera'a la aprobacion de cuenta y rol del usuario.
/// {@endtemplate}
@RoutePage()
class PaginaEspera extends StatelessWidget {
  /// {@macro PaginaEspera}
  const PaginaEspera({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const FullResponsiveScreen(
      celular: VistaCelularEspera(),
      escritorio: VistaEscritorioEspera(),
    );
  }
}
