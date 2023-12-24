import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/kyc/bloc/bloc_kyc.dart';
import 'package:escuelas_flutter/features/auth/kyc/widgets/widgets.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularKyc}
/// Vista celular de la pantalla 'Kyc'
/// {@endtemplate}
class VistaCelularKyc extends StatelessWidget {
  /// {@macro VistaCelularKyc}
  const VistaCelularKyc({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;
    // TODO(Gon): El Scaffold y el appbar deberan ser eliminados cuando se defina la navegacion
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<BlocKyc, BlocKycEstado>(
          builder: (context, state) {
            return Text(
              l10n.pageKycTitle(state.rolElegido?.nombre ?? ''),
              style: TextStyle(
                color: colores.onBackground,
                fontWeight: FontWeight.w800,
                fontSize: 16.pf,
              ),
            );
          },
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<BlocKyc, BlocKycEstado>(
        builder: (context, state) {
          if (state is BlocKycEstadoCargando) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: EdgeInsets.only(bottom: 40.ph),
            child: Column(
              children: [
                SizedBox(height: 20.ph),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.pw),
                  child: Text(
                    l10n.pageKycDescription,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colores.onBackground,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.pf,
                    ),
                  ),
                ),
                SizedBox(height: 20.ph),
                const ListaDeBloqueMateria(),
                const BotonAgregarBloqueMateria(),
                SizedBox(height: 20.ph),
                const BotonSolicitarRol(),
              ],
            ),
          );
        },
      ),
    );
  }
}
