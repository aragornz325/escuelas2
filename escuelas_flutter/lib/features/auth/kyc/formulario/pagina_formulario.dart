import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/auth/kyc/formulario/celular/vista_celular_formulario.dart';
import 'package:escuelas_flutter/features/auth/kyc/formulario/escritorio/vista_escritorio_formulario.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';

/// {@template PaginaFormulario}
/// Pagina de la pantalla 'Formulario'
/// {@endtemplate}
@RoutePage()
class PaginaFormulario extends StatelessWidget {
  /// {@macro PaginaFormulario}
  const PaginaFormulario({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const FullResponsiveScreen(
      celular: VistaCelularFormulario(),
      escritorio: VistaEscritorioFormulario(),
    );
  }
}
