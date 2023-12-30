import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/login/bloc/bloc_login.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template VistaCelularLogin}
/// Vista de celular de la pantalla de login
/// {@endtemplate}
class VistaCelularLogin extends StatelessWidget {
  /// {@macro VistaCelularLogin}
  const VistaCelularLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    final l10n = context.l10n;

    return Scaffold(
      body: BlocBuilder<BlocLogin, BlocLoginEstado>(
        builder: (context, state) {
          return Container();
        },
      ),
    );
  }
}
