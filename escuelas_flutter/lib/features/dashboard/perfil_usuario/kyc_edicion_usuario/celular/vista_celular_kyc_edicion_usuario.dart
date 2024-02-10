import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/perfil_usuario/bloc/bloc_perfil_usuario.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/escuelas_boton.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularKyCEdicionUsuario}
/// Vista celular de la pantalla 'KYC Edicion usuario'
/// {@endtemplate}
class VistaCelularKyCEdicionUsuario extends StatefulWidget {
  /// {@macro VistaCelularKyCEdicionUsuario}
  const VistaCelularKyCEdicionUsuario({
    // required this.idUsuario,
    super.key,
  });

  /// id del usuario
  // final int idUsuario;

  @override
  State<VistaCelularKyCEdicionUsuario> createState() =>
      _VistaCelularKyCEdicionUsuarioState();
}

class _VistaCelularKyCEdicionUsuarioState
    extends State<VistaCelularKyCEdicionUsuario> {
  /// Controller del telefono del usuario
  final controllerTelefono = TextEditingController();

  /// Controller del mail del usuario
  final controllerMail = TextEditingController();

  /// Controller del textfield del grupo sanguineo del usuario
  final controllerGrupoSanguineo = TextEditingController();

  /// Controller del textfield de la edad del usuario
  final controllerEdad = TextEditingController();

  /// Controller del textfield del nombre del Contacto de Emergencia
  final controllerCENombre = TextEditingController();

  /// Controller del textfield del parentesco del Contacto de Emergencia
  final controllerCEVinculo = TextEditingController();

  /// Controller del textfield del telefono del Contacto de Emergencia
  final controllerCETelefono = TextEditingController();

  /// Controller del textfield del mail del Contacto de Emergencia
  final controllerCEMail = TextEditingController();

  /// Controller del textfield de las observaciones
  final controllerObservaciones = TextEditingController();

  // @override
  // void initState() {
  //   final state = context.read<BlocPerfilUsuario>().state;

  //   controllerTelefono.text = state.usuario.numerosDeTelefono?.first ?? '';
  //   controllerMail.text = state.usuario.direccionesDeEmail.first ?? '';
  //   controllerGrupoSanguineo.text = state.usuario. ?? '';
  //   controllerEdad.text = state.usuario. ?? '';
  //   controllerCENombre.text = state.usuario. ?? '';
  //   controllerCEVinculo.text = state.usuario. ?? '';
  //   controllerCETelefono.text = state.usuario. ?? '';
  //   controllerCEMail.text = state.usuario. ?? '';
  //   controllerObservaciones.text = state.usuario. ?? '';

  //   super.initState();
  // }

  @override
  void dispose() {
    controllerTelefono.dispose();
    controllerMail.dispose();
    controllerGrupoSanguineo.dispose();
    controllerEdad.dispose();
    controllerCENombre.dispose();
    controllerCEVinculo.dispose();
    controllerCETelefono.dispose();
    controllerCEMail.dispose();
    super.dispose();
  }

  /// Muestra dialog para permitirle al usuario guardar los cambios.
  Future<void> _showDialogGuardarCambios(BuildContext context) {
    final usuario = context.read<BlocPerfilUsuario>().state.usuario;
    final l10n = context.l10n;

    return showDialog<void>(
      context: context,
      builder: (_) => EscuelasDialog.solicitudDeAccion(
        onTapConfirmar: () {
          context
              .read<BlocPerfilUsuario>()
              .add(BlocPerfilUsuarioEventoInsertarInformacionDeKyc());
          _showDialogUsuarioEditado;
        },
        content: Text(
          '${l10n.pageUserProfileKyCConfirmationSaveChanges} ${usuario?.nombre ?? ''} ${usuario?.apellido ?? ''}?',
        ),
        context: context,
      ),
    );
  }

  /// Dialog que notifica que el usuario ha sido editado exitosamente
  Future<void> _showDialogUsuarioEditado(BuildContext context) {
    final l10n = context.l10n;
    final usuario = context.read<BlocPerfilUsuario>().state.usuario;

    return showDialog<void>(
      context: context,
      builder: (_) => EscuelasDialog.exitoso(
        context: context,
        onTap: () =>
            context.router.push(RutaPerfilUsuario(idUsuario: usuario?.id ?? 0)),
        content: Text(l10n.pageUserProfileKyCSuccessfulEdition),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    final l10n = context.l10n;

    InputDecoration decoration(String hintText, [double? height]) =>
        InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.sw),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            height: height ?? 1.7,
            color: colores.onBackground,
            fontWeight: FontWeight.w500,
            fontSize: 8.pf,
          ),
        );

    return BlocBuilder<BlocPerfilUsuario, BlocPerfilUsuarioEstado>(
      builder: (context, state) {
        if (state is BlocPerfilUsuarioEstadoCargando) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          children: [
            Container(
              width: 349.pw,
              height: max(550.ph, 550.sh),
              decoration: BoxDecoration(
                color: colores.tertiary,
                borderRadius: BorderRadius.circular(20.sw),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.ph,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 17.pw),
                      child: Text(
                        l10n.pageUserProfileKyCPersonalInformation
                            .toUpperCase(),
                        style: TextStyle(
                          color: colores.onBackground,
                          fontWeight: FontWeight.w900,
                          fontSize: 13.pf,
                        ),
                      ),
                    ),
                    SizedBox(height: max(15.ph, 15.sh)),
                    const Divider(height: .5),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.pw),
                      child: SizedBox(
                        height: max(475.sh, 475.ph),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KyCTextfield(
                              texto: l10n.commonPhone,
                              textfield: EscuelasTextfield.soloNumero(
                                tieneBorde: true,
                                height: max(30.sh, 30.ph),
                                onChanged: (_) =>
                                    context.read<BlocPerfilUsuario>().add(
                                          BlocPerfilUsuarioEventoRecolectarDatosKyC(
                                            telefono: controllerTelefono.text,
                                          ),
                                        ),
                                context: context,
                                hintText: l10n.commonPhone,
                                fontHintText: 10.pf,
                                controller: controllerTelefono,
                              ),
                            ),
                            KyCTextfield(
                              texto: l10n.commonMail,
                              textfield: EscuelasTextfield.email(
                                tieneBorde: true,
                                height: max(30.sh, 30.ph),
                                controller: controllerMail,
                                context: context,
                                hintText: l10n.commonMail,
                                fontHintText: 10.pf,
                                onChanged: (_) =>
                                    context.read<BlocPerfilUsuario>().add(
                                          BlocPerfilUsuarioEventoRecolectarDatosKyC(
                                            mail: controllerMail.text,
                                          ),
                                        ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                KyCTextfield(
                                  texto: l10n.commonBloodFactor,
                                  textfield: EscuelasTextfield(
                                    height: max(30.sh, 30.ph),
                                    decoration:
                                        decoration(l10n.commonBloodFactor),
                                    esPassword: false,
                                    width: 147.pw,
                                    controller: controllerGrupoSanguineo,
                                    fontHintText: 10.pf,
                                    onChanged: (_) => context
                                        .read<BlocPerfilUsuario>()
                                        .add(
                                          BlocPerfilUsuarioEventoRecolectarDatosKyC(
                                            factorSanguineo:
                                                controllerGrupoSanguineo.text,
                                          ),
                                        ),
                                  ),
                                ),
                                SizedBox(width: 7.pw),
                                KyCTextfield(
                                  texto: l10n.commonAge,
                                  textfield: EscuelasTextfield.soloNumero(
                                    tieneBorde: true,
                                    height: max(30.sh, 30.ph),
                                    onChanged: (_) =>
                                        context.read<BlocPerfilUsuario>().add(
                                              BlocPerfilUsuarioEventoRecolectarDatosKyC(
                                                edad: controllerEdad.text,
                                              ),
                                            ),
                                    context: context,
                                    hintText: l10n.commonAge,
                                    fontHintText: 10.pf,
                                    width: 147.pw,
                                    controller: controllerEdad,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: max(15.ph, 15.sh)),
                            Text(
                              l10n.pageUserProfileKyCEmergencyContact,
                              style: TextStyle(
                                color: colores.onBackground,
                                fontWeight: FontWeight.w900,
                                fontSize: 10.pf,
                              ),
                            ),
                            KyCTextfield(
                              texto: l10n.commonName,
                              textfield: EscuelasTextfield(
                                height: max(30.sh, 30.ph),
                                decoration: decoration(l10n.commonName),
                                controller: controllerCENombre,
                                fontHintText: 10.pf,
                                esPassword: false,
                                onChanged: (_) =>
                                    context.read<BlocPerfilUsuario>().add(
                                          BlocPerfilUsuarioEventoRecolectarDatosKyC(
                                            contactoEmergenciaNombre:
                                                controllerCENombre.text,
                                          ),
                                        ),
                              ),
                            ),
                            KyCTextfield(
                              texto: l10n.commonBond,
                              textfield: EscuelasTextfield(
                                height: max(30.sh, 30.ph),
                                decoration: decoration(l10n.commonBond),
                                fontHintText: 10.pf,
                                controller: controllerCEVinculo,
                                esPassword: false,
                                onChanged: (_) =>
                                    context.read<BlocPerfilUsuario>().add(
                                          BlocPerfilUsuarioEventoRecolectarDatosKyC(
                                            contactoEmergenciaVinculo:
                                                controllerCEVinculo.text,
                                          ),
                                        ),
                              ),
                            ),
                            KyCTextfield(
                              texto: l10n.commonPhone,
                              textfield: EscuelasTextfield.soloNumero(
                                fontHintText: 10.pf,
                                tieneBorde: true,
                                height: max(30.sh, 30.ph),
                                hintText: l10n.commonPhone,
                                controller: controllerCETelefono,
                                context: context,
                                onChanged: (_) =>
                                    context.read<BlocPerfilUsuario>().add(
                                          BlocPerfilUsuarioEventoRecolectarDatosKyC(
                                            contactoEmergenciaTelefono:
                                                controllerCETelefono.text,
                                          ),
                                        ),
                              ),
                            ),
                            KyCTextfield(
                              texto: l10n.commonMail,
                              textfield: EscuelasTextfield.email(
                                tieneBorde: true,
                                height: max(30.sh, 30.ph),
                                fontHintText: 10.pf,
                                controller: controllerCEMail,
                                context: context,
                                hintText: l10n.commonMail,
                                onChanged: (_) =>
                                    context.read<BlocPerfilUsuario>().add(
                                          BlocPerfilUsuarioEventoRecolectarDatosKyC(
                                            contactoEmergenciaMail:
                                                controllerCEMail.text,
                                          ),
                                        ),
                              ),
                            ),
                            KyCTextfield(
                              texto: l10n.commonObservations,
                              textfield: EscuelasTextfield(
                                height: max(45.sh, 45.ph),
                                decoration:
                                    decoration(l10n.commonObservations, 2.5),
                                maxLines: 3,
                                controller: controllerObservaciones,
                                esPassword: false,
                                onChanged: (_) =>
                                    context.read<BlocPerfilUsuario>().add(
                                          BlocPerfilUsuarioEventoRecolectarDatosKyC(
                                            observaciones:
                                                controllerObservaciones.text,
                                          ),
                                        ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: max(10.ph, 10.sh)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EscuelasBoton.texto(
                  estaHabilitado: true,
                  onTap: () => _showDialogGuardarCambios,
                  color: colores.verdeConfirmar,
                  texto: l10n.commonSaveChanges,
                  fontSize: 12.pf,
                  context: context,
                ),
                SizedBox(width: 8.pw),
                EscuelasBoton.outlined(
                  onTap: () => context.router.push(
                    RutaPerfilUsuario(idUsuario: state.usuario?.id ?? 0),
                  ),
                  context: context,
                  estaHabilitado: true,
                  color: colores.verdeConfirmar,
                  texto: l10n.commonBack,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

/// {@template KyCTextfield}
/// Widget custom para el armado del kyc
/// {@endtemplate}
class KyCTextfield extends StatelessWidget {
  /// {@macro KyCTextfield}
  const KyCTextfield({
    required this.texto,
    required this.textfield,
    super.key,
  });

  /// Texto titulo del textfield
  final String texto;

  /// Textfield a recibir
  final Widget textfield;
  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.pw),
          child: Text(
            texto,
            style: TextStyle(
              fontSize: 10.pf,
              color: colores.onBackground,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        textfield,
      ],
    );
  }
}
