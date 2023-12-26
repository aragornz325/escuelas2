import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/kyc/bloc/bloc_kyc.dart';
import 'package:escuelas_flutter/features/auth/kyc/formulario/widgets/widgets.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularFormulario}
/// Vista celular de la pantalla 'Formulario'
/// {@endtemplate}
class VistaCelularFormulario extends StatelessWidget {
  /// {@macro VistaCelularFormulario}
  const VistaCelularFormulario({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;
    // TODO(Gon): El Scaffold y el appbar deberan ser eliminados cuando se defina la navegacion
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => context.router.pop(),
          child: Icon(
            Icons.arrow_back,
            color: colores.onBackground,
          ),
        ),
        title: BlocBuilder<BlocKyc, BlocKycEstado>(
          builder: (context, state) {
            return Text(
              l10n.pageKycFormTitle(state.rolElegido?.nombre ?? ''),
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
                    l10n.pageKycFormDescription,
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
                //TODO (Gon): Cambiar esta logica cuando esten los permisos/roles bien definidos
                if (state.rolElegido?.nombre == 'DOCENTE')
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
