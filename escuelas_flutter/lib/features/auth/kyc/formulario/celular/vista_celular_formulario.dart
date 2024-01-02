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

    return BlocBuilder<BlocKyc, BlocKycEstado>(
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
    );
  }
}
