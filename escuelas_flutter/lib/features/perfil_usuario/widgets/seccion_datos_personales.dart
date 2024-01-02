import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/perfil_usuario/bloc/bloc_perfil_usuario.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template SeccionDatosPersonales}
/// Seccion donde se muestran los datos personales de un usuario
/// {@endtemplate}
class DatosPersonales extends StatelessWidget {
  /// {@macro SeccionDatPersonales}
  const DatosPersonales({super.key});

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return Expanded(
      child: Container(
        width: 340.pw,
        padding: EdgeInsets.all(20.sw),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.sw),
          color: colores.tertiary,
        ),
        child: SingleChildScrollView(
          child: BlocBuilder<BlocPerfilUsuario, BlocPerfilUsuarioEstado>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.pageRoleAssigmentPersonalInformation.toUpperCase(),
                    style: TextStyle(
                      color: colores.onBackground,
                      fontSize: 16.pf,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 10.ph),
                  _DatoPersonal(
                    tipoDato: '${l10n.commonPhone}: ',
                    dato: state.usuario?.telefono.toString(),
                  ),
                  _DatoPersonal(
                    tipoDato: '${l10n.commonMail}: ',
                    dato: state.usuario?.email,
                  ),
                  SizedBox(height: 10.ph),
                  _DatoPersonal(
                    tipoDato: '${l10n.commonBloodFactor}: ',
                    dato: state.usuario?.factorSanguineo,
                  ),
                  _DatoPersonal(
                    tipoDato: '${l10n.commonAge}: ',
                    dato: state.usuario?.edad.toString(),
                  ),
                  SizedBox(height: 10.ph),
                  _DatoPersonal(
                    tipoDato: '${l10n.commonEmergencyContact}: ',
                  ),
                  _DatoPersonal(
                    tipoDato: '${l10n.commonBond}: ',
                  ),
                  SizedBox(height: 10.ph),
                  _DatoPersonal(
                    tipoDato: '${l10n.commonObservations}: ',
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

/// {@template DatoPersonal}
/// Widget que muestra el dato de un usuario
/// {@endtemplate}
class _DatoPersonal extends StatelessWidget {
  /// {@macro DatoPersonal}
  const _DatoPersonal({
    required this.tipoDato,
    this.dato,
  });

  /// Tipo de dato
  final String tipoDato;

  /// Valor del dato
  final String? dato;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return Row(
      children: [
        Text(
          tipoDato,
          style: TextStyle(
            color: colores.grisSC,
            fontSize: 14.pf,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          dato == null || dato == 'null' ? '*${l10n.commonNoData}*' : dato!,
          style: TextStyle(
            color: colores.grisDato,
            fontSize: 14.pf,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
