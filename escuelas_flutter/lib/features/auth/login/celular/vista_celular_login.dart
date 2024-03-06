import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/login/bloc/bloc_login.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
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

  void _onPressedLoginConGoogle() => context.read<BlocLogin>().add(
        const BlocLoginEventoIniciarSesionConGoogle(),
      );

  void _habilitarBoton() => context.read<BlocLogin>().add(
        BlocLoginEventoHabilitarBotonIngresar(
          dni: controllerDNI.text,
          password: controllerPassword.text,
        ),
      );

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
          // TODO(Anyone): Mostrar dialog de aviso solicitud rechazada y
          // redireccion a KYC.
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

        return SafeArea(
          child: Stack(
            fit: StackFit.expand,
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Positioned(
                top: 20.ph,
                right: 10.pw,
                child: GestureDetector(
                  onTap: () => context.router.push(const RutaRegistro()),
                  child: Text(
                    l10n.pageRegisterTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colores.onBackground,
                      fontSize: 18.pf,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 60.ph,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.ph),
                      child: Text(
                        l10n.commonWelcome,
                        style: TextStyle(
                          color: colores.onBackground,
                          fontSize: 24.pf,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Text(
                      l10n.pageLoginCredentialsIndicativeText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colores.onBackground,
                        fontSize: 13.pf,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.pw),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 50.ph),
                      height: 70.sh,
                      width: 70.sw,
                      decoration: BoxDecoration(color: colores.secondary),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.ph),
                      child: EscuelasTextfield.soloNumero(
                        onChanged: (_) => _habilitarBoton(),
                        controller: controllerDNI,
                        hintText: l10n.commonDNI,
                        context: context,
                      ),
                    ),
                    EscuelasTextFieldPassword(
                      onValidate: (value) {},
                      controller: controllerPassword,
                      onChanged: (_) => _habilitarBoton(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.ph),
                      child: EscuelasBoton.texto(
                        estaHabilitado: state.botonIngresarHabilitado,
                        // TODO(Manu): agregar funcion cuando exista el endpoint
                        onTap: () {},
                        color: colores.primary,
                        texto: l10n.commonLogIn.toUpperCase(),
                        context: context,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.ph),
                      child: Text(
                        l10n.pageLoginTextOr,
                        style: TextStyle(
                          color: colores.onBackground,
                          fontSize: 14.pf,
                        ),
                      ),
                    ),
                    EscuelasBoton.loginGoogle(
                      texto: l10n.pageLoginLoginWithGoogle,
                      onTap: _onPressedLoginConGoogle,
                      context: context,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10.ph),
                  child: Text(
                    l10n.pageLoginTextAllRightsReserved,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
