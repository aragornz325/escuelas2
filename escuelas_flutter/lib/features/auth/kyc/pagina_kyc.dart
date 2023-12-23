import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/auth/kyc/bloc/bloc_kyc.dart';
import 'package:escuelas_flutter/features/auth/kyc/celular/vista_celular_kyc.dart';
import 'package:escuelas_flutter/features/auth/kyc/escritorio/vista_escritorio_kyc.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template VistaEscritorioKyc}
// TODO(anyone): AGREGAR DOCUMENTACION

/// {@endtemplate}
@RoutePage()
class PaginaKyc extends StatelessWidget {
  /// {@macro PaginaKyc}
  const PaginaKyc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocKyc>(
      create: (context) => BlocKyc(),
      child: const FullResponsiveScreen(
        celular: VistaCelularKyc(),
        escritorio: VistaEscritorioKyc(),
      ),
    );
  }
}
