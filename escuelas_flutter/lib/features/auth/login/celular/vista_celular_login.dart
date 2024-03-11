import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/login/bloc/bloc_login.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/utilidades/funciones/expresion_regular.dart';
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
  final _controllerDniOEmail = TextEditingController();

  /// Controller para el textfield de contraseña
  final _controllerPassword = TextEditingController();

  bool get emailODNIValido =>
      ExpresionesRegulares.numerosUnicamente.hasMatch(_controllerDniOEmail.text)
          ? _controllerDniOEmail.text.length >= 7
          : ExpresionesRegulares.email.hasMatch(
              _controllerDniOEmail.text,
            );

  @override
  void dispose() {
    _controllerDniOEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  bool? contraseniaValido;
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
        if (state is BlocLoginEstadoCargando) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.ph)
                        .copyWith(right: 20.pw),
                    child: Align(
                      alignment: Alignment.centerRight,
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
                  ),
                  Column(
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.pw),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 50.ph),
                          height: 70.sh,
                          width: 70.sw,
                          decoration: BoxDecoration(color: colores.secondary),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.ph),
                          child: EscuelasTextfield.letrasYNumerosConIcono(
                            onChanged: (value) => setState(() {}),
                            onValidate: (value) {},
                            controller: _controllerDniOEmail,
                            hintText: l10n.commonDNI,
                            suffixIcon: Icon(
                              Icons.person_outline,
                              color: colores.grisDato,
                            ),
                            backgroundColor: state
                                    is! BlocLoginEstadoErrorAlLogearseConCredenciales
                                ? colores.tertiary
                                : colores.error.withOpacity(.3),
                            context: context,
                          ),
                        ),
                        EscuelasTextFieldPassword(
                          onValidate: (value) => contraseniaValido = value,
                          controller: _controllerPassword,
                          onChanged: (value) => setState(() {}),
                          backgroundColor: state
                                  is! BlocLoginEstadoErrorAlLogearseConCredenciales
                              ? colores.tertiary
                              : colores.error.withOpacity(.3),
                        ),
                        if (state
                            is BlocLoginEstadoErrorAlLogearseConCredenciales)
                          Text(
                            l10n.pageLoginIncorrectCredentials,
                            style: TextStyle(
                              color: colores.error,
                              fontSize: 14.pf,
                            ),
                          ),
                        if (emailODNIValido)
                          Row(
                            children: [
                              Text(
                                l10n.pageLoginRecoverPassword,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: colores.grisDato,
                                  fontSize: 14.pf,
                                ),
                              ),
                            ],
                          ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 30.ph),
                          child: EscuelasBoton.texto(
                            estaHabilitado: emailODNIValido,
                            onTap: () => context.read<BlocLogin>().add(
                                  BlocLoginEventoIniciarSesionConCredenciales(
                                    dniOEmail: _controllerDniOEmail.text,
                                    password: _controllerPassword.text,
                                  ),
                                ),
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
                          onTap: () => context.read<BlocLogin>().add(
                                const BlocLoginEventoIniciarSesionConGoogle(),
                              ),
                          context: context,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.ph),
                child: Text(
                  l10n.pageLoginTextAllRightsReserved,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
