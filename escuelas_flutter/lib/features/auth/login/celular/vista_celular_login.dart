import 'dart:math';

import 'package:auto_route/auto_route.dart';

import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/login/bloc/bloc_login.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';

import 'package:escuelas_flutter/widgets/escuelas_boton.dart';

import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularLogin}
/// Vista de celular de la pantalla de login
/// {@endtemplate}
class VistaCelularLogin extends StatefulWidget {
  /// {@macro VistaCelularLogin}
  const VistaCelularLogin({super.key});

  @override
  State<VistaCelularLogin> createState() => _VistaCelularLoginState();
}

class _VistaCelularLoginState extends State<VistaCelularLogin> {
  /// Controller para el textfield de dni
  final controllerDNI = TextEditingController();

  /// Controller para el textfield de contraseña
  final controllerPassword = TextEditingController();

  @override
  void dispose() {
    controllerDNI.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  void _onPressedLoginConGoogle() {
    context.read<BlocLogin>().add(
          const BlocLoginEventoIniciarSesionConGoogle(),
        );
  }

  void _habilitarBoton() {
    context.read<BlocLogin>().add(
          BlocLoginEventoHabilitarBotonIngresar(
            dni: controllerDNI.text,
            password: controllerPassword.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return BlocConsumer<BlocLogin, BlocLoginEstado>(
      listener: (context, state) {
        if (state is BlocLoginEstadoFaltaCompletarKyc) {
          context.replaceRoute(const RutaKyc());
        }

        if (state is BlocLoginEstadoSolicitudPendiente) {
          context.replaceRoute(const RutaEspera());
        }

        if (state is BlocLoginEstadoSolicitudAceptada) {
          context.replaceRoute(
            RutaDashboard(
              usuario: state.usuario,
              userInfo: state.userInfo,
            ),
          );
        }

        if (state is BlocLoginEstadoSolicitudRechazada) {
          // TODO(SAM): Mostrar dialog de aviso solicitud rechazada y redireccion a KYC.
          context.replaceRoute(const RutaKyc());
        }
      },
      builder: (context, state) {
        if (state is BlocLoginEstadoCargando &&
            state.estaIniciandoSesion == false) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 80.ph),
                Text(
                  l10n.commonWelcome,
                  style: TextStyle(
                    color: colores.onBackground,
                    fontSize: 24.pf,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.ph),
                Text(
                  l10n.pageLoginCredentialsIndicativeText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colores.onBackground,
                    fontSize: 13.pf,
                  ),
                ),
                SizedBox(height: 55.ph),
                Container(
                  height: max(50.ph, 50.sh),
                  width: 50.pw,
                  decoration: BoxDecoration(color: colores.grisSC),
                ),
                SizedBox(height: 35.ph),
                EscuelasTextfield.soloNumero(
                  onChanged: (_) => _habilitarBoton(),
                  controller: controllerDNI,
                  hintText: l10n.commonDNI,
                  context: context,
                ),
                SizedBox(height: 15.ph),
                EscuelasTextFieldPassword(
                  controller: controllerPassword,
                  onChanged: (_) => _habilitarBoton(),
                ),
                SizedBox(height: 30.ph),
                EscuelasBoton.texto(
                  estaHabilitado: state.botonIngresarHabilitado,
                  onTap: () {
                    // TODO(Manu): agregar funcion cuando exista el endpoint
                  },
                  color: colores.primary,
                  texto: l10n.commonLogIn.toUpperCase(),
                  context: context,
                ),
                SizedBox(height: 30.ph),
                Text(
                  l10n.pageLoginTextOr,
                  style: TextStyle(
                    color: colores.onBackground,
                    fontSize: 10.pf,
                  ),
                ),
                SizedBox(height: 30.ph),
                EscuelasBoton.loginGoogle(
                  onTap: _onPressedLoginConGoogle,
                  context: context,
                ),
                SizedBox(height: 170.ph),
                Text(
                  l10n.pageLoginTextAllRightsReserved,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30.ph),
              ],
            ),
          ),
        );
      },
    );
  }
}
