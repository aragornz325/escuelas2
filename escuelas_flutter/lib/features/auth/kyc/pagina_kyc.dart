import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/auth/kyc/bloc/bloc_kyc.dart';
import 'package:escuelas_flutter/features/auth/kyc/celular/vista_celular_kyc.dart';
import 'package:escuelas_flutter/features/auth/kyc/escritorio/vista_escritorio_kyc.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template VistaEscritorioKyc}
/// Pagina de la pantalla 'Kyc'
/// {@endtemplate}
@RoutePage()
class PaginaKyc extends StatelessWidget {
  /// {@macro PaginaKyc}
  const PaginaKyc({
    required this.rolElegido,
    super.key,
  });

  /// Rol elegido por el usuario en la pantalla de eleccion de rol
  final Rol rolElegido;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocKyc>(
      create: (context) => BlocKyc(rolElegido),
      child: const FullResponsiveScreen(
        celular: VistaCelularKyc(),
        escritorio: VistaEscritorioKyc(),
      ),
    );
  }
}
