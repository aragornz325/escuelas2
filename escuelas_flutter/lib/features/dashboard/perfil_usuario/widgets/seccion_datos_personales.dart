import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/perfil_usuario/bloc/bloc_perfil_usuario.dart';
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
  const DatosPersonales({
    this.usuarioPendiente,
    super.key,
  });

  /// Usuario pendiente a mostrar informacion.
  final UsuarioPendiente? usuarioPendiente;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20.pw,
        vertical: 10.ph,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50.sw)),
        color: colores.tertiary,
      ),
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Text(
          l10n.pageRoleAssigmentPersonalInformationText.toUpperCase(),
          style: TextStyle(
            color: colores.onBackground,
            fontSize: 13.pf,
            fontWeight: FontWeight.w700,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.sw),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.sw),
        ),
        backgroundColor: colores.tertiary,
        children: <Widget>[
          Divider(
            height: .5,
            thickness: .5,
            color: colores.grisSC,
          ),
          if (usuarioPendiente != null)
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.sw),
                  bottomRight: Radius.circular(20.sw),
                ),
              ),
              title: Column(
                children: [
                  SizedBox(height: 10.ph),
                  _DatoPersonal(
                    tipoDato: '${l10n.commonDNI}: ',
                    dato: usuarioPendiente?.dni ?? '',
                  ),
                  SizedBox(height: 10.ph),
                  _DatoPersonal(
                    tipoDato: '${l10n.commonEmergencyContact}: ',
                  ),
                  SizedBox(height: 10.ph),
                  _DatoPersonal(
                    tipoDato: '${l10n.commonBond}: ',
                  ),
                  SizedBox(height: 10.ph),
                  _DatoPersonal(
                    tipoDato: '${l10n.commonObservations}: ',
                  ),
                  SizedBox(height: 10.ph),
                  _DatoPersonal(
                    tipoDato: '${l10n.commonMail}: ',
                  ),
                ],
              ),
            )
          else
            ListTile(
              title: BlocBuilder<BlocPerfilUsuario, BlocPerfilUsuarioEstado>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.ph),
                      ...state.numerosDeTelefono.map(
                        (numero) => _DatoPersonal(
                          tipoDato: '${l10n.commonPhone} -'
                              ' ${numero.tipoDeTelefono.name}: ',
                          dato: numero.numeroDeTelefono,
                        ),
                      ),
                      _DatoPersonal(
                        tipoDato: '${l10n.commonMail}: ',
                        dato: state.direccionesDeEmail
                            .map((e) => e.direccionDeEmail)
                            .toList()
                            .join(', '),
                      ),
                      SizedBox(height: 10.ph),
                      _DatoPersonal(
                        tipoDato: '${l10n.commonDNI}: ',
                        dato: state.dniUsuario,
                      ),
                      SizedBox(height: 10.ph),
                      _DatoPersonal(
                        tipoDato: '${l10n.commonEmergencyContact}: ',
                      ),
                      SizedBox(height: 10.ph),
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.sw),
                  bottomRight: Radius.circular(20.sw),
                ),
              ),
            ),
        ],
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

    return Wrap(
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
          dato == null || dato == 'null' || dato == ''
              ? '*${l10n.commonNoData}*'
              : dato!,
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
