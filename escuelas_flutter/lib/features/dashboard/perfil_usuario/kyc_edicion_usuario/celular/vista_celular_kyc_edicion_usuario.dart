import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/perfil_usuario/bloc/bloc_perfil_usuario.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

class VistaCelularKyCEdicionUsuario extends StatefulWidget {
  const VistaCelularKyCEdicionUsuario({super.key});

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

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    final l10n = context.l10n;

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
              decoration: BoxDecoration(
                color: colores.tertiary,
                borderRadius: BorderRadius.circular(20.sw),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.ph,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 17.pw),
                      child: Text(
                        l10n.pageUserProfileKyCPersonalInformation
                            .toUpperCase(),
                        style: TextStyle(
                          color: colores.tertiary,
                          fontSize: 13.pf,
                        ),
                      ),
                    ),
                    const Divider(height: .5),
                    KyCTextfield(
                      texto: l10n.commonPhone,
                      textfield: EscuelasTextfield.soloNumero(
                        onChanged: (_) => context.read<BlocPerfilUsuario>().add(
                              BlocPerfilUsuarioEventoRecolectarDatosKyC(
                                telefono: controllerTelefono.text,
                              ),
                            ),
                        context: context,
                        hintText: '',
                        controller: controllerTelefono,
                      ),
                    ),
                    KyCTextfield(
                      texto: l10n.commonMail,
                      textfield: EscuelasTextfield.email(
                        controller: controllerMail,
                        context: context,
                        hintText: '',
                        onChanged: (_) => context.read<BlocPerfilUsuario>().add(
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
                            esPassword: false,
                            width: 147.pw,
                            hintText: '',
                            controller: controllerGrupoSanguineo,
                            onChanged: (_) =>
                                context.read<BlocPerfilUsuario>().add(
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
                            onChanged: (_) =>
                                context.read<BlocPerfilUsuario>().add(
                                      BlocPerfilUsuarioEventoRecolectarDatosKyC(
                                        edad: controllerEdad.text,
                                      ),
                                    ),
                            context: context,
                            hintText: '',
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
                        color: colores.tertiary,
                        fontSize: 10.pf,
                      ),
                    ),
                    KyCTextfield(
                      texto: l10n.commonName,
                      textfield: EscuelasTextfield(
                        hintText: '',
                        controller: controllerCENombre,
                        esPassword: false,
                        onChanged: (_) => context.read<BlocPerfilUsuario>().add(
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
                        hintText: '',
                        controller: controllerCEVinculo,
                        esPassword: false,
                        onChanged: (_) => context.read<BlocPerfilUsuario>().add(
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
                        hintText: '',
                        controller: controllerCETelefono,
                        context: context,
                        onChanged: (_) => context.read<BlocPerfilUsuario>().add(
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
                        controller: controllerCEMail,
                        context: context,
                        hintText: '',
                        onChanged: (_) => context.read<BlocPerfilUsuario>().add(
                              BlocPerfilUsuarioEventoRecolectarDatosKyC(
                                contactoEmergenciaMail: controllerCEMail.text,
                              ),
                            ),
                      ),
                    ),
                    KyCTextfield(
                      texto: l10n.commonObservations,
                      textfield: EscuelasTextfield(
                        hintText: '',
                        controller: controllerObservaciones,
                        esPassword: false,
                        onChanged: (_) => context.read<BlocPerfilUsuario>().add(
                              BlocPerfilUsuarioEventoRecolectarDatosKyC(
                                observaciones: controllerObservaciones.text,
                              ),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
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
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.pw),
          child: Text(
            texto,
            style: TextStyle(
              fontSize: 10.pf,
              color: colores.tertiary,
            ),
          ),
        ),
        textfield,
      ],
    );
  }
}
